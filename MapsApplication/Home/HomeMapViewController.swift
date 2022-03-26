//
//  ViewController.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/19/22.
//

import UIKit

class HomeMapViewController: UIViewController {

    private var viewModel = HomeViewModel()
    
    private lazy var homeViewMap: HomeMapView = {
        let homeMap = HomeMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        homeMap.translatesAutoresizingMaskIntoConstraints = false
        homeMap.delegate = self
        return homeMap
    }()
    
    private lazy var locationDetialsView: LocationDetailsViewController = {
        let detailsView = LocationDetailsViewController()
        detailsView.modalPresentationStyle = .overFullScreen
//        detailsView.modalTransitionStyle = .crossDissolve
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
    

}
extension HomeMapViewController: MapViewDelegate {
    //MARK: - Setup Details View
    func didSelect(_ placeId: String) {
        locationDetialsView.setData(placeId)
        present(locationDetialsView, animated: true)
    }
}
