//
//  Validation.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/26/22.
//

import Foundation

class Validation{
    
    // fun for validating Name
    class func nameValidation(name: String) -> Bool {
        
        let employeeName = "^(?=.*[A-Za-z]).{4,40}$"
        
        let namePredicate = NSPredicate(format: "SELF MATCHES %@" , employeeName)
        
        return namePredicate.evaluate(with: name)
        
    }
    
    // fun for validating Email
    class func emailValidation(email: String) -> Bool {
        
        let emailId = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@" , emailId)
        
        return emailPredicate.evaluate(with: email)
        
    }
    
    // fun for validating mobile number
    class func mobileValidation(mobile: String) -> Bool {
        
        let mobileNumber = "[0-9]{10}"
        
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@" , mobileNumber)
        
        return mobilePredicate.evaluate(with: mobile)
        
    }
    
    // fun for validating password
    class func passwordValidation(password: String) -> Bool {
        
        let pass = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%&*_]).{8,}$"
        
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@" , pass)
        
        return passwordPredicate.evaluate(with: password)
        
    }
   
}


