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

    private var camera = GMSCameraPosition()
    private var mapView = GMSMapView()
    private var marker = GMSMarker()
    private var placesClient = GMSPlacesClient()
    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMap()
        setupLongPressor()
        

    }
    //MARK: - SETUP Map & Marker initial view. 
    private func setupMap() {
        camera = GMSCameraPosition.camera(withLatitude: Constants.initLatitude, longitude: Constants.initLongitude, zoom: Constants.cameraZoom)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView.delegate = self
        view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        marker.icon = UIImage(named: "MapLocationMarker")
        marker.position = CLLocationCoordinate2D(latitude: Constants.initLatitude, longitude: Constants.initLongitude)
        marker.map = mapView

    }
    //MARK: - Setup Details View
    private func setupDetailsView() {
        let detailsView = LocationDetailsViewController()
        detailsView.modalPresentationStyle = .overCurrentContext
        present(detailsView, animated: true)
    }
    
    //MARK: - Long press setup
    private func setupLongPressor() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressTap))
        longPressRecognizer.minimumPressDuration = 0.5
        view.addGestureRecognizer(longPressRecognizer)
    }
    @objc func longPressTap() {
        setupDetailsView()
    }

}


//MARK: - Change Map Location & Marker
extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        setupDetailsView() //Remove later
        
        viewModel.getPlace(from: placeID)
        camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: Constants.cameraZoom)
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        print("You tapped at \(location.latitude), \(location.longitude), \(placeID)")
    }
    
}
extension ViewController {
    struct Constants {
        static let initLatitude = 53.5499242
        static let initLongitude = 9.9839786
        static let cameraZoom: Float = 15.0
        
        static let viewX: CGFloat = 20
        static let viewY: CGFloat = 120
        static let width: CGFloat = 40
        static let height: CGFloat = 150
    }
}
