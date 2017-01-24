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
   
   var arrayOfURLDownloadStrings = [String]()
   
   
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
   var photo = PhotoCell()
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
   
   @IBOutlet weak var categoryView: UIView!
   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var imageCollectionViewOutlet: UICollectionView!
   @IBOutlet weak var categoryBtn: UIButton!
   @IBOutlet weak var itemColorLabel: UILabel!
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
   
    @IBAction func cameraButtonTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            noCamera()
        }
        
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    

    @IBAction func addItemBtn(_ sender: Any) {
      
    if nameTextField.text == "" || nameTextField.text == nil {
        let alertController = UIAlertController(title: "Error", message: "Please enter a name", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    } else if descriptionTextField.text == "" || descriptionTextField.text == nil {
        let alertController = UIAlertController(title: "Error", message: "Please enter a description", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    } else if priceTextField.text == "" || priceTextField.text == nil {
        let alertController = UIAlertController(title: "Error", message: "Please enter a price", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    } else if self.arrayOfItemPictures.count == 0 {
        let alertController = UIAlertController(title: "Error", message: "Please upload an Image", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    } else if itemColorLabel.text == "Choose a Color" {
        let alertController = UIAlertController(title: "Error", message: "Please choose a color", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    } else if Int(priceTextField.text!) == nil {
        let alertController = UIAlertController(title: "Error", message: "Please enter a numerical price", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    } else {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else {return}
            if strongSelf.arrayOfItemPictures.count > 0 {
                let semaphore = DispatchSemaphore(value: 0)
                var numberOfUploadedImages = 0
                for image in strongSelf.arrayOfItemPictures {
                    
                    let imageStorageUID = UUID().uuidString
                    
                    let uploadData = UIImagePNGRepresentation(image)
                    
                    let storageRef = FIRStorage.storage().reference()
                    let imageRef = storageRef.child(imageStorageUID)
                    
                    let _ = imageRef.put(uploadData!, metadata: nil, completion: { [weak self] (metadata, error) in
                        guard let strongSelf = self else {return}
                        let downloadURL = metadata?.downloadURL()?.absoluteString
                        print(downloadURL!)
                        strongSelf.arrayOfURLDownloadStrings.append(downloadURL!)
                        numberOfUploadedImages += 1
                        if numberOfUploadedImages == strongSelf.arrayOfItemPictures.count {
                            semaphore.signal()
                        }
                    })
                }
                semaphore.wait()
                FirebaseModel.sharedInstance.addItem(name: strongSelf.nameTextField.text!, description: strongSelf.descriptionTextField.text!, color: strongSelf.itemColorLabel.text!, price: strongSelf.priceTextField.text!, imageURLs: strongSelf.arrayOfURLDownloadStrings)
                strongSelf.dismissViewController()
            }
        }
    }
    }

   
   func dismissViewController() {
      self.performSegue(withIdentifier: "unwindFromAddNewItemVCToVendorHomeVC", sender: self)
   }

   
   
   func sendNotification() {
      
      let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.allHTTPHeaderFields = [
         "Content-Type":"application/json",
         "Authorization":"key=AAAAJx-E-Ns:APA91bHVn9a8QQ_3KqTuBfe4lj-XtSiVGoSquCigzKvmS9HAMB1d6FQIksJCPWeiRKeX5TjgEaVAliDCyuUjuDLnJmoAuNalin497fdazggsSnYQ_zDIyLXupbyGc2j8Kcl3XTYSDnxu"
      ]
      let body: [String: Any] = [
         "to": "/topics/app",
         "notification" : [
            "body": "A new item has been added. Check it out now!",
            "title": "FLNL"
         ]
      ]
      let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
      request.httpBody = data
      
      URLSession.shared.dataTask(with: request) { data, response, error in
         
         if let data = data {
            
            let resp = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print(resp)
            
         }
         }.resume()
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
      imageCell.imageOutlet.image = arrayOfItemPictures[indexPath.item]
      
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
      self.itemColorLabel.text = arrayOfColors[indexPath.row]
      categoryTableViewOutlet.isHidden = true
      
   }
}
