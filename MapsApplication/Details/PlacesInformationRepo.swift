//
//  PlacesInformationRepo.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/24/22.
//

import Foundation
import GooglePlaces


struct PlacesInformationRepo {
    var placesClient = GMSPlacesClient.shared()
    
    func getPlace(from placeID: String, completion: ((Result<Place, Error>) -> Void)?) {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]

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
        }
    }
}

enum PlacesServiceError: Error {
    case with(description: String)
    case noFormat
    case placeError
}

// TODO: Add localized description

struct Place {
    var name: String
    var details: String
}
