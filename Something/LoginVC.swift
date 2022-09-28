//
//  LoginVC.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/26/22.
//

import UIKit
import FirebaseAuth
import LocalAuthentication


class LoginVC: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var myKartLabel: UILabel!
    
    @IBOutlet weak var loginImageView: UIImageView!
    
    @IBOutlet weak var emailIdTextfield: UITextField!
    
    @IBOutlet weak var loginPasswordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //functio for adding face Id
        authenticateUserByFaceTouchID()
    
        //adding image to imageview
        let appLogo: UIImage = UIImage(named: "myKartLogo2")!
        loginImageView.image = appLogo
        
        //adding icon to the textfield and corner radius and border width to textfield
        let userIdImageView = UIImageView()
        let userIdIcon = UIImage(named: "userEmail")
        userIdImageView.image = userIdIcon
        emailIdTextfield.leftViewMode = .always
        emailIdTextfield.leftView = userIdImageView
        emailIdTextfield.layer.cornerRadius = 8.0
        emailIdTextfield.layer.borderWidth = 0.25
        
        //adding icon to the textfield and corner radius and border width to textfield
        let passwordImageView = UIImageView()
        let passwordIcon = UIImage(named: "userPassword")
        passwordImageView.image = passwordIcon
        loginPasswordTextfield.leftViewMode = .always
        loginPasswordTextfield.leftView = passwordImageView
        loginPasswordTextfield.layer.cornerRadius = 8.0
        loginPasswordTextfield.layer.borderWidth = 0.25

    }
    
    //function for validating and login. And also navigates to category page if login is successfull
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        
        if(emailIdTextfield.text!.isEmpty && loginPasswordTextfield.text!.isEmpty){
            
            alertDisplay(message: "Please enter emaiId and password first")
            
        }
        else{
            
            if(emailIdTextfield.text!.isEmpty){
                
                alertDisplay(message: "Please Enter the Email Id")
                
            }
            else{
                
                if(Validation.emailValidation(email: emailIdTextfield.text!)){
                    
                    if(loginPasswordTextfield.text!.isEmpty){
                        
                        alertDisplay(message: "Please enter the password")      //alerts called for displaying the pproper message of validation
                        
                    }
                    else{
                        
                        //authintication using firebase auth
                        Auth.auth().signIn(withEmail: emailIdTextfield.text!, password: loginPasswordTextfield.text!, completion: {
                            
                            (response,error) in
                            if let error = error{
                                
                                // if error prints error in console
                                print(error.localizedDescription)
                                
                            }
                            else{
                                
                                //navigates to the category page
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let tabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                                self.navigationController?.pushViewController(tabBarController, animated: true)
                                
                            }
                        })
                    }
                }
                else{
                    
                    alertDisplay(message: "Enter proper email Id")
                    
                }
            }
        }
    }
    
   //Alert function
    func alertDisplay(message: String) {
        
        let alertMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertMessage, animated: true)
        
    }
    
    //Face Id function
    func authenticateUserByFaceTouchID() {
        
            let context = LAContext()
            var error: NSError?
            let reason = "Identify yourself"
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){
                    [weak self] success, authenticationError in
                    
                    if success{
                        self?.myAlert(msg: "Authenticated succesfully", title:"Success")
                    }
                    else{
                        
                    }
                }
            }
            else{
                myAlert(msg:"No biometric authentication available",title:"Error")
            }
        }
        
        
        
        func showmessageWithErrorCode(errorcode: Int) -> String{
            var msg = ""
            switch errorcode{
            case LAError.appCancel.rawValue:
                msg = "Authentication was cancelled by the application"
            
            case LAError.authenticationFailed.rawValue:
                msg = "Unable to autenticate"
            default :
                msg = "common error"
            }
            
            return msg
        }
        
        func myAlert(msg: String, title: String) {
            
            let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction (title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            
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
