//
//  WelcomeViewController.swift
//  ChatChat
//
//  Created by Angela Zhang on 8/22/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//

import UIKit

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
        cleanTextFields()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        print("register pressed")
        dissmissKeyboard()
        cleanTextFields()
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
}
