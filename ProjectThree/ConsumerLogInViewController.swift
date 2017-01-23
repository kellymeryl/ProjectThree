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
      
      FirebaseModel.sharedInstance.login(email: userUserNameTextField.text!, password: userPasswordTextField.text!, viewController: self, complete: { [weak self] success in
         guard let strongSelf = self else {return}
            print("success")
            })
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
