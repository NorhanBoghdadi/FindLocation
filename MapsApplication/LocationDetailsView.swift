//
//  LocationDetailsView.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/19/22.
//

import UIKit

protocol LocationDetailsViewProtocol {
    func closeView()
}

class LocationDetailsView: UIView {
    
    //MARK: - Declaring Views
    
    //Declare first label
    lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 44, width: CGFloat.greatestFiniteMagnitude, height: .greatestFiniteMagnitude)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor(displayP3Red: 10, green: 39, blue: 55, alpha: 1)
        return label
    }()
    
    //Declare details label
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y:  -44, width: CGFloat.greatestFiniteMagnitude, height: .greatestFiniteMagnitude)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor(displayP3Red: 181, green: 190, blue: 195, alpha: 1)
        return label
    }()
    
    //Declare close buttons
    lazy var closeImageView: UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: -0, y: 0, width: 44, height: 44)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "CloseIconNormal")
        img.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.closeView))
        tapGesture.numberOfTapsRequired = 1
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tapGesture)
        return img
        
    }()
    lazy var closeImageViewHighlighted: UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: -0, y: 0, width: 44, height: 44)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "CloseIconHighlighted")
        img.clipsToBounds = true
        return img
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    //MARK: - Setup Views
    func setupViews() {
        self.backgroundColor = UIColor(named: "BackgroundColor")
        self.layer.cornerRadius = 20
        
        self.addSubview(locationNameLabel)
        self.addSubview(addressLabel)
        self.addSubview(closeImageView)
        
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Protocol Extension
extension LocationDetailsView: LocationDetailsViewProtocol {
    @objc func closeView() {
        closeImageView.removeFromSuperview()
        self.addSubview(closeImageViewHighlighted)
    }
    
    
}
