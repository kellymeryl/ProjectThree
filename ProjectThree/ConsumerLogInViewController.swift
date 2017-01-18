//
//  ConsumerLogInViewController.swift
//  ProjectThree
//
//  Created by Kelly McNevin on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class ConsumerLogInViewController: UIViewController {

    @IBOutlet weak var userUserNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBAction func signInButtonWasTapped(_ sender: Any) {
      
      FirebaseModel.sharedInstance.login(email: userUserNameTextField.text!, password: userPasswordTextField.text!, complete: { success in
         
            if success {
            print("success")
            } else {
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid Email or Password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            }})
    }
    
    @IBAction func doesntHaveAccountWasTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindFromConsumerLoginVCToConsumerSignUpVC", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    

}
