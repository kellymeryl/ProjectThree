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
      
      FirebaseModel.sharedInstance.login(email: vendorEmailTF.text!, password: vendorPasswordTF.text!, viewController: self, complete: { [weak self] success in
         guard let strongSelf = self else {return}
         DispatchQueue.main.async {
            print("==============login successful!==============")
            strongSelf.performSegue(withIdentifier: "Login2Vendor", sender: self)
         }
      })
    
   }
   
   
   
   
   @IBAction func vendorNeedNewAccountPressed(_ sender: Any) {
      performSegue(withIdentifier: "unwindFromVendorLoginVCToVendorSignupVC", sender: self)
   }
   
   
   @IBAction func vendorLoginAsShopperPressed(_ sender: Any) {
      
      var storyboard: UIStoryboard = UIStoryboard(name: "ConsumerSignUpStoryboard", bundle: nil)
      var vc = storyboard.instantiateViewController(withIdentifier: "ConsumerLogInViewController") as! ConsumerLogInViewController
      self.show(vc, sender: self)
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
//        let vendorHomeVC = segue.destination as! VenderHomeVC
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
