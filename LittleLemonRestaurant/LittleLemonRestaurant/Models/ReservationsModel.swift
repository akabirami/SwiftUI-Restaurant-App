//
//  ReservationsModel.swift
//  LittleLemonRestaurant
//
//  Created by Abirami Kalyan on 12/03/2023.
//

import Foundation

struct ReservationDetails: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let phoneNumber: String
    let email: String
    let specialRequest: String
    let numberOfPeople: Int
    let reservationTime: Date
    let restaurant: RestaurantLocation
    
    static func == (lhs: ReservationDetails, rhs: ReservationDetails) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

class ReservationsModel: ObservableObject {
    
    @Published var currentReservations = [ReservationDetails]()
//    @Published var currentReservations: [ReservationDetails] = [
//        ReservationDetails(name: "Abi", phoneNumber: "12345645434", email: "abi@gmail.com", specialRequest: "Vegan", numberOfPeople: 2, reservationTime: Date.now, restaurant: RestaurantLocation(city: "London", neighborhood: "Wembley", phoneNumber: "+443232323")),
//
//        ReservationDetails(name: "XYZ", phoneNumber: "12345645434", email: "xyz@gmail.com", specialRequest: "", numberOfPeople: 7, reservationTime: Date.now, restaurant: RestaurantLocation(city: "London", neighborhood: "Harrow", phoneNumber: "+443232323"))
//    ]
//
    func addReservation(reservation: ReservationDetails) {
        currentReservations.append(reservation)
    }
    
    func removeReservation(reservation: ReservationDetails) {
        currentReservations.removeAll { $0.id == reservation.id }
    }
}

