//
//  ConsumerSignUpViewController.swift
//  ProjectThree
//
//  Created by Kelly McNevin on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit


class ConsumerSignUpViewController: UIViewController {

    @IBOutlet weak var consumerUsernameTextField: UITextField!
    @IBOutlet weak var consumerEmailTextField: UITextField!
    @IBOutlet weak var consumerPasswordTextField: UITextField!
    @IBOutlet weak var consumerConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func consumerSignUpButtonWasTapped(_ sender: Any) {
        //signs consumer up as user
        
        if consumerUsernameTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid username", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if consumerPasswordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if consumerPasswordTextField.text != consumerConfirmPasswordTextField.text {
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if consumerUsernameTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid username", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if consumerConfirmPasswordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please confirm password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            newUserSignup(viewController: self, emailTextField: consumerEmailTextField.text!, passwordTextField: consumerPasswordTextField.text!)
        }
        
    }
    
    @IBAction func consumerAlreadyAUserButtonWasTapped(_ sender: Any) {
        //segues to consumer login page
        
        
    }
    @IBAction func consumerSignUpAsVendorWasTapped(_ sender: Any) {
        //segues to vendor login page
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
