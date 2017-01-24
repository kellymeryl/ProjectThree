//
//  CheckoutViewController.swift
//  ProjectThree
//
//  Created by Andrew Moskowitz on 1/16/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var checkoutTableView: UITableView!
   
    var cartSubtotal = String()
    var cartItems = CoreDataModel.sharedInstance.cartItems
    var cartSubtotalInt = Double()
    var cartShippingTotal = Double()
    var totalBeforeTax = Double()
    var tax = Double()
    var orderTotal = Double()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutTableViewCell", for: indexPath) as! CheckoutTableViewCell
        cartSubtotalInt = Double(cartSubtotal)!
        cartShippingTotal = cartSubtotalInt * 0.15
        totalBeforeTax = cartSubtotalInt + cartShippingTotal
        tax = totalBeforeTax * 0.04
        orderTotal = totalBeforeTax + tax
        cell.itemPriceLabel.text = cartSubtotal
        cell.shippingLabel.text = String(describing: cartShippingTotal)
        cell.totalLabel.text = String(describing: totalBeforeTax)
        cell.taxLabel.text = String(describing: tax)
        cell.orderTotalLabel.text = String(describing: orderTotal)
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
