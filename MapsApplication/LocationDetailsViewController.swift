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
    lazy var closeImageView: UIImageView = {
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
    func setupViews() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.layer.cornerRadius = Constants.cornerRad
        
        setupLocationLabel()
        setupAddressLabel()
        setupCloseBtn()
        
    }
    
    func setupLocationLabel() {
        view.addSubview(locationNameLabel)
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.labelY),
            locationNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])

    }
    func setupAddressLabel(){
        view.addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.labelY)
        ])
    }
    func setupCloseBtn(){
        view.addSubview(closeImageView)
        NSLayoutConstraint.activate([
            closeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            closeImageView.heightAnchor.constraint(equalToConstant: Constants.imgSize),
            closeImageView.widthAnchor.constraint(equalToConstant: Constants.imgSize )
        
        ])

    }

    
    

}
extension LocationDetailsViewController {
    struct Constants {
        static let labelX: CGFloat = 0
        static let labelY: CGFloat = 44
        static let imgSize: CGFloat = 44
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
