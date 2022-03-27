//
//  CacheRepo.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/27/22.
//

import Foundation

class CacheRepo {
    private var cache = [String: Place]()
    
    
    func loadPlaceFromCache(_ placeID: String) -> Place?{
        cache[placeID]
    }
    func storePlaceToCache(_ placeID: String, _ place: Place) {
        cache[placeID] = place
    }
    func loadPlaceFromCache(_ placeID: String, completion: ((Result<Place, Error>) -> Void)?) -> Place? {
        guard let place = loadPlaceFromCache(placeID) else {
            completion?(.failure(PlacesServiceError.notFound))
            return nil
        }
        completion?(.success(place))
        return place
    }

}
