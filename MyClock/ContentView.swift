//
//  ContentView.swift
//  MyClock
//
//  Created by Huy Ong on 4/8/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    enum SelectionTab {
        case clockView, personal
    }
    
    @State private var selectedTab: SelectionTab = .clockView
    
    var tabView: some View {
        TabView(selection: $selectedTab) {
            ClockView()
                .tag(SelectionTab.clockView)
            PersonalView()
                .tag(SelectionTab.personal)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .statusBar(hidden: true)
        .onTapGesture {
            withAnimation {
                selectedTab = selectedTab == SelectionTab.clockView ? .personal : .clockView
            }
        }
    }
    
    var body: some View {
        tabView
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = TimerObserver()
        ContentView()
            .environmentObject(model)
            .environmentObject(OrientationInfo())
        
    }
}
