//
//  ItemDetailViewController.swift
//  ProjectThree
//
//  Created by Andrew Moskowitz on 1/16/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var selectedIndex: Int?
    
    var arrayOfItems: [Item?] = []
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailCell", for: indexPath) as! ItemDetailCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        itemNameLabel.text = arrayOfItems[selectedIndex!]!.name
        itemPriceLabel.text = "\(convertToCurrency(num: arrayOfItems[selectedIndex!]!.price))"
        itemDescriptionTextView.text = arrayOfItems[selectedIndex!]!.description

        // Do any additional setup after loading the view.
    }
    func convertToCurrency(num: Float) -> String {
        
        let number = NSDecimalNumber(value: num)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        let result = numberFormatter.string(from: number)
        
        return result!
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
