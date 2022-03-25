//
//  LocationDetailsViewModel .swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/24/22.
//

import Foundation

class LocationDetailsViewModel {
    private var statePresenter: StatePresenter?
    
    init (statePresenter: StatePresenter) {
        self.statePresenter = statePresenter
    }
    
    func loadData(_ placeId: String) {
        statePresenter?.render(state: .loading)
        PlacesInformationRepo().getPlace(from: placeId) {[weak self] result in
            guard let self = self else { return }
            self.handleDataLoading(result: result)
        }

    }
    
    func handleDataLoading(result: Result<Place, Error>) {
        switch result {
        case .success(let place):
            setData(place: place)
        case .failure(let error):
            statePresenter?.render(state: .error(error))
        }
    }
    func setData(place: Place) {
        statePresenter?.render(state: .loaded(with: place))
    }
}
