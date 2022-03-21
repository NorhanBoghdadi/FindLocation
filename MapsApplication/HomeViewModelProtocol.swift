//
//  HomeViewModelProtocol.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/20/22.
//

import Foundation
import GooglePlaces

protocol HomeViewModelProtocol: AnyObject{
    var placesClient: GMSPlacesClient {get}
    func getPlace(from placeID: String)
}


class HomeViewModel: HomeViewModelProtocol {
   
    //MARK: - Setup Places
    var placesClient = GMSPlacesClient.shared()

    func getPlace(from placeID: String) {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]
        placesClient.fetchPlace(fromPlaceID: placeID, placeFields: placeFields, sessionToken: nil)  { (place, error) in
            guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
            }

            guard let place = place else {
                print("No current place")
                return
            }
            

        }
    }
}
