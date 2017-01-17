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
