//
//  Event.swift
//  Event Countdown
//
//  Created by MAC on 8/26/24.
//

import SwiftUI

struct Event: Identifiable, Comparable {
    let id: UUID
    var title: String
    var date: Date
    var textColor: Color

    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.date < rhs.date
    }
}
