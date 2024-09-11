//
//  Event.swift
//  Event Countdown
//
//  Created by MAC on 9/11/24.
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
