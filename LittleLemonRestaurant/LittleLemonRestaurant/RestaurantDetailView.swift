//
//  RestaurantDetailView.swift
//  LittleLemonRestaurant
//
//  Created by Abirami Kalyan on 12/03/2023.
//

import SwiftUI

struct RestaurantDetailView: View {
    var locationItem: RestaurantLocation
    var body: some View {
        VStack(alignment: .leading) {
            Text(locationItem.city)
                .foregroundColor(.primary)
            HStack {
                Text(locationItem.neighborhood)
                Text(" - ")
                Text(locationItem.phoneNumber)
            }
            .foregroundColor(.secondary)
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(
            locationItem: RestaurantLocation(city: "London", neighborhood: "Wembley", phoneNumber: "+44 1234534232"))
    }
}
