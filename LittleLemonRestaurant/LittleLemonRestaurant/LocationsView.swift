//
//  LocationsView.swift
//  LittleLemonRestaurant
//
//  Created by Abirami Kalyan on 12/03/2023.
//

import SwiftUI

struct LocationsView: View {
    @ObservedObject var locationsModel = LocationsModel()
    @State var isReservationFormShown: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack{
                LittleLemonLogoView()
                Text(isReservationFormShown ? "Resevation Details": "Select a location")
                    .padding(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                
                NavigationStack {
                    List(locationsModel.restaurantLocations) { location in
                        NavigationLink {
                            ReservationForm(isReservationFormShown: $isReservationFormShown, locationItem: location)
                        } label: {
                            RestaurantDetailView(locationItem: location)
                        }
                        
                    }
                }
            }
//            .scrollContentBackground(.hidden)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
