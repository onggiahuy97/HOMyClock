//
//  String+Extensions.swift
//  MyClock
//
//  Created by Huy Ong on 4/16/21.
//

import Foundation

extension String {
    static func fromSecondToString(_ time: TimeInterval) -> String {
        let hours = NSInteger(time) / 3600
        let minutes = (NSInteger(time) / 60) % 60
        let string = String(format: "%0.2d:%0.2d", hours, minutes)
        return string
    }
}
