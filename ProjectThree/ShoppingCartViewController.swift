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
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var integerPrice = Int()
    var quantity = Int()
    var totalPrice = 0
    var stringTotalPrice = String()

    @IBOutlet weak var shoppingCartTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setTotalPrice()
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath) as! ShoppingCartCellTableViewCell
        cell.itemNameCart.text = cartItems[indexPath.row].name
      if let price = cartItems[indexPath.row].price {
         cell.itemPriceCart.text = "\(convertToCurrency(num: price))"
      }
       // cell.itemCartThumbnail.image = cartItems[indexPath.row].
      let quantity = String(describing: cartItems[indexPath.row].quantity)
        cell.itemQuantityCart.text = "quantity: \(quantity)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            cartItems.remove(at: indexPath.row)
            shoppingCartTableView.reloadData()
        }
        
    }
    
    func convertToCurrency(num: String) -> String {
        
        let number = NSDecimalNumber(value: Float(num)!)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        let result = numberFormatter.string(from: number)
        
        return result!
    }
    
    func setTotalPrice() {
        
        totalPrice = 0
        
        for items in cartItems {
            integerPrice = Int(items.price!)!
            quantity = Int(items.quantity)
            totalPrice += (integerPrice * quantity)
        }
        
        stringTotalPrice = String(describing: totalPrice)
        priceLabel.text = stringTotalPrice + ".00"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let checkoutViewController = segue.destination as! CheckoutViewController
        checkoutViewController.cartSubtotal = priceLabel.text!
        checkoutViewController.cartItems = cartItems
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTotalPrice()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
