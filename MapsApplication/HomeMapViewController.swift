//
//  ViewController.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/19/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

class HomeMapViewController: UIViewController {

    private var mapView = GMSMapView()
    private var viewModel = HomeViewModel()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMapView()
        setupLongPressor()

    }
    //MARK: - SETUP Map & Marker initial view. 
    private func setupMapView() {
        mapView = viewModel.setupMapProperties(location: Constants.location, zoom: Constants.cameraZoom, view: view)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    //MARK: - Setup Details View
    private func setupDetailsView(addressName: String, addressDet: String) {
        let detailsView = LocationDetailsViewController()
        detailsView.modalPresentationStyle = .overCurrentContext
        detailsView.modalTransitionStyle = .crossDissolve
        detailsView.locationNameLabel.text = addressName
        detailsView.addressLabel.text = addressDet
        present(detailsView, animated: true)
    }
    
    //MARK: - Long press setup
    private func setupLongPressor() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressTap))
        longPressRecognizer.minimumPressDuration = 0.5
        view.addGestureRecognizer(longPressRecognizer)
    }
    @objc func longPressTap() {
//        setupDetailsView()
    }

}

 
//MARK: - Change Map Location & Marker
extension HomeMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        
        var placeOutput: (String, String) = ("", "")
        placeOutput = viewModel.getPlace(from: placeID)
        
        viewModel.changeMapLlocation(location: location, zoom: Constants.cameraZoom)
        setupDetailsView(addressName: placeOutput.0, addressDet: placeOutput.1)

        
    }
    
}
extension HomeMapViewController {
    struct Constants {
        static let initLatitude = 53.5499242
        static let initLongitude = 9.9839786
        static let location = CLLocationCoordinate2D(latitude: 53.5499242, longitude: 9.9839786)
        static let cameraZoom: Float = 15.0
        
        static let viewX: CGFloat = 20
        static let viewY: CGFloat = 120
        static let width: CGFloat = 40
        static let height: CGFloat = 150
    }
}
