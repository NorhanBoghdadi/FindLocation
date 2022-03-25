//
//  LocationDetailsState.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/24/22.
//

import Foundation

enum State {
    case loading
    case loadedWithData
    case error(Error)
}

protocol ErrorCase {
    func show(error: Error)
}

protocol StatePresenter: ErrorCase {
    func render(state: State)
}
