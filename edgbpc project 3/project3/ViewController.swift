//
//  ViewController.swift
//  project3
//
//  Created by Eric Goodwin on 6/26/17.
//  Copyright © 2017 umsl. All rights reserved.
//


//extra credit log:
//loading screen added
//email format validation added.  uses regular expression
//2nd view controller with segue added for validation rules
//icons next to text fields for visual clue if entry meets validation rule.
//can click on the icons to segue to a new viewcontroller that displays the rule
//UINavigation embed added
//password obfuscation added in textfieldview display
//reset button added to clear


import UIKit

class ViewController: UIViewController {
    
    //creates an object of the database model
    var userRegistration = dbaseModel()
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phonenumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var dbaseField: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var usernameIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var phoneNumberIcon: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        addButton.isEnabled = false //disable add button on load
        
        //assign delegates
        nameField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        phonenumberField.delegate = self
        emailField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedBackground(_:)))
        view.addGestureRecognizer(tap)
        

        
    }
  
    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
       
        userRegistration.setNameField(sender.text ?? "")
        if (userRegistration.validateAllFields()){
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
            nameIcon.image = UIImage(named: "redcaution")
        }
        if userRegistration.nameFieldValidated == true{
            nameIcon.image = UIImage(named: "checked-checkbox-512")
        }
    }
    

    
    @IBAction func usernameTextFieldDidChange(_ sender: UITextField) {
        
        userRegistration.setUserNameField(sender.text ?? "")
        
        if (userRegistration.validateAllFields()){
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
            usernameIcon.image = UIImage(named: "redcaution")
        }
        
        if userRegistration.userNameFieldValidated == true{
            usernameIcon.image = UIImage(named: "checked-checkbox-512")
        }
    }
    
    @IBAction func passwordTextFieldDidChange(_ sender: UITextField) {

        userRegistration.setPassWordField(sender.text ?? "")
        
        if (userRegistration.validateAllFields()){
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
            passwordIcon.image = UIImage(named: "redcaution")
        }
        if userRegistration.passwordFieldValidated == true{
            passwordIcon.image = UIImage(named: "checked-checkbox-512")
        }
        
        
    }
    
    @IBAction func emailTextFieldDidChange(_ sender: UITextField) {

        userRegistration.setEmailField(sender.text ?? "")
        
        if (userRegistration.validateAllFields()){
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
            emailIcon.image = UIImage(named: "redcaution")
        }
        
        if userRegistration.emailFieldValidated == true{
            emailIcon.image = UIImage(named: "checked-checkbox-512")
        }
    }
    
    @IBAction func phonenumberTextFieldDidChange(_ sender: UITextField) {

        userRegistration.setPhoneNumberField(sender.text ?? "")
        
        if (userRegistration.validateAllFields()){
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
            phoneNumberIcon.image = UIImage(named: "redcaution")
        }
        
        if userRegistration.phonenumberFieldValidated == true{
            phoneNumberIcon.image = UIImage(named: "checked-checkbox-512")
        }
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        userRegistration.buildDbase()
        dbaseField.text = userRegistration.displayDbase()
        
        clearFields()
    }
   
    //reset does not clear data from the UITextView database output intentionally.  Reset button meant to simulate front facing interface option for the user to clear the data for the entry they are currently working on.  
    @IBAction func resetButton(_ sender: Any) {
        clearFields()
        dbaseField.text = ""

    }
    
    func clearFields(){
        //clear out text fields
        nameField.text = ""
        usernameField.text = ""
        passwordField.text = ""
        phonenumberField.text = ""
        emailField.text = ""
        
        
        //clears values already passed to the model
        userRegistration.clearAllValues()
        
        //clears images
        nameIcon.image = UIImage(named: "")
        usernameIcon.image = UIImage(named: "")
        passwordIcon.image = UIImage(named: "")
        phoneNumberIcon.image = UIImage(named: "")
        emailIcon.image = UIImage(named: "")
        
        //disable add button
        addButton.isEnabled = false
        
    }
    
    //transitions to rulesViewController
    @IBAction func rulesButton(_ sender: UIButton) {
        performSegue(withIdentifier: "rulesSegue", sender: sender)
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tappedBackground(_ sender: UITapGestureRecognizer) {
        phonenumberField.resignFirstResponder()

    }
    
    


    
//unused. keeping for future use
//    func errorCheck(_ message: String){
//        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
//        alert.addAction(defaultAction)
//        
//        self.present(alert, animated: true, completion: nil)
//        
//    }
//    
    
    
}



extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



