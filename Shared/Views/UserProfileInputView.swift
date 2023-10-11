//
//  UserProfileInputView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 08/06/2023.
//

import Foundation
import SwiftUI
import PhoneNumberKit

struct UserProfileInputView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: UserProfileInputViewModel
    let rewardModel: RewardModel
    @ObservedObject var urlModel: InvocationURLModel
    @State var date = Date()
    @State var showDatePicker = false
    var phoneNumberKit = PhoneNumberKit()

    func testPhone() {
        print(phoneNumberKit.countryCode(for: "VN") ?? 0)
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

                    Group {
                        Spacer().frame(height: 24)
                        Text("Date of Birth")
                            .font(.Bold())
                            .foregroundColor(.boldGreen)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, -1)
                        Text(date, style: .date)
                            .font(.SemiBold())
                            .foregroundColor(.boldGreen)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(48)
                                    .shadow(color: .gray.opacity(0.3), radius: 10)
                        }
                        .onTapGesture {
                            withAnimation {
                                showDatePicker.toggle()
                            }
                        }
//                        .sheet(isPresented: $showDatePicker) {
//                            DatePickerView(date: $date, show: $showDatePicker)
//                                .presentationDetents([.medium])
//                        }
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
                                ScanBarCodeView()
                                    .navigationBarBackButtonHidden()
                            }
                        } label: {
                            Text("Redeem")
                        }
                        .buttonStyle(RoundButton())
                        .simultaneousGesture(TapGesture().onEnded{
                            viewModel.dateOfBirth = date
                            if let userProfile = viewModel.toUserProfileModel() {
                                userProfile.saveUserProfile()
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
    }
}

struct UserProfileInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileInputView(
            viewModel: UserProfileInputViewModel(),
            rewardModel: RewardModel(
                id: 1,
                points: 5,
                totalPoints: 6,
                storeName: "Taperk's Kitchen",
                rewardDescription: "Free Normal Size Spaghetti"
            ),
            urlModel: InvocationURLModel()
        )
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
