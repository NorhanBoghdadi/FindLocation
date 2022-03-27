//
//  HomeMapView.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/25/22.
//

import UIKit
import GoogleMaps

protocol MapViewDelegate: AnyObject {
    func didSelect(_ placeId: String)
}
class HomeMapView: UIView {
    
    private var mapView = GMSMapView()
    private var viewModel = MapViewModel()
    weak var delegate: MapViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMapView()
    }
    //MARK: - SETUP Map & Marker initial view.
    private func setupMapView() {
        mapView = viewModel.setupMapProperties(frame: self.frame)
        mapView.delegate = self
        self.addSubview(mapView)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HomeMapView: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        viewModel.changeMap(location: location)
        delegate?.didSelect(placeID)
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        viewModel.changeMap(location: coordinate)
        //TODO: implement getting info from coordinate aka geocoding
    }
}
