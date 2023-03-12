//
//  ReservationsView.swift
//  LittleLemonRestaurant
//
//  Created by Abirami Kalyan on 12/03/2023.
//

import SwiftUI

struct ReservationsView: View {
    @EnvironmentObject var reservationsModel: ReservationsModel
    @State private var showCancellationConfirmationAlert = false
    @State private var reservationToDelete: ReservationDetails?
    private let dateFormatter = DateFormatter()
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                LittleLemonLogoView()
                Text("Reservations")
                    .padding(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                Spacer()
                if reservationsModel.currentReservations.isEmpty {
                    VStack {
                        Spacer()
                        Text("No reservations")
                            .frame(alignment: .center)
                        Spacer()
                    }
                } else {
                    NavigationStack {
                        List(reservationsModel.currentReservations) { reservation in
                            NavigationLink {
                                ReservationDetailsView(reservation: reservation)
                            } label: {
                                self.makeReservationListItemWithSwipeAction(reservation: reservation)
                            }
                        }.alert("Are you sure to cancel the reservation?", isPresented: $showCancellationConfirmationAlert) {
                            Button("Delete", role: .destructive) {
                                if let reservationToDelete = reservationToDelete {
                                    reservationsModel.removeReservation(reservation: reservationToDelete)
                                }
                            }
                            Button("Cancel", role: .cancel) {
                                reservationToDelete = nil
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder private func makeReservationListItemWithSwipeAction(reservation: ReservationDetails) -> some View {
        VStack(alignment: .leading) {
            RestaurantDetailView(locationItem: reservation.restaurant)
            Text(reservation.name)
                    .padding([.top, .bottom], 10)
            Text(getFormattedDate(reservation.reservationTime))
                .foregroundColor(Color.cyan)
        }.swipeActions {
            Button("Delete", role: .destructive) {
                reservationToDelete = reservation
                showCancellationConfirmationAlert = true
            }
        }
    }
    
     private func getFormattedDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "E, d MMM y, HH:mm"
        return dateFormatter.string(from: date)
    }
}

struct ReservationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationsView().environmentObject(ReservationsModel())
    }
}
