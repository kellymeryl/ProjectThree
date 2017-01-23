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

class AddNewItemVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
     var venderHome: VenderHomeVC!
   
   //To be deleted after testing!!
   var testingImagesURLArray = [String]()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        categoryView.alpha = 0.0
        nameTextField.borderStyle = UITextBorderStyle.bezel
        descriptionTextField.borderStyle = UITextBorderStyle.bezel
        priceTextField.borderStyle = UITextBorderStyle.bezel
        
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
    
    @IBOutlet weak var chooseCategoryLbl: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addPhotoBtnOutlet: UIButton!
    @IBOutlet weak var categoryTableViewOutlet: UITableView!
//MARK: @IBACTIONS===============================================================
    
    @IBAction func categoryBtnTapped(_ sender: Any) {
        let alpha: CGFloat = categoryView.alpha == 0.0 ? 2.0 : 0.0
        UIView.animate(withDuration: 0.5, animations: {
            
            self.categoryView.alpha = alpha
            self.categoryTableViewOutlet.isHidden = false
    })
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
         self.testingImagesURLArray.append(downloadURL!)
         
         
         FirebaseModel.sharedInstance.addItem(name: self.nameTextField.text!, description: self.descriptionTextField.text!, color: self.chooseCategoryLbl.text!, price: self.priceTextField.text!, imageURLs: self.testingImagesURLArray)
         
            
            print("-------------- THIS IS THE URL \(downloadURL) --------------")
            
        })
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
    
//MARK: TableView Methods and Properties============================================
    var categories: ColorCell!
    var arrayOfColors = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink", "Black", "White"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfColors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ColorCell
         cell.itemColor.text = arrayOfColors[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chooseCategoryLbl.text = arrayOfColors[indexPath.row]
        categoryTableViewOutlet.isHidden = true
        
    }
}
