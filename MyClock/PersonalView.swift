//
//  PersonalView.swift
//  MyClock
//
//  Created by Huy Ong on 4/9/21.
//

import SwiftUI

struct PersonalView: View {
    @EnvironmentObject var model: TimerObserver
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Focus Time")
                .font(.headline)
            
            Text(model.updateTime)
                .font(.title)
                .frame(maxWidth: .infinity)
            GeometryReader { geo in
                HStack(alignment: .bottom, spacing: 3) {
                    ForEach(model.data, id: \.self) { value in
                        VStack {
                            VStack(spacing: 5) {
                                Text(String.fromSecondToString(value.duration))
                                    .font(.footnote)
                                Capsule(style: .circular)
                                    .frame(width: 35, height: geo.size.height/1.5 * CGFloat(value.duration) / model.max)
                            }
                            .opacity(value.duration < 60 ? 0 : 1)
                            
                            Text(value.day.description)
                                .padding(5)
                                .overlay(
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .frame(width: 25, height: 25)
                                )
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(WeekDay.isToday(value.day) ? .white : Color.white.opacity(0.65))
                    }
                }
            }
            .padding()
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView()
    }
}

