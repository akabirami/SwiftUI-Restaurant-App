//
//  ReservationForm.swift
//  LittleLemonRestaurant
//
//  Created by Abirami Kalyan on 12/03/2023.
//

import SwiftUI

struct ReservationForm: View {
    // this environment variable stores the presentation mode status
    // of this view. This will be used to dismiss this view when
    // the user taps on the confirm reservation button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isReservationFormShown: Bool
    @EnvironmentObject var reservationsModel: ReservationsModel
    enum FocusedField {
        case nameField
        case number
        case email
    }
    @FocusState private var focusedField: FocusedField?
    
    var locationItem: RestaurantLocation
    @State private var errorMessage: String = ""
    @State private var showErrorAlert = false
    
    @State private var selectedDate = Date.now
    @State private var partySize = 1
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var specialRequest = ""
    
    var body: some View {
        VStack {
            RestaurantDetailView(locationItem: locationItem)
            Form {
                let startDate = Date.now
                let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
                
                DatePicker("Select date and time", selection: $selectedDate, in: startDate...endDate)
                
                Stepper("Party size \(partySize)", value: $partySize, in: 1...15)
                
                HStack {
                    Text("Name")
                    TextField("Enter name", text: $name)
                        .padding(.leading, 25)
                        .focused($focusedField, equals: .nameField)
                }
                
                HStack {
                    Text("Phone")
                    TextField("Enter phone number", text: $phone)
                        .padding(.leading, 25)
                        .focused($focusedField, equals: .number)
                }
                
                HStack {
                    Text("Email")
                    TextField("Enter email", text: $email)
                        .padding(.leading, 25)
                        .focused($focusedField, equals: .email)
                }
                
                VStack(alignment: .leading) {
                    Text("Any special request ?")
                    TextEditor(text: $specialRequest)
                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: 150)
                        .border(Color.secondary)
                }
                
                HStack {
                    Spacer()
                    Button("Confirm Reservation") {
                        addNewReservation()
                    }
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .foregroundColor(Color.primary)
                    Spacer()
                }
            }
            .alert("Error in form", isPresented: $showErrorAlert) {
                Button ("Ok") {
                    errorMessage = ""
                }
            } message: {
                Text(errorMessage)
            }
        }.onAppear {
            isReservationFormShown = true
        }.onDisappear {
            isReservationFormShown = false
        }
    }
    
    private func addNewReservation() {
        if (isDataValid()) {
            reservationsModel.addReservation(reservation: ReservationDetails(name: name, phoneNumber: phone, email: email, specialRequest: specialRequest, numberOfPeople: partySize, reservationTime: selectedDate, restaurant: locationItem))
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func isDataValid() -> Bool {
//        if !isValidName(name) {
//            print("abi data is not valid 1")
//            focusedField = .nameField
//        } else if !isValidNumber(phone) {
//            print("abi data is not valid 2")
//            focusedField = .number
//        } else if !isValidEmail(email){
//            print("abi data is not valid 3")
//            focusedField = .email
//        } else {
//            return true
//        }
        
        let isNameValid = isValidName(name)
        let isPhoneValid = isValidNumber(phone)
        let isEmailValid = isValidEmail(email)
        
        guard isNameValid, isPhoneValid, isEmailValid else {
            showErrorAlert = true
            return false
        }
        
        return true
    }
    
    func isValidName(_ name: String) -> Bool {
        if name.isEmpty {
            errorMessage += "Name can't be empty\n\n"
            return false
        } else if(name.rangeOfCharacter(from: NSCharacterSet.letters.inverted) != nil){
            errorMessage += "Name can only have letters\n\n"
            return false
        }
        return true
    }
    
    func isValidNumber(_ phoneNumber: String) -> Bool {
        if phoneNumber.isEmpty {
            errorMessage += "phoneNumber can't be empty\n\n"
            return false
        } else if(phoneNumber.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) != nil){
            errorMessage += "phoneNumber can only have numbers\n\n"
            return false
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty {
            errorMessage += "email can't be empty\n\n"
            return false
        } else if(!emailPred.evaluate(with: email)){
            errorMessage += "email format is invalid\n\n"
            return false
        }
        return true
    }
}


struct ReservationForm_Previews: PreviewProvider {
    static var previews: some View {
        ReservationForm(
            isReservationFormShown: .constant(true),
            locationItem: RestaurantLocation(city: "London", neighborhood: "Wembley", phoneNumber: "+44 1234534232"))
        .environmentObject(ReservationsModel())
    }
}
