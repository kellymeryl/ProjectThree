//
//  NewVendorLoginViewController.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewVendorLoginViewController: UIViewController {
   
   
   @IBOutlet weak var vendorEmailTF: UITextField!
   @IBOutlet weak var vendorPasswordTF: UITextField!
   
   
   @IBAction func vendorLoginPressed(_ sender: Any) {
      
      FirebaseModel.sharedInstance.login(email: vendorEmailTF.text!, password: vendorPasswordTF.text!, complete: { success in
         if success {
            print("login successful!")
            self.performSegue(withIdentifier: "Login2Vendor", sender: self)
            print(FIRAuth.auth()?.currentUser?.uid)
            print()
         } else {
            let alertController = UIAlertController(title: "Error", message: "Username/Password Not Recognized", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
         }
      })
    
   }
   
    
   
   @IBAction func vendorNeedNewAccountPressed(_ sender: Any) {
      performSegue(withIdentifier: "unwindFromVendorLoginVCToVendorSignupVC", sender: self)
   }
   
   
   @IBAction func vendorLoginAsShopperPressed(_ sender: Any) {
   }
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      let vendorHomeVC = segue.destination as! VenderHomeVC
//        vendorHomeVC.userID = (FIRAuth.auth()?.currentUser?.uid)!
//    }
   

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
