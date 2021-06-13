//
//  MapViewDetail.swift
//  veganBegan
//
//  Created by Release on 2021/06/13.
//  Copyright © 2021 Release. All rights reserved.
//
import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewDetail: UIViewController, MTMapViewDelegate {
    var mapView: MTMapView?
    var mapPoint: MTMapPoint?
    var poiItem1: MTMapPOIItem?
    var list = [MTMapPOIItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView = MTMapView(frame: self.view.bounds)
        mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:37.551727, longitude: 126.941062))
        mapView?.setMapCenter(mapPoint, animated: true)
        
        if let mapView = mapView{
            mapView.delegate = self
            mapView.baseMapType = .standard
            
            DatabaseManager.sortbyFoodCategory(category: "한식", completion: {data in
                /*poiItem1 = MTMapPOIItem()
                poiItem1?.markerType = MTMapPOIItemMarkerType.redPin
                poiItem1?.mapPoint = mapPoint
                poiItem1?.itemName = "veganBegan!"*/
                self.list.removeAll()
                for i in 0...44 {
                    self.list.append(self.poiItem(name: data[i]["name"] as! String, latitude: data[i]["Latitude"] as! Double, longitude: data[i]["Longitude"] as! Double))
                }
               
                mapView.addPOIItems(self.list)
                mapView.fitAreaToShowAllPOIItems()
                
                self.view.insertSubview(mapView, at: 0)
                self.view.sendSubviewToBack(mapView)
            })
        }
        
    }

    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy){
        let currentLocation = location?.mapPointGeo()
        if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{ print("MTMapView update Current Location (\(latitude), \(longitude))")}
            
        }
    
    func mapView(_ mapView: MTMapView?, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView update Device Heading (\(headingAngle)) degrees")
    }
    
    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem{
        let item = MTMapPOIItem()
        item.itemName = name
        item.markerType = .redPin
        item.markerSelectedType = .redPin
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
       // item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
        
        return item
        
    }
 
}

