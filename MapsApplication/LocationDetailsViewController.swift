//
//  LocationDetailsViewController.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/21/22.
//

import UIKit

protocol LocationDetailsViewProtocol {
    func closeView()
}

class LocationDetailsViewController: UIViewController {

    
    private lazy var detView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.layer.cornerRadius = Constants.cornerRad
        return view
    }()
    
    //Declare first label
    lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Something something"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor(named: "PrimaryTextColor")

        return label
    }()
    
    //Declare details label
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "SOMETHING"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "SecondaryTextColor")
        return label
    }()
    
    //Declare close buttons
    private lazy var closeImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "CloseIconNormal")
        img.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.closeView))
        tapGesture.numberOfTapsRequired = 1
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tapGesture)
        return img
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    //MARK: - Setup Views
    private func setupViews() {
        view.layer.cornerRadius = Constants.cornerRad
        setupDetailView()
        
    }
    private func setupDetailView() {
        view.addSubview(detView)
        
        NSLayoutConstraint.activate([
            detView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(Constants.bottom)),
            detView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: Constants.viewHeightMulti),
            detView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leftRight),
            detView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(Constants.leftRight))
        ])
        setupLocationLabel()
        setupAddressLabel()
        setupCloseBtn()
    }
    
    private func setupLocationLabel() {
        detView.addSubview(locationNameLabel)
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: detView.topAnchor, constant: Constants.upDown),
            locationNameLabel.leadingAnchor.constraint(equalTo: detView.leadingAnchor),
            locationNameLabel.trailingAnchor.constraint(equalTo: detView.trailingAnchor),
        ])

    }
    private func setupAddressLabel(){
        detView.addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: detView.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: detView.trailingAnchor),
            addressLabel.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: Constants.labelsDistance),
            addressLabel.bottomAnchor.constraint(equalTo: detView.bottomAnchor, constant: -Constants.upDown)
        ])
    }
    private func setupCloseBtn(){
        detView.addSubview(closeImageView)
        NSLayoutConstraint.activate([
            closeImageView.topAnchor.constraint(equalTo: detView.topAnchor),
            closeImageView.trailingAnchor.constraint(equalTo: detView.trailingAnchor),
            closeImageView.heightAnchor.constraint(equalToConstant: Constants.imgSize),
            closeImageView.widthAnchor.constraint(equalToConstant: Constants.imgSize )
        
        ])

    }

    
    

}
extension LocationDetailsViewController {
    struct Constants {
        static let bottom: CGFloat = 20
        static let leftRight: CGFloat = 20
        static let upDown: CGFloat = 44
        static let imgSize: CGFloat = 44
        static let viewHeightMulti: CGFloat = 0.15
        static let labelsDistance: CGFloat = 2
        static let cornerRad: CGFloat = 20
        
    }
}

//MARK: - Protocol Extension
extension LocationDetailsViewController: LocationDetailsViewProtocol {
    @objc func closeView() {
        closeImageView.image = UIImage(named: "CloseIconHighlighted")
        dismiss(animated: true)
    }
    
    
}
