//
//  MapModel.swift
//  GoogleMapDemo
//
//  Created by tag on 12/18/15.
//  Copyright © 2015 tag. All rights reserved.
//

import UIKit

class MapModel: NSObject
{
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    
    var fetchedFormattedAddress: String!
    
    var fetchedAddressLongitude: Double!
    
    var fetchedAddressLatitude: Double!
    
    
    
}