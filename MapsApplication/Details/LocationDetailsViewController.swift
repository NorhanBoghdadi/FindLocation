//
//  LocationDetailsViewController.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/21/22.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    private var viewModel: LocationDetailsViewModel?
    
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
        setupViews()
        viewModel = LocationDetailsViewModel(statePresenter: self)
        view.backgroundColor = .clear
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
        viewModel?.loadData(placeId)
        
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
            print("loading")
        case .loaded(with: let place):
            locationNameLabel.text = place.name
            addressLabel.text = place.details
            print("Loaded")
        case .error(let error):
            show(error: error)
        case .initial:
            print("init")
        }
    }
    //TODO : Error & loading views
    func show(error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
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
