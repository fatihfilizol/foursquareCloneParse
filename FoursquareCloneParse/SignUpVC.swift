//
//  ViewController.swift
//  FoursquareCloneParse
//
//  Created by Fatih Filizol on 21.08.2022.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(titleInput: "Error", messageInput: "User Name / Password ?")
        }
        
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != ""{
            
            let user = PFUser()
            user.password = passwordText.text!
            user.username = usernameText.text!
            
            user.signUpInBackground { success, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)                }
            }
            
        }else{
            makeAlert(titleInput: "Error", messageInput: "User Name / Password ?")
        }
        
    }
    
    func makeAlert (titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

