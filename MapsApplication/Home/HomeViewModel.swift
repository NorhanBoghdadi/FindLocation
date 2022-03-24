//
//  HomeViewModel.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/23/22.
//

import Foundation
import GoogleMaps

protocol HomeViewModelProtocol {
    func setupMapProperties(frame: CGRect) -> GMSMapView
    func changeMap(location: CLLocationCoordinate2D)
}

class HomeViewModel: HomeViewModelProtocol {
    private var camera = GMSCameraPosition()
    private var marker = GMSMarker()
    private var mapView = GMSMapView()
    
    //Setup Map Properties
    func setupMapProperties(frame: CGRect) -> GMSMapView {
        camera = GMSCameraPosition.camera(withLatitude: Constants.location.latitude, longitude: Constants.location.longitude, zoom: Constants.cameraZoom)
        mapView = GMSMapView.map(withFrame: frame, camera: camera)
        
        // Creates a marker in the center of the map.
        marker.icon = UIImage(named: Constants.iconName)
        marker.position = CLLocationCoordinate2D(
            latitude: Constants.location.latitude,
            longitude: Constants.location.longitude
        )
        marker.map = mapView
        return mapView
    }
    
    func changeMap(location: CLLocationCoordinate2D) {
        camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: Constants.cameraZoom)
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    enum Constants {
        static let location = CLLocationCoordinate2D(latitude: 53.5499242, longitude: 9.9839786)
        static let cameraZoom: Float = 15.0
        static let iconName = "MapLocationMarker"
    }
}

