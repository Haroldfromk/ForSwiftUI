//
//  Day.swift
//  SwiftCal
//
//  Created by Dongik Song on 12/10/24.
//
//

import Foundation
import SwiftData


@Model class Day {
    var date: Date
    var didStudy: Bool

    init(date: Date, didStudy: Bool) {
        self.date = date
        self.didStudy = didStudy
    }
}
