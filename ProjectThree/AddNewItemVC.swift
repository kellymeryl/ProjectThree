//
//  AddNewItemVC.swift
//  ProjectThree
//
//  Created by Benjamin Landau on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class AddNewItemVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
   
   var venderHome: VenderHomeVC!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      imagePicker.delegate = self
   }
   
   override func viewDidAppear(_ animated: Bool) {
      if arrayOfItemPictures.count == 3 {
         addPhotoBtnOutlet.isHidden = true
      }
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   //MARK: ImagePicker Methods and Properties===================================
   
   var arrayOfItemPictures = [UIImage]()
   var photo: PhotoCell!
   let imagePicker = UIImagePickerController()
   var pictureSaved: UIImage!
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
         arrayOfItemPictures.append(pickedImage)
         pictureSaved = pickedImage
         self.imageCollectionViewOutlet.reloadData()
      } else {
         //error message
      }
      self.dismiss(animated: true, completion: nil)
   }
   
   //MARK: @IBOUTLETS==============================================================
   
   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var imageCollectionViewOutlet: UICollectionView!
   @IBOutlet weak var categoryBtn: UIButton!
   @IBOutlet weak var categoryPickerView: UIPickerView!
   @IBOutlet weak var sizeBtn: UIButton!
   @IBOutlet weak var sizePickerView: UIPickerView!
   @IBOutlet weak var descriptionTextField: UITextField!
   @IBOutlet weak var priceTextField: UITextField!
   @IBOutlet weak var addPhotoBtnOutlet: UIButton!
   
   //MARK: @IBACTIONS===============================================================
   
   @IBAction func categoryBtnTapped(_ sender: Any) {
      categoryPickerView.isHidden = false
   }
   
   @IBAction func sizeBtnTapped(_ sender: Any) {
      sizePickerView.isHidden = false
   }
   
   @IBAction func photoBtnTapped(_ sender: Any) {
      imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
      present(imagePicker, animated: true, completion: nil)
   }
   
   
   // ** Need to change placeholder info in price and vendorUID **
   @IBAction func addItemBtn(_ sender: Any) {
      
      
      let imageStorageUID = UUID().uuidString
      
      let uploadData = UIImagePNGRepresentation(self.pictureSaved!)
         
         let storageRef = FIRStorage.storage().reference()
         let imageRef = storageRef.child(imageStorageUID)
         
         let _ = imageRef.put(uploadData!, metadata: nil, completion: { (metadata, error) in
           let downloadURL = metadata?.downloadURL()?.absoluteString
               FirebaseModel.sharedInstance.addItem(name: self.nameTextField.text!, description: self.descriptionTextField.text!, category: (self.categoryBtn.titleLabel?.text!)!, size: (self.sizeBtn.titleLabel?.text!)!, price: self.priceTextField.text!, imageURL: downloadURL!)
               
               print("-------------- THIS IS THE URL \(downloadURL) --------------")
               
      })
   }
   
   


   
   

   
   //MARK: PickerView Properties and Methods=========================================
   
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
   
   
   //MARK: CollectionView Methods and Properties========================================
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return arrayOfItemPictures.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! PhotoCell
      imageCell.imageOutlet.image = arrayOfItemPictures[indexPath.row]
      
      return imageCell
   }
   
}
