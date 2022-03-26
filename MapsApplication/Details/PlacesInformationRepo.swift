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
    private var cache = [String: Place]()
    
    func getPlace(from placeID: String, completion: ((Result<Place, Error>) -> Void)?) {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]

        if loadPlaceFromCache(placeID, completion: completion) != nil {
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
                self.storePlaceToCache(placeID, Place(name: placeName, details: details) )
            }
        }
        
    }
    
    
    fileprivate func loadPlaceFromCache(_ placeID: String) -> Place?{
        cache[placeID]
    }
    fileprivate func storePlaceToCache(_ placeID: String, _ place: Place) {
        cache[placeID] = place
    }
    private func loadPlaceFromCache(_ placeID: String, completion: ((Result<Place, Error>) -> Void)?) -> Place? {
        guard let place = loadPlaceFromCache(placeID) else {
            completion?(.failure(PlacesServiceError.notFound))
            return nil
        }
        completion?(.success(place))
        return place
    }

}

enum PlacesServiceError: Error {
    case with(description: String)
    case noFormat
    case placeError
    case notFound
}

// TODO: Add localized description

struct Place {
    var name: String
    var details: String
}
