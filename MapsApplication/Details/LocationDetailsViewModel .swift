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
    
    func loadData() {
        statePresenter?.render(state: .loading)
    }
    
    func handleDataLoading(result: Result<Place, Error>) {
        switch result {
        case .success(let place):
            //set data
        case .failure(let error):
            statePresenter?.render(state: .error(error))
        }
    }
    func dataLoader() {
        statePresenter?.render(state: .loadedWithData)
    }
}
