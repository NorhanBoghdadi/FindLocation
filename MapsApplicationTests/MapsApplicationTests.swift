//
//  MapsApplicationTests.swift
//  MapsApplicationTests
//
//  Created by Norhan Boghdadi on 3/19/22.
//

import XCTest
@testable import MapsApplication

class MapsApplicationTests: XCTestCase {

    // Get place class Test
    var sut = PlacesInformationRepo().getPlace(from: "ChIJP9-RmA-PsUcRzaexTVBsidM") { results in
        switch results {
        case .success(let place):
            XCTAssertEqual(place.name, "THE MADISON Hotel Hamburg")
        case .failure(let error):
            print("Error")
        }
    }

}
