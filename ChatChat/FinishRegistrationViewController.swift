//
//  FinishRegistrationViewController.swift
//  ChatChat
//
//  Created by Angela Zhang on 8/25/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//

import UIKit

class FinishRegistrationViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    var email : String = ""
    var password : String = ""
    
    
    
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
}
