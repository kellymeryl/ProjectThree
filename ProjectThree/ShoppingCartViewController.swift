//
//  ShoppingCartViewController.swift
//  ProjectThree
//
//  Created by Andrew Moskowitz on 1/15/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cartArray: [CartItem] = []
    var cart = CoreDataModel.sharedInstance.cart
    var cartItems = CoreDataModel.sharedInstance.cartItems
    
    @IBOutlet weak var shoppingCartTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath) as! ShoppingCartCellTableViewCell
        cell.itemNameCart.text = cartItems[indexPath.row].name
        cell.itemPriceCart.text = cartItems[indexPath.row].price
       // cell.itemCartThumbnail.image = cartItems[indexPath.row].
        cell.itemSizeCart.text = cartItems[indexPath.row].size
        cell.itemQuantityCart.text = String(describing: cartItems[indexPath.row].quantity)
        return cell
    }
    
    func convertToCurrency(num: String) -> String {
        
        let number = NSDecimalNumber(value: Float(num)!)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        let result = numberFormatter.string(from: number)
        
        return result!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
