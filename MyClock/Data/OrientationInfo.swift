//
//  OrientationInfo.swift
//  MyClock
//
//  Created by Huy Ong on 4/8/21.
//

import Foundation
import UIKit
import SwiftUI


final class OrientationInfo: ObservableObject {
    enum Orientation {
        case portrait
        case landscape
    }
    
    @Published var orientation: Orientation
    
    private var _observer: NSObjectProtocol?
    
    init() {
        if UIDevice.current.orientation.isLandscape {
            self.orientation = .landscape
        } else {
            self.orientation = .portrait
        }
        
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil, using: { [unowned self] note in
            guard let device = note.object as? UIDevice else { return }
            if device.orientation.isPortrait {
                self.orientation = .portrait
            } else if device.orientation.isLandscape {
                self.orientation = .landscape
            }
        })
    }
    
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
