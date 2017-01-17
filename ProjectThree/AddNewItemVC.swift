//
//  AddNewItemVC.swift
//  ProjectThree
//
//  Created by Benjamin Landau on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class AddNewItemVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//MARK: @IBOUTLETS================================================
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var sizeBtn: UIButton!
    @IBOutlet weak var sizePickerView: UIPickerView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
//MARK: @IBACTIONS================================================

    @IBAction func categoryBtnTapped(_ sender: Any) {
        categoryPickerView.isHidden = false
    }
    
    @IBAction func sizeBtnTapped(_ sender: Any) {
        sizePickerView.isHidden = false
    }
    
    
//MARK: PickerView Properties and Methods==========================
    
    var categories = ["Men", "Woman", "Kids"]
    
    var sizes = ["S", "M", "L", "XL"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return categories.count
        } else {
            return sizes.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return categories[row]
        } else {
            return sizes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1) {
            categoryBtn.setTitle(categories[row], for: UIControlState.normal)
                    categoryPickerView.isHidden = true
        } else {
            sizeBtn.setTitle(sizes[row], for: UIControlState.normal)
            sizePickerView.isHidden = true
        }
    
        
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
