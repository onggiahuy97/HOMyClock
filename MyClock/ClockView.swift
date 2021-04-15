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
        return VStack(spacing: 25) {
            ZStack(alignment: .topLeading) {
                Text(model.day)
                    .font(.system(size: 25, weight: .bold, design: .serif))
                Text(model.hour.toString())
                    .font(.system(size: textSize, weight: .bold, design: .serif))
            }
            VStack(spacing: 10) {
                Circle()
                Circle()
            }
            .frame(width: 50, height: 50)
            .foregroundColor(.white)
            Text(model.minute.toString())
                .font(.system(size: textSize, weight: .bold, design: .serif))
        }
    }
    
    func toLandscapeView(_ geo: GeometryProxy) -> some View {
        let width = geo.size.height
        let size = width / 2
        let textSize = size / 1.4
        return HStack(spacing: 25) {
            ZStack(alignment: .topLeading) {
                Text(model.day)
                    .font(.system(size: 20, weight: .bold, design: .serif))
                Text(model.hour.toString())
                    .font(.system(size: textSize, weight: .bold, design: .serif))
            }
            .frame(width: size)
            
            VStack(spacing: 10) {
                Circle()
                Circle()
            }
            .frame(width: 50, height: 50)
            .foregroundColor(.white)
            
            Text(model.minute.toString())
                .font(.system(size: textSize, weight: .bold, design: .serif))
                .frame(width: size)

        }
    }
    
    
}

struct PortraitView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
