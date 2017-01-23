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
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    @IBAction func xlButton(_ sender: UIButton) {
    }
    
    @IBAction func largeButton(_ sender: UIButton) {
    }
    
    @IBAction func mediumButton(_ sender: UIButton) {
    }
    
    @IBAction func smallButton(_ sender: UIButton) {
    }
    
    @IBAction func addToCartButton(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailCell", for: indexPath) as! ItemDetailCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        itemNameLabel.text = arrayOfItems[selectedIndex!]!.name
        itemPriceLabel.text = "\(AllItemsCollectionViewController().convertToCurrency(num: arrayOfItems[selectedIndex!]!.price))"
        itemDescriptionTextView.text = arrayOfItems[selectedIndex!]!.description

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
