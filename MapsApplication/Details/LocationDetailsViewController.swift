//
//  LocationDetailsViewController.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/21/22.
//

import UIKit

// View Model
// 3 states : Loading/ loaded with data / error 


class LocationDetailsViewController: UIViewController {
    private lazy var detailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .color(for: .BackgroundColor)
        view.layer.cornerRadius = Constants.cornerRad
        return view
    }()
    
    private lazy var addressLabelsStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [locationNameLabel,
                                                       addressLabel
        ])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        return stackview
    }()
    
    //Declare name label
    private lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Something something"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .color(for: .PrimaryTextColor)

        return label
    }()
    
    //Declare details label
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "SOMETHING"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.textColor = .color(for: .SecondaryTextColor)
        return label
    }()
    
    //Declare close button
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "CloseIconNormal"), for: .normal)
        btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return btn
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupViews()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        view.layer.cornerRadius = Constants.cornerRad
        setupDetailView()
    }
    
    private func setupDetailView() {
        view.addSubview(detailsView)
        
        NSLayoutConstraint.activate([
            detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(Constants.bottom)),
            detailsView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: Constants.viewHeightMulti),
            detailsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leftRight),
            detailsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(Constants.leftRight))
        ])

        setupCloseButton()
        setupLabelsStack()
    }
    

    private func setupLabelsStack() {
        detailsView.addSubview(addressLabelsStackView)
        
        NSLayoutConstraint.activate([
            addressLabelsStackView.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: Constants.upDown),
            addressLabelsStackView.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: -Constants.upDown),
            addressLabelsStackView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor),
            addressLabelsStackView.widthAnchor.constraint(equalTo: detailsView.widthAnchor)
        ])
        
    }
    
    private func setupCloseButton(){
        detailsView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: detailsView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.imgSize),
            closeButton.widthAnchor.constraint(equalToConstant: Constants.imgSize )
        
        ])
    }

}

extension LocationDetailsViewController {
    func setData(_ placeId: String) {
        closeButton.setImage(UIImage(named: "CloseIconNormal"), for: .normal)
        PlacesInformationRepo().getPlace(from: placeId) { results in
            switch results {
            case .success(let place):
                self.locationNameLabel.text = place.name
                self.addressLabel.text = place.details
            case .failure( _):
                print(PlacesServiceError.placeError)
            }
        }
    }
    
    @objc func closeView() {
        closeButton.setImage(UIImage(named: "CloseIconHighlighted"), for: .normal)
        dismiss(animated: true)
    }

}

extension LocationDetailsViewController: StatePresenter {
    func render(state: State) {
        switch state {
        case .loading:
            // view for loading
        case .loadedWithData:
            // data loaded
        case .error(let error):
            show(error: error)
        }
    }
    
    func show(error: Error) {
        // create view for error state
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
