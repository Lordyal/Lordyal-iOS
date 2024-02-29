//
//  UserProfileInputView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 08/06/2023.
//

import Foundation
import SwiftUI
import PhoneNumberKit
import Combine

struct UserProfileInputView: View {
    @EnvironmentObject var urlModel: InvocationURLModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: UserProfileInputViewModel
    @State var date = Date()
    @State var dateText: String = ""
    @State var prevText: String = ""
    @State var isInvalid = false
    @State var showDatePicker = false
    let rewardModel: RewardModel
    var phoneNumberKit = PhoneNumberKit()
    private let phoneLimit = 10


    func testPhone() {
        print(phoneNumberKit.countryCode(for: "VN") ?? 0)
    }

    var df: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "MM / dd / yyyy"
        return df
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.lightGreen
                    .ignoresSafeArea()
                VStack {
                    Spacer().frame(height: 30)
                    Text("To redeem your reward and make sure you receive the best personalized offers, we want to know more about you.")
                        .font(.Body())
                        .foregroundColor(.mediumGreen)
                        .padding(.bottom, 40)
                    Group {
                        Text("Gender")
                            .font(.Bold())
                            .foregroundColor(.boldGreen)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, -1)
                        VStack {
                            HStack {
                                GenderSelectionView(
                                    gender: .male,
                                    selected: viewModel.isMaleSelected
                                ) { viewModel.selectGender(.male) }
                                GenderSelectionView(
                                    gender: .female,
                                    selected: viewModel.isFemaleSelected
                                ) { viewModel.selectGender(.female) }
                            }
                            GenderSelectionView(
                                gender: .other,
                                selected: viewModel.isOtherSelected
                            ) { viewModel.selectGender(.other) }
                        }
                    }

                    Spacer().frame(height: 24)
                    Text("Date of Birth")
                        .font(.Bold())
                        .foregroundColor(.boldGreen)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, -1)
                    ZStack {
                        TextField(
                            "MM / DD / YYYY",
                            text: $dateText,
                            onCommit: {
                                if let d = df.date(from: dateText) {
                                    date = d
                                } else {
                                    isInvalid = true
                                }
                            }
                        )
                        .keyboardType(.numberPad)
                        .onTapGesture {
                            isInvalid = false
                        }
                        .onChange(of: dateText) { new in
                            let size = new.count
                            if size < prevText.count {
                                if size == 4 || size == 9 {
                                    dateText.removeLast(4)
                                    prevText = dateText
                                }
                            }
                            if size > 14 {
                                dateText = String(dateText.prefix(14))
                                prevText = dateText
                            }
                            else if size == 2 || size == 7 {
                                dateText += " / "
                                prevText = dateText
                            }
                            if let d = df.date(from: dateText) {
                                date = d
                            }
                        }
                        HStack {
                            Spacer()
                            Button {
                                showDatePicker.toggle()
                            } label: {
                                Image(systemName: "calendar")
                                    .font(.system(size: 22, weight: .semibold))
                            }
                            .padding(.trailing, 5)
                        }
                    }
                    .font(.SemiBold())
                    .foregroundColor(.boldGreen)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(48)
                            .shadow(color: .gray.opacity(0.3), radius: 10)
                    }
                    
                    if (isInvalid) {
                        Text("Enter a valid date")
                            .font(.Body())
                            .foregroundColor(.mediumGreen)
                            .onAppear {
                                dateText = ""
                            }
                    }

                    Group {
                        Spacer().frame(height: 24)
                        Text("Phone number")
                            .font(.Bold())
                            .foregroundColor(.boldGreen)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, -1)
                        ZStack {
                            HStack {
                                HStack {
                                    Text("US")
                                        .font(.Bold(size: 16))
                                        .foregroundColor(.boldGreen)
                                        .padding(10)
                                        .background {
                                            RoundedRectangle(cornerRadius: 48)
                                                .stroke(.gray.opacity(0.5), lineWidth: 2)
                                                .foregroundColor(.black.opacity(0.05))
                                        }
                                    Text("+1")
                                        .font(.Bold(size: 16))
                                        .foregroundColor(.boldGreen)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background {
                                    RoundedRectangle(cornerRadius: 48)
                                        .foregroundColor(.white)
                                        .shadow(color: .gray.opacity(0.3), radius: 10)
                                }
                                TextField("Phone number", text: $viewModel.phoneNumber)
                                    .keyboardType(.numberPad)
                                    .onReceive(Just(viewModel.phoneNumber)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            viewModel.phoneNumber = filtered
                                        }
                                        if newValue.count > phoneLimit {
                                            viewModel.phoneNumber = String(newValue.prefix(phoneLimit))
                                        }
                                    }
                                    .font(.SemiBold())
                                    .foregroundColor(.boldGreen)
                                Spacer()
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 48)
                                .foregroundColor(Color(red: 248/255, green: 248/255, blue: 248/255))
                                .shadow(color: .gray.opacity(0.3), radius: 10)
                        }
                    }

                    Spacer()

                    HStack {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Later")
                        }
                        .buttonStyle(BackButton())
                        Spacer()
                        NavigationLink {
                            if viewModel.isFilled() {
                                ScanBarCodeView(reward: rewardModel)
                                    .navigationBarBackButtonHidden()
                            }
                        } label: {
                            Text("Redeem")
                        }
                        .buttonStyle(RoundButton())
                        .simultaneousGesture(TapGesture().onEnded{
                            viewModel.dateOfBirth = date
                            if let userProfile = viewModel.toUserProfileModel() {
                                userProfile.saveUserProfile(loginToken: urlModel.loginToken)
                            }
                            rewardModel.redeemReward(merchantID: urlModel.merchantID, storeID: urlModel.storeID)
                        })
                    }
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 20, trailing: 0))
                }
                .padding(.horizontal, 36)
                
                if (showDatePicker) {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                        DatePickerView(date: $date, show: $showDatePicker)
                            .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.boldGreen)
    }
}

struct UserProfileInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileInputView(
            viewModel: UserProfileInputViewModel(),
            rewardModel: RewardModel(
                id: 1,
                points: 6,
                totalPoints: 6,
                storeName: "Taperk's Kitchen",
                rewardDescription: "Free Normal Size Spaghetti",
                createdAt: "2023-06-24T21:11:47.283Z",
                endAt: "2023-07-01T03:38:11.000Z"
            )
        )
        .environmentObject(InvocationURLModel.shared)
    }
}

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(16)
            .background {
                Rectangle()
                    .foregroundColor(.white)
            }
            .cornerRadius(48)
            .shadow(color: .gray.opacity(0.3), radius: 10)
    }
}
