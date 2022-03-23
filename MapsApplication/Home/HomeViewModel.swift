//
//  HomeViewModel.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/23/22.
//

import Foundation
import GooglePlaces
import GoogleMaps

class HomeViewModel: HomeViewModelProtocol {
        
    var camera =  GMSCameraPosition()
    var marker = GMSMarker()
    var placesClient = GMSPlacesClient.shared()
    var mapView = GMSMapView()
    
    //Setup Map Properties
    func setupMapProperties(location: CLLocationCoordinate2D, zoom: Float, view: UIView) -> GMSMapView {
        camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: zoom)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        
    // Creates a marker in the center of the map.
        marker.icon = UIImage(named: "MapLocationMarker")
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.map = mapView
        
        return(mapView)
    }

    func changeMapLlocation(location: CLLocationCoordinate2D, zoom: Float) {
        camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: zoom)
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)

    }
    
   
    //MARK: - Setup Places
    
    var placeName: String = " " {
        didSet {
            
        }
    }
    var placeAddress: String = " " {
        didSet {
            
        }
    }


    func getPlace(from placeID: String) -> (String, String) {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]

        placesClient.fetchPlace(fromPlaceID: placeID, placeFields: placeFields, sessionToken: nil)  { (place, error) in
            guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
            }

            guard let place = place else {
                print("No current place")
                return
            }
            
            self.placeName = place.name ?? " "
            self.placeAddress = place.formattedAddress ?? " "
            
        }
        return (placeName, placeAddress)
    }
}

