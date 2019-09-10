//
//  FinishRegistrationViewController.swift
//  ChatChat
//
//  Created by Angela Zhang on 8/25/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//

import UIKit
import ProgressHUD

class FinishRegistrationViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    var email : String = ""
    var password : String = ""
    var userImage : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: IB Actions

    @IBAction func cancelPressed(_ sender: Any) {
        dismissKeyboard()
        cleanTextFields()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        dismissKeyboard()
        ProgressHUD.show("Registering...")
        
        //check the text fields
        if firstNameTextField.text != "" && lastNameTextField.text != "" && phoneTextField.text != "" && cityTextField.text != "" && countryTextField.text != ""{
            
            FUser.registerUserWith(email: email, password: password, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!) { (error) in
                
                //if there is an error
                if error != nil{
                    ProgressHUD.dismiss()
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }else{
                    //if there is not error
                    self.registerUser()
                }
            }
            
        } else {
            ProgressHUD.showError("All fields required!")
        }
        
        
    }
    //MARK: Helper Functions
    func dismissKeyboard(){
        self.view.endEditing(false);
    }
    
    func cleanTextFields(){
        firstNameTextField.text = "";
        lastNameTextField.text = "";
        phoneTextField.text = "";
        cityTextField.text = "";
        countryTextField.text = "";
        
        print("text fields cleaned");
    }
    
    func finishRegistration(withValues: [String : Any ]){
        updateCurrentUserInFirestore(withValues: withValues) {
            (error) in
            
            //if there is an error
            if error != nil{
                DispatchQueue.main.async {
                    ProgressHUD.showError(error!.localizedDescription)
                    print(error!.localizedDescription )
                }
                return
            }
            
            ProgressHUD.dismiss()
            
            //go to the main chat app when finish registration
            
            self.startApp()
            
            
        }
    }
    func startApp(){
        ProgressHUD.dismiss()
        cleanTextFields()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION),object: nil, userInfo: [kUSERID : FUser.currentId()])
        
        //create an instance of main application
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApp") as! UITabBarController
        
        self.present(mainView, animated: true, completion: nil)
        
        
    }
    func registerUser(){
        let fullName = firstNameTextField.text! + " " + lastNameTextField.text!
        
        var tempDictionary : Dictionary = [kFIRSTNAME : firstNameTextField.text!, kLASTNAME : lastNameTextField.text!, kFULLNAME : fullName , kPHONE : phoneTextField.text!, kCITY : cityTextField.text!, kCOUNTRY : countryTextField.text!] as [String : Any]
        
        //see if the user has chosen an avatar
        if (userImage == nil){
            //create an avatar image based on the initial of the user
            //function written already in helpers functions file
            imageFromInitials(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!) { (avatarInitials) in
                
                //returns a variable named avatarInitials, which is a UIImage
                //do something with it
                
                
                //converted what is returned into data
                //this variable is a data
                let avatarImage = avatarInitials.jpegData(compressionQuality: 1.0)
                
                //then convert it to a string, whihc can then be stored into firebase
                let avatar = avatarImage!.base64EncodedData(options: Data.Base64EncodingOptions(rawValue: 0))
            
                tempDictionary[kAVATAR] = avatar
                
                //end of registration step
                //save it locally and save it on firestore
                self.finishRegistration(withValues: tempDictionary)

                
            }
        }else{
            //if the user chooses an avatar for themselves
            //we do not have to create the avatar image like above, because the user has put one there, we just have to convert it to data
            
            //convert user input image into data so we can put it in to firebase
            let avatarImage = userImage?.jpegData(compressionQuality: 1.0)
            
            //convert it to a string like above
            let avatar = avatarImage!.base64EncodedData(options: Data.Base64EncodingOptions(rawValue: 0))
            
            tempDictionary[kAVATAR] = avatar
            
            //end of registration step
            //save it locally and save it on firestore
            self.finishRegistration(withValues: tempDictionary)
        }
        
        
    }
}
