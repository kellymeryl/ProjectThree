//
//  ConsumerDataModel.swift
//  ProjectThree
//
//  Created by Kelly McNevin on 1/16/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import Foundation

class ConsumerDataModel {
    
    init(){
        
    }
    
    struct Consumer {
        var firstName: String
        var lastName: String
        var username: String
        var password: String
        var userID: String //will be firebase reference
        var paymentInformation: PaymentInformation?
        var shippingInformation: ShippingInformation?
        
        init(firstName: String, lastName: String, username: String, password: String, userID: String)
        {
            self.firstName = firstName
            self.lastName = lastName
            self.username = username
            self.password = password
            self.userID = userID
        }
        
    }
    
    struct PaymentInformation {
        var creditCardNumber: String
        var creditCardExpiration: String
        var creditCardSecurityCode: String
        
        init(creditCardNumber: String, creditCardExpiration: String, creditCardSecurityCode: String){
            self.creditCardNumber = creditCardNumber
            self.creditCardExpiration = creditCardExpiration
            self.creditCardSecurityCode = creditCardSecurityCode
        }
    }
    
    struct ShippingInformation {
        var streetName: String
        var streetNumber: String
        var zipCode: String
        var city: String
        var state: String
        var country: String
        
        init(streetName: String, streetNumber: String, zipCode: String, city: String, state: String, country: String)
        {
            self.streetName = streetName
            self.streetNumber = streetNumber
            self.zipCode = zipCode
            self.city = city
            self.state = state
            self.country = country
        }
    }
    
}

