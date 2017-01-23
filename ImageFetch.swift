//
//  ImageFetch.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/23/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
   
   func setImageWithURL(urlString: String?) {
      
      self.image = nil //clears image
      
      if let itemImageURL = urlString {
         let url = URL(string: itemImageURL)
         if let url = url {
            DispatchQueue.global(qos: .background).async {
               do {
                  let data = try Data(contentsOf: url)
                  DispatchQueue.main.async{
                     self.image = UIImage(data: data)
                  }
               }
               catch {
                  print(error)
            }
         }
         
      }
      }
   }
}
