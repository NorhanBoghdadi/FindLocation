//
//  ViewController.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/19/22.
//

import UIKit
import GoogleMaps

class HomeMapViewController: UIViewController {

    private var viewModel = HomeViewModel()
    
    private lazy var homeViewMap: HomeMapView = {
        let homeMap = HomeMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        homeMap.translatesAutoresizingMaskIntoConstraints = false
        return homeMap
    }()
    
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
        view.addSubview(homeViewMap)
    }
    
    //MARK: - Setup Details View
    func presentDetailsWith(_ placeId: String) {
        locationDetialsView.setData(placeId)
        present(locationDetialsView, animated: true)
    }
}

