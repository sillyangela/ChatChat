//
//  WelcomeViewController.swift
//  ChatChat
//
//  Created by Angela Zhang on 8/22/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var rpasswordTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print("login pressed")
        dissmissKeyboard()
       
        
        if emailTextField.text != "" && passwordTextfield.text != "" {
            loginUser()
        } else {
            ProgressHUD.showError("Please enter your email address and password to log in!")
        }
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        print("register pressed")
        dissmissKeyboard()
        
        if emailTextField.text != "" && passwordTextfield.text != "" && rpasswordTextfield.text != ""{
            if passwordTextfield.text!.count<8 {
                ProgressHUD.showError("Password is too short!")
            }else if passwordTextfield.text! == rpasswordTextfield.text!{
                
                registerUser()
            }else{
                ProgressHUD.showError("Passwords don't match!")
            }
            
        } else {
            ProgressHUD.showError("All fields required!")
        }
    
        
        
        
    }
    @IBAction func bgtapped(_ sender: Any) {
        print("bg pressed")
        dissmissKeyboard()
        
    }
    //MARK: Helper Functions
    func dissmissKeyboard(){
        self.view.endEditing(false);
    }
    
    func cleanTextFields(){
        emailTextField.text = "";
        passwordTextfield.text = "";
        rpasswordTextfield.text = "";
        print("text fields cleaned");
    }
    
    func loginUser(){
        print("Status: logging in")
        ProgressHUD.show("Loging in ... ")
        FUser.loginUserWith(email: emailTextField.text!, password: passwordTextfield.text!)
        {
            (error) in
            
            //if there is an error
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }else{
                //if there is no error, show the chat
                self.startApp()
            }
            
        }
        
    }
    func registerUser(){
        print("registering")
        
        performSegue(withIdentifier: "welcomeTofinishReg", sender: self)
        
        cleanTextFields()
    }
    //MARK: StartApp
    func startApp(){
        ProgressHUD.dismiss()
        cleanTextFields()
        
        //display chat
        //... yet to come
    }
    
    
    //MARK: Navigation through vcs
    
    override func prepare(for segue:UIStoryboardSegue,  sender: Any?){
        if segue.identifier == "welcomeTofinishReg"{
            //create a new instance of the next view controller we want to transfer to
            let vc = segue.destination as! FinishRegistrationViewController
            
            vc.email = emailTextField.text!
            vc.password = passwordTextfield.text!
        }
    }
}
