//
//  HomeViewModelProtocol.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/20/22.
//

import UIKit
import GooglePlaces
import GoogleMaps

protocol HomeViewModelProtocol {
    var placesClient: GMSPlacesClient {get}
    var camera: GMSCameraPosition {get}
    var marker: GMSMarker {get}
    var mapView: GMSMapView {get}
    
    func getPlace(from placeID: String) -> (String, String)
    func setupMapProperties(location: CLLocationCoordinate2D, zoom: Float, view: UIView) -> GMSMapView
    func changeMapLlocation(location: CLLocationCoordinate2D, zoom: Float)
}


