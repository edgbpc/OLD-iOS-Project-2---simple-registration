//
//  Model.swift
//  project3
//
//  Created by Eric Goodwin on 6/26/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import Foundation
import UIKit

struct dbaseEntry {
    var name: String
    var userName: String
    var passwordField: String
    var phonenumberField: String
    var emailField: String
    
    init (){
        name = ""
        userName = ""
        passwordField = ""
        phonenumberField = ""
        emailField = ""
     
    }
    
    func getName(){
        print(name)
    }
}



//struct was sufficient for this project.  class unneccesary
    struct dbaseModel {
    
    //creates a single database entry.  used to validate
    var entry = dbaseEntry()
    
    //creates an array of database entries.  as validation passed, the entry  is added
    var database = [dbaseEntry]()
    
   
    //flags used by validation functions.  flips to true if validation passes
    //switches back to false if a change in a field causes validation to no longer be valid
    var nameFieldValidated: Bool = false
    var userNameFieldValidated: Bool = false
    var passwordFieldValidated: Bool = false
    var phonenumberFieldValidated: Bool = false
    var emailFieldValidated: Bool = false
    
    var allFieldsValidated: Bool = false

    
    //next series of functions used to assign each field to the entry struct
    mutating func setNameField(_ input: String){
        entry.name = input
    
    }
    
    mutating func setUserNameField(_ input: String){
        entry.userName = input
    }
    
    mutating func setPassWordField(_ input: String){
        entry.passwordField = input
    }
    
    mutating func setPhoneNumberField(_ input: String){
        entry.phonenumberField = input
    }
    
    mutating func setEmailField(_ input: String){
        entry.emailField = input
    }

    
    //series of validation functions for each field.
    mutating func validateNameMinLength(){
        if entry.name.characters.count < 3 {
            nameFieldValidated = false
          
         } else {
             nameFieldValidated = true
        }
    }
    
    mutating func validateUserNameMinLength(){
        if entry.userName.characters.count < 3 {
            userNameFieldValidated = false
        } else {
            userNameFieldValidated = true

        }
    }
    
    
    mutating func validateMinLenthforPassword(){
        if entry.passwordField.characters.count < 7 {
            passwordFieldValidated = false
        } else {
            passwordFieldValidated = true

        }
    }
    
    mutating func validatePhonenumberIsValid(){
        if entry.phonenumberField.isNumeric && entry.phonenumberField.characters.count >= 3 {
            phonenumberFieldValidated = true
            } else {
                phonenumberFieldValidated = false
            }
        
        }
    
    mutating func validateEmailFieldLength(){
      //  print (entry.emailField.characters.count)
        if entry.emailField.isEmail && entry.emailField.characters.count >= 3 {
            emailFieldValidated = true
        } else {
            emailFieldValidated = false
 
        }
        
    }
    
    //function called by the view controller.  this function uses the series of preceeding validation functions
    mutating func validateAllFields() -> Bool {
        validateNameMinLength()
        validateUserNameMinLength()
        validateMinLenthforPassword()
        validatePhonenumberIsValid()
        validateEmailFieldLength()
        
        if nameFieldValidated && userNameFieldValidated && passwordFieldValidated && phonenumberFieldValidated && emailFieldValidated {
                return true
            } else {
                return false
            }
    }
    
    //function is called by the reset button in the view controller to clear all fields in the database entry
    mutating func clearAllValues(){
        entry.name = ""
        entry.userName = ""
        entry.passwordField = ""
        entry.phonenumberField = ""
        entry.emailField = ""
        
        
 
    }
    
    //adds the entry to the array of database entries.  I opted to not clear the array when the array. the array of entries is intended to simulate the backend database.  the reset  button is intended to be a frontfacing interface
    mutating func buildDbase(){
        database.append(entry)
    }
    
    
    //outputs display in a readable format
    func displayDbase() -> String{
        
        var dbaseOutput: String = ""
        
        
        for index in 0..<database.count {
        dbaseOutput +=  "Name: " + database[index].name + "\n" + "Username: " + database[index].userName + "\n" + "Password: " + obfuscatePassword(database[index].passwordField) + "\n" + "Phone Number: " + database[index].phonenumberField + " \n" + "Email: " + database[index].emailField + "\n"
        }
        
        return dbaseOutput
    }
        
        func obfuscatePassword(_ input: String) -> String {
           // let lengthOfPassword = input.characters.count
            let obscuredPassword = 	String(repeating: "*", count: input.characters.count)
            
          return obscuredPassword
        }
    
}

//this extensions adds ability to check a string to see if it contains only digits.
//i did not write this code.
//code from https://stackoverflow.com/questions/34587094/how-to-check-if-text-contains-only-numbers

extension String {
    var isNumeric: Bool {
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
}
//adds validation for properly formated email.  this is simple email validation.  may not stop all corner cases
//https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
