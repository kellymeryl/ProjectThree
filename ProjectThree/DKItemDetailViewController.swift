//
//  DKItemDetailViewController.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/19/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class DKItemDetailViewController: UIViewController {
   
   var itemsInCart = [Item]()
   
   @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var itemName: UILabel!
   @IBOutlet weak var itemPrice: UILabel!
   @IBOutlet weak var itemDescription: UITextView!
   
   
   
   @IBAction func addToCartPressed(_ sender: Any) {
      
      
      
   }
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
