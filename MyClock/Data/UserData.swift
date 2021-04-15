//
//  UserData.swift
//  MyClock
//
//  Created by Huy Ong on 4/9/21.
//

import Foundation

enum WeekDay: Int, CaseIterable, Codable {
    case sunday, monday, tuesday, wednesday, thrusday, friday, satuaday
    
    var description: String {
        switch self {
        case .monday:
            return "M"
        case .tuesday:
            return "T"
        case .wednesday:
            return "W"
        case .thrusday:
            return "T"
        case .friday:
            return "F"
        case .satuaday:
            return "S"
        case .sunday:
            return "S"
        }
    }
    
    static func isToday(_ day: WeekDay) -> Bool {
        return getDayIndex() == day.rawValue ? true : false
    }
    
    static func getDayIndex() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eeee"
        let dayString = dateFormatter.string(from: Date())
        switch dayString {
        case "Sunday":
            return 0
        case "Monday":
            return 1
        case "Tuesday":
            return 2
        case "Wednesday":
            return 3
        case "Thrusday":
            return 4
        case "Friday":
            return 5
        default:
            return 6
        }
    }
}

struct TimeData: Hashable, Codable {
    let day: WeekDay
    var duration: TimeInterval
}

extension TimeData {
    static func initilizeData() -> [TimeData] {
        let data: [TimeData] = [
            .init(day: .sunday, duration: 0),
            .init(day: .monday, duration: 0),
            .init(day: .tuesday, duration: 0),
            .init(day: .wednesday, duration: 0),
            .init(day: .thrusday, duration: 0),
            .init(day: .friday, duration: 0),
            .init(day: .satuaday, duration: 0)
        ]
        return data
    }
}
