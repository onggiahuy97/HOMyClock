//
//  PortraitView.swift
//  MyClock
//
//  Created by Huy Ong on 4/8/21.
//

import SwiftUI

struct ClockView: View {
    @EnvironmentObject var orientation: OrientationInfo
    @EnvironmentObject var model: TimerObserver
    
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Spacer()
                    if orientation.orientation == .landscape {
                        toLandscapeView(geo)
                    } else {
                        toPortraitView(geo)
                    }
                    Spacer()
                }
                
                Text(model.updateTime)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: height)
            .foregroundColor(.white)
        }
    }
    
    func toPortraitView(_ geo: GeometryProxy) -> some View {
        let width = geo.size.width
        let textSize = width / 2.2
        let dayFont = Font.system(size: 25, weight: .bold, design: .serif)
        let hourMinuteFont = Font.system(size: textSize, weight: .bold, design: .serif)
        return VStack(spacing: 25) {
            ZStack(alignment: .topLeading) {
                Text(model.day)
                    .font(dayFont)
                Text(model.hour.toString())
                    .font(hourMinuteFont)
            }
            VStack(spacing: 10) {
                Circle()
                Circle()
            }
            .frame(width: 50, height: 50)
            .foregroundColor(.white)
            Text(model.minute.toString())
                .font(hourMinuteFont)
        }
    }
    
    func toLandscapeView(_ geo: GeometryProxy) -> some View {
        let width = geo.size.height
        let size = width / 2
        let textSize = size / 1.4
        let dayFont = Font.system(size: 20, weight: .bold, design: .serif)
        let hourMinuteFont = Font.system(size: textSize, weight: .bold, design: .serif)
        return HStack(spacing: 25) {
            ZStack(alignment: .topLeading) {
                Text(model.day)
                    .font(dayFont)
                Text(model.hour.toString())
                    .font(hourMinuteFont)
            }
            .frame(width: size)
            
            VStack(spacing: 10) {
                Circle()
                Circle()
            }
            .frame(width: 50, height: 50)
            .foregroundColor(.white)
            
            Text(model.minute.toString())
                .font(hourMinuteFont)
                .frame(width: size)

        }
    }
    
    
}

struct PortraitView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
