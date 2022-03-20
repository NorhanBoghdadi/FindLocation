//
//  ViewController.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/19/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {

    private let locationDetailsView = LocationDetailsView()
    private var camera = GMSCameraPosition()
    private var mapView = GMSMapView()
    private var marker = GMSMarker()
    private var placesClient = GMSPlacesClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMap()
        setupLongPressor()
        setupPlaces()
        

    }
    //MARK: - SETUP Map & Marker initial view. 
    private func setupMap() {
        camera = GMSCameraPosition.camera(withLatitude: 53.5499242, longitude: 9.9839786, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView.delegate = self
        view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        marker.icon = UIImage(named: "MapLocationMarker")
        marker.position = CLLocationCoordinate2D(latitude: 53.5499242, longitude: 9.9839786)
        marker.map = mapView

    }
    //MARK: - Setup Details View
    private func setupDetailsView() {
        view.addSubview(locationDetailsView)
        locationDetailsView.frame = CGRect(x: 20, y: (view.frame.height) - 120, width: (view.frame.width) - 40, height: 100)
    }
    //MARK: - Long press setup
    private func setupLongPressor() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressTap))
        longPressRecognizer.minimumPressDuration = 0.5
        view.addGestureRecognizer(longPressRecognizer)
    }
    
    //MARK: - Setup Places
    private func setupPlaces() {
        placesClient = GMSPlacesClient.shared()

    }
    private func getPlace(from placeID: String) {
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
            
            
            print(place.name)
            print(place.formattedAddress)
        }
    }

}

extension ViewController: HomeViewModelProtocol {
    @objc func longPressTap() {
        setupDetailsView()
    }
    
    
}

//MARK: - Change Map Location & Marker
extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        
        getPlace(from: placeID)
        camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15.0)
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        print("You tapped at \(location.latitude), \(location.longitude), \(placeID)")
    }
    
}
