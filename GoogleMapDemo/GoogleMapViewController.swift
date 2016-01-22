//
//  GoogleMapViewController.swift
//  GoogleMapDemo
//
//  Created by tag on 12/18/15.
//  Copyright © 2015 tag. All rights reserved.
//

import UIKit

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate
{
    var vwGMap = GMSMapView()
    
    var locationManager = CLLocationManager()
    let marker = GMSMarker()
    
    //    MARK: - View Life Cycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        // A minimum distance a device must move before update event generated
        locationManager.distanceFilter = 500
        
        // Request permission to use location service
        locationManager.requestWhenInUseAuthorization()
        
        // Request permission to use location service when the app is run
        locationManager.requestAlwaysAuthorization()
        
        // Start getting update of user's location
        locationManager.startUpdatingLocation()
        
//        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(22.300000, longitude: 70.783300, zoom: 10.0)
//        
//        vwGMap = GMSMapView.mapWithFrame(self.view.frame, camera: camera)
//        
//        vwGMap.camera = camera
        
        // Add GMSMapView to current view
        self.view = vwGMap
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //    MARK: - CLLocationManagerDelegate Methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.AuthorizedWhenInUse)
        {
            vwGMap.myLocationEnabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let newLocation = locations.last
        vwGMap.camera = GMSCameraPosition.cameraWithTarget(newLocation!.coordinate, zoom: 15.0)
        vwGMap.settings.myLocationButton = true
        self.view = self.vwGMap
        
        
        marker.position = CLLocationCoordinate2DMake(newLocation!.coordinate.latitude, newLocation!.coordinate.longitude)
        
        marker.map = self.vwGMap
        
        
        //        let geoCoder = CLGeocoder()
        //        geoCoder.reverseGeocodeLocation(newLocation!, completionHandler: { (placemarks, error) -> Void in
        //            let placeMark = placemarks![0]
        //
        //            if let locationCity = placeMark.addressDictionary!["City"] as? NSString {
        //                marker.title = locationCity as String
        //            }
        //
        //            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
        //                marker.snippet = locationName as String
        //            }
        //            
        //        })
    }
    
    
    //    MARK: - Action Methods
    
    @IBAction func btnMapTypeTapped(sender: AnyObject)
    {
        selectMapType()
    }
    
    
    //    MARK: - Other Methods
    
    func selectMapType()
    {
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.vwGMap.mapType = kGMSTypeNormal
            self.view = self.vwGMap
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.vwGMap.mapType = kGMSTypeTerrain
            self.view = self.vwGMap
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.vwGMap.mapType = kGMSTypeHybrid
            self.view = self.vwGMap
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
}