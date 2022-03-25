//
//  LocationDetailsState.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/24/22.
//

import Foundation

enum State {
    case initial
    case loading
    case loaded(with: Place)
    case error(Error)
}

protocol ErrorCase {
    func show(error: Error)
}

protocol StatePresenter: ErrorCase {
    func render(state: State)
}
