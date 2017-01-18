//
//  PreCheckoutViewController.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/18/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

var itemsInCart = [Item]()

class PreCheckoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PreCheckoutTableViewCell", for: indexPath) as! PreCheckoutTableViewCell
      
 //     cell.itemName.text = itemsInCart[indexPath.row].item
 //     if let price = itemsInCart[indexPath.row]?.price {
 //        cell.itemPrice.text = "\(price)"
 //     }
      
      return cell
      
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return itemsInCart.count
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
