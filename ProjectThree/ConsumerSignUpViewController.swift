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
   
   @IBAction func shopperSignUpAsVendorPressed(_ sender: Any) {
      var storyboard: UIStoryboard = UIStoryboard(name: "VendorSignup", bundle: nil)
      var vc = storyboard.instantiateViewController(withIdentifier: "VendorSignupViewController") as! VendorSignupViewController
      self.show(vc, sender: self)
   }
   
   
    
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
        else if consumerPasswordTextField.text!.characters.count < 6 {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter a password that is longer than 6 characters", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
       
        else {
         FirebaseModel.sharedInstance.newCustomerSignup(viewController: self, name: consumerEmailTextField.text!, emailTextField: consumerEmailTextField.text!, passwordTextField: consumerPasswordTextField.text!, complete: { success in
            let customerStoryboard: UIStoryboard = UIStoryboard(name: "CustomerUI", bundle: nil)
            let vc = customerStoryboard.instantiateInitialViewController()
            self.present(vc!, animated: true, completion: nil)
         })
        }
        
    }

   @IBAction func shopperPressedSignUpAsVendor(_ sender: Any) {
      
      let storyboard = UIStoryboard(name: "VendorSignup", bundle: nil)
      
      let initialViewController = storyboard.instantiateViewController(withIdentifier: "VendorSignupViewController")
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
      
      appDelegate.window?.rootViewController = initialViewController
      appDelegate.window?.makeKeyAndVisible()
   }
   
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindFromConsumerLoginVCToConsumerSignUpVC(_ sender: UIStoryboardSegue) {
        
    }

}
