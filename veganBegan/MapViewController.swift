//
//  MapViewController.swift
//  veganBegan
//
//  Created by RelMac User Exercise3 on 2021/06/02.
//  Copyright © 2021 Release. All rights reserved.
//
import Foundation
import UIKit
import MapKit
import CoreLocation



class MapViewController: UIViewController, MTMapViewDelegate {
    var mapView: MTMapView?
    var mapPoint: MTMapPoint?
    var poiItem1: MTMapPOIItem?
    var list = [MTMapPOIItem] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView = MTMapView(frame: self.view.bounds)
        mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:37.551727, longitude: 126.941062))
        mapView?.setMapCenter(mapPoint, animated: true)
        
        if let mapView = mapView{
            mapView.delegate = self
            mapView.baseMapType = .standard
            
        //    mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude:37.573083, longitude: 126.983168)), animated: true)
           
          //  mapView.showCurrentLocationMarker = true
          //  mapView.currentLocationTrackingMode = .onWithoutHeading
            
            //self.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:37.573083, longitude: 126.983168))
            
            DatabaseManager.sortbyDistance(latitude:37.551727, longitude: 126.941062, completion: {data in
                self.list.removeAll()
                for i in 0...44 {
                    self.list.append(self.poiItem(name: data[i]["name"] as! String, latitude: data[i]["Latitude"] as! Double, longitude: data[i]["Longitude"] as! Double))
                }
                //self.list.append(poiItem(name: "restaurant2", latitude: 37.573772, longitude: 126.983170))
                //self.list.append(poiItem(name: "veganBegan!", latitude: 37.573883, longitude: 126.983169))
                //print(list.count)
             /*
                poiItem1 = MTMapPOIItem()
                poiItem1?.markerType = MTMapPOIItemMarkerType.redPin
                poiItem1?.mapPoint = mapPoint
                poiItem1?.itemName = "veganBegan!"
               */
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

