//
//  LocationDetailsViewModel .swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/24/22.
//

import Foundation

class LocationDetailsViewModel {
    private var statePresenter: StatePresenter?
    var place:  Place
    
    init (statePresenter: StatePresenter, place: Place) {
        self.statePresenter = statePresenter
        self.place = place
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
        self.place = place
        statePresenter?.render(state: .loaded)
    }
}
