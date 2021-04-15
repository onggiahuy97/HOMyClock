//
//  DateFormatter+Extension.swift
//  MyClock
//
//  Created by Huy Ong on 4/12/21.
//

import Foundation

extension Date {
    static func toAMPM(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter.string(from: date)
    }
}
