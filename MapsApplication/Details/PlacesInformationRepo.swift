//
//  PlacesInformationRepo.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/24/22.
//

import Foundation
import GooglePlaces


class PlacesInformationRepo {
    private var placesClient = GMSPlacesClient.shared()
    private var cache = CacheRepo()
    
    func getPlace(from placeID: String, completion: ((Result<Place, Error>) -> Void)?) {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]

        if cache.loadPlaceFromCache(placeID, completion: completion) != nil {
            return
        } else {
            placesClient.fetchPlace(
                fromPlaceID: placeID,
                placeFields: placeFields,
                sessionToken: nil
            )  { (place, error) in
                guard error == nil else {
                    if let desc = error?.localizedDescription {
                        completion?(.failure(PlacesServiceError.with(description: desc)))
                    } else {
                        completion?(.failure(PlacesServiceError.placeError))
                    }
                    return
                }

                guard let placeName = place?.name, let details = place?.formattedAddress else {
                    completion?(.failure(PlacesServiceError.noFormat))
                    return
                }
                
                completion?(.success(.init(name: placeName, details: details)))
                self.cache.storePlaceToCache(placeID, Place(name: placeName, details: details) )
            }
        }
        
    }

}

enum PlacesServiceError: Error {
    case with(description: String)
    case noFormat
    case placeError
    case notFound
}


struct Place {
    var name: String
    var details: String
}
