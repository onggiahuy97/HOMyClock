//
//  TimerObserver.swift
//  MyClock
//
//  Created by Huy Ong on 4/8/21.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class TimerObserver: ObservableObject {
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var day: String = ""
    @Published var updateTime: String = "00:00:00"
    @Published var data: [TimeData] = [] {
        didSet {
            max = data.reduce(1.0, { (result, time) in
                Swift.max(result, CGFloat(time.duration))
            })
        }
    }
    
    
    let calander = Calendar.current
    var max: CGFloat = 1.0
    var lasTime: Date
    var cancellables = Set<AnyCancellable>()
    
    var currentTime: Date = Date() {
        didSet {
            hour = calander.component(.hour, from: currentTime)
            minute = calander.component(.minute, from: currentTime)
            day = Date.toAMPM(currentTime)
        }
    }
    
    init() {
        lasTime = Date()
        shouldResetData()
        loadDataUpdates()
        
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { date in
                DispatchQueue.main.async {
                    self.currentTime = date
                    self.changeTime(date)
                }
            }
            .store(in: &cancellables)
    }
}

extension TimerObserver {
    
    func shouldResetData() {
        let index = WeekDay.getDayIndex()
        let dataCheck = data.dropFirst().reduce(0.0, { $0 + $1.duration })
        if index == 0, dataCheck > 0 {
            for i in 0..<7 {
                data[i].duration = 0
            }
        }
    }
    
    func writeDataUpdates() {
        do {
            shouldResetData()
            let dataEncode = try JSONEncoder().encode(data)
            try dataEncode.write(to: FileManager.userDataUpdatesDataPath(), options: .atomic)
        } catch {
            fatalError("Failed to encode data \(error)")
        }
    }
    
    func loadDataUpdates() {
        do {
            let dataDecode = try Data(contentsOf: FileManager.userDataUpdatesDataPath())
            data = try JSONDecoder().decode([TimeData].self, from: dataDecode)
        } catch {
            fatalError("Failed to decode data \(error)")
        }
    }
    
    func changeTime(_ date: Date) {
        let timeInterval = NSInteger(lasTime.distance(to: date))
        let hours = timeInterval / 3600
        let minutes = (timeInterval / 60) % 60
        let seconds = timeInterval % 60
        let string = NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        self.updateTime = string as String

    }
    
    public static func createSample() -> [TimeData] {
        var data = TimeData.initilizeData()
        for i in data.indices {
            data[i].duration = TimeInterval.random(in: 1000...5000)
        }
        return data
    }
}
