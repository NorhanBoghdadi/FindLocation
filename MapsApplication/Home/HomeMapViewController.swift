//
//  ViewController.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/19/22.
//

import UIKit
import GoogleMaps

class HomeMapViewController: UIViewController {

    private var mapView = GMSMapView()
    private var viewModel = HomeViewModel()
    
    private lazy var locationDetialsView: LocationDetailsViewController = {
        let detailsView = LocationDetailsViewController()
        detailsView.modalPresentationStyle = .overCurrentContext
        detailsView.modalTransitionStyle = .crossDissolve
        return detailsView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMapView()
    }
    
    //MARK: - SETUP Map & Marker initial view. 
    private func setupMapView() {
        mapView = viewModel.setupMapProperties(frame: view.frame)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    //MARK: - Setup Details View
    private func presentDetailsWith(_ placeId: String) {
        locationDetialsView.setData(placeId)
        present(locationDetialsView, animated: true)
    }
}

 
//MARK: - Change Map Location & Marker
extension HomeMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        viewModel.changeMap(location: location)
        presentDetailsWith(placeID)
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        viewModel.changeMap(location: coordinate)
        //TODO: implement getting info from coordinate aka geocoding
    }
}
extension HomeMapViewController {
    struct Constants {
        static let viewX: CGFloat = 20
        static let viewY: CGFloat = 120
        static let width: CGFloat = 40
        static let height: CGFloat = 150
    }
}
