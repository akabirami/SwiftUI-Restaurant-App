//
//  MainView.swift
//  LittleLemonRestaurant
//
//  Created by Abirami Kalyan on 12/03/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "fork.knife")
                }
            
            ReservationsView()
                .tabItem {
                    Label("Reservations", systemImage: "square.and.pencil")
                }
            .navigationTitle("Little Lemon Restaurants")
        }.environmentObject(ReservationsModel())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
