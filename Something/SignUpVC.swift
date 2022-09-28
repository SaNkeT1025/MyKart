//
//  SignUpVC.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/26/22.
//

import UIKit
import CoreData
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class SignUpVC: UIViewController {

    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var signUpPageImageView: UIImageView!
    
    @IBOutlet weak var signUpNametextfield: UITextField!
    
    @IBOutlet weak var signUpEmailTextfield: UITextField!
    
    @IBOutlet weak var signUpMobileTextfield: UITextField!
    
    @IBOutlet weak var signUpPasswordTextfield: UITextField!
    
    @IBOutlet weak var signUpConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let userImage = UIImage(named: "user")
        signUpPageImageView.image = userImage
        
        signUpPageImageView.layer.cornerRadius = 64
        
        signUpNametextfield.layer.cornerRadius = 8.0
        signUpNametextfield.layer.borderWidth = 0.25
        
        signUpEmailTextfield.layer.cornerRadius = 8.0
        signUpEmailTextfield.layer.borderWidth = 0.25
        
        signUpMobileTextfield.layer.cornerRadius = 8.0
        signUpMobileTextfield.layer.borderWidth = 0.25
        
        signUpConfirmPassword.layer.cornerRadius = 8.0
        signUpConfirmPassword.layer.borderWidth = 0.25
        
        signUpPasswordTextfield.layer.cornerRadius = 8.0
        signUpPasswordTextfield.layer.borderWidth = 0.25
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        
        if(signUpNametextfield.text!.isEmpty && signUpEmailTextfield.text!.isEmpty && signUpMobileTextfield.text!.isEmpty && signUpPasswordTextfield.text!.isEmpty && signUpConfirmPassword.text!.isEmpty){
            
            alertDisplay(message: "Please first enter the details")
            
        }
        else{
            
            if(signUpNametextfield.text!.isEmpty){
                
                alertDisplay(message: "Enter your name")
                
            }
            else{
                
                if(Validation.nameValidation(name: signUpNametextfield.text!)){
                    
                    if(signUpEmailTextfield.text!.isEmpty){
                        
                        alertDisplay(message: "Enter the email Id")
                        
                    }
                    else{
                        
                        if(Validation.emailValidation(email: signUpEmailTextfield.text!)){
                            
                            if(signUpMobileTextfield.text!.isEmpty){
                                
                                alertDisplay(message: "Enter the mobile number")
                                
                            }
                            else{
                                
                                if(Validation.mobileValidation(mobile: signUpMobileTextfield.text!)){
                                    
                                    if(signUpPasswordTextfield.text!.isEmpty){
                                        
                                        alertDisplay(message: "Enter the password")
                                        
                                    }
                                    else{
                                        
                                        if(Validation.passwordValidation(password: signUpPasswordTextfield.text!)){
                                            
                                            if(signUpPasswordTextfield.text! == signUpConfirmPassword.text!){
                                                
                                                let appDeli = (UIApplication.shared.delegate) as! AppDelegate
                                                let context = appDeli.persistentContainer.viewContext
                                                let userInfo = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context) as! UserData
                                                
                                                userInfo.name = signUpNametextfield.text!
                                                userInfo.emailId = signUpEmailTextfield.text!
                                                userInfo.mobile = signUpMobileTextfield.text!
                                                userInfo.password = signUpPasswordTextfield.text!
                                                
                                                do{
                                                    try context.save()
                                                }
                                                catch{
                                                    
                                                }
                                                
                                                Auth.auth().createUser(withEmail: signUpEmailTextfield.text!, password: signUpPasswordTextfield.text!, completion: {
                                                    (response,error) in
                                                    if let error = error {
                                                        print(error.localizedDescription)
                                                    }
                                                    else{
                                                        print("Successful Registration.")
                                                    }
                                                })
                                                
                                                
                                                
                                                let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                                                self.navigationController?.pushViewController(tabBarController, animated: true)
                                                
            
                                            }
                                            else{
                                                alertDisplay(message: "Password and Confirm Password not matching")
                                            }
                                        }
                                        else{
                                            alertDisplay(message: "Password must contain 1 Uppercase, 1 Smallercase, 1 Number, 1 Special symbol")
                                        }
                                    }
                                }
                                else{
                                    alertDisplay(message: "Enter 10 digit number")
                                }
                            }
                        }
                        else{
                            alertDisplay(message: "Enter proper email Id")
                        }
                    }
                }
                else{
                    alertDisplay(message: "Name must contain atleast 4 characters")
                }
            }
        }
        
    }
    
    func alertDisplay(message: String) {
        
        let alertMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertMessage, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
