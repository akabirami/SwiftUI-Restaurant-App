//
//  ReservationDetailsView.swift
//  LittleLemonRestaurant
//
//  Created by Abirami Kalyan on 12/03/2023.
//

import SwiftUI

struct ReservationDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var reservation: ReservationDetails
    private let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("RESTAURANT")
                .padding(.bottom, 15)
            RestaurantDetailView(locationItem: reservation.restaurant)
            Divider()
            Group {
                ReservationItemView(itemName: "Name:", itemValue: reservation.name)
                ReservationItemView(itemName: "Email:", itemValue: reservation.email)
                ReservationItemView(itemName: "Phone:", itemValue: reservation.phoneNumber)
                ReservationItemView(itemName: "Party", itemValue: String(reservation.numberOfPeople))
            }.padding(.bottom, 15)
            
            Group {
                ReservationItemView(itemName: "Date:", itemValue: formatDate(reservation.reservationTime))
                ReservationItemView(itemName: "Time:", itemValue: formatTime(reservation.reservationTime))
            }.padding(.bottom, 15)
            
            Group {
                ReservationItemView(itemName: "Special Request:", itemValue: "")
                ReservationItemView(itemName: "", itemValue: reservation.specialRequest)
            }.padding(.bottom, 15)
            
        }
        .padding(.leading, 10)
        .onDisappear{
            self.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    private func formatDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "E , dd MMM y"
        return dateFormatter.string(from: date)
    }
    
    private func formatTime(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

struct ReservationItemView: View {
    var itemName: String
    var itemValue: String
    var body: some View {
        HStack {
            Text(itemName)
                .foregroundColor(Color.secondary.opacity(0.5))
            Text(itemValue)
        }
    }
}

struct ReservationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationDetailsView(reservation: ReservationDetails(name: "abi", phoneNumber: "1234343", email: "a@bcd.com", specialRequest: "Vegan", numberOfPeople: 5, reservationTime: Date.now, restaurant: RestaurantLocation(city: "London", neighborhood: "Wembley", phoneNumber: "343232322")))
    }
}
