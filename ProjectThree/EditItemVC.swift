//
//  EditItemVC.swift
//  ProjectThree
//
//  Created by Benjamin Landau on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//
/*
import UIKit

class EditItemVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: @IBOUTLETS======================================
    
    @IBOutlet weak var editItemImageOutlet: UIImageView!
    @IBOutlet weak var editNameTextFieldOutlet: UITextField!
    @IBOutlet weak var editDescTextFieldOutlet: UITextField!
    @IBOutlet weak var editCategoryBtnOutlet: UIButton!
    @IBOutlet weak var editSizeBtnOutlet: UIButton!
//    @IBOutlet weak var categoryPickerViewOutlet: UIPickerView!
//    @IBOutlet weak var editSizePickerViewOutlet: UIPickerView!
    
    //MARK: @IBACTIONS========================================
    
//    @IBAction func editCategoryBtnTapped(_ sender: Any) {
//        categoryPickerViewOutlet.isHidden = false
//    }
//    @IBAction func editSizeBtnTapped(_ sender: Any) {
//        editSizePickerViewOutlet.isHidden = false
//    }
    //MARK: PickerView Methods and Properties=================
    
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
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if (pickerView.tag == 1) {
//            editCategoryBtnOutlet.setTitle(categories[row], for: UIControlState.normal)
//            categoryPickerViewOutlet.isHidden = true
//        } else {
//            editSizeBtnOutlet.setTitle(sizes[row], for: UIControlState.normal)
//            editSizePickerViewOutlet.isHidden = true
//        }
    
        
        
        
        
        
        
        
        
        
        
    }
}
*/
