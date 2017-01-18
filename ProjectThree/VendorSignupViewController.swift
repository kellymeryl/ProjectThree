//
//  VendorSignupViewController.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class VendorSignupViewController: UIViewController {
   
   @IBOutlet weak var vendorNameTF: UITextField!
   @IBOutlet weak var vendorEmailTF: UITextField!
   @IBOutlet weak var vendorPasswordTF: UITextField!
   @IBOutlet weak var vendorConfirmPasswordTF: UITextField!
   
   
   
   @IBAction func vendorSignUpPressed(_ sender: Any) {
      
      if vendorNameTF.text == "" {
         let alertController = UIAlertController(title: "Error", message: "Please enter company name", preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         self.present(alertController, animated: true, completion: nil)
      } else if vendorEmailTF.text == "" {
         let alertController = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         self.present(alertController, animated: true, completion: nil)
      } else if vendorPasswordTF.text == "" {
         let alertController = UIAlertController(title: "Error", message: "Please enter a password", preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         self.present(alertController, animated: true, completion: nil)
      } else if (vendorPasswordTF.text?.characters.count)! < 6 {
         let alertController = UIAlertController(title: "Error", message: "Password must be at least 6 characters long", preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         self.present(alertController, animated: true, completion: nil)
      } else if vendorConfirmPasswordTF.text == "" {
         let alertController = UIAlertController(title: "Error", message: "Please confirm your password", preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         self.present(alertController, animated: true, completion: nil)
      } else if vendorConfirmPasswordTF.text != vendorPasswordTF.text {
         let alertController = UIAlertController(title: "Error", message: "Confirm password does not match password", preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         self.present(alertController, animated: true, completion: nil)
      } else {
         newUserSignup(viewController: self, emailTextField: vendorEmailTF.text!, passwordTextField: vendorPasswordTF.text!)
         
         addVendor(name: vendorNameTF.text!)
      }   
   }
   
   
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
   @IBAction func unwindFromVendorLoginVCToVendorSignupVC(_ sender: UIStoryboardSegue) {
      
   }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
