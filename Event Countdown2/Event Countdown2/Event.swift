//
//  Event.swift
//  Event Countdown2
//
//  Created by MAC on 8/29/24.
//

import SwiftUI

struct Event: Identifiable, Comparable, Hashable {
    let id: UUID
    var title: String
    var date: Date
    var textColor: Color

    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.date < rhs.date
    }
}

