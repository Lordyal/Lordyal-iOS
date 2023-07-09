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
    @ObservedObject var viewModel: UserProfileInputViewModel
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
                        .foregroundColor(.mediumGreen)
                        .padding(.bottom, 40)

                    Group {
                        Text("Gender")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.boldGreen)
                            .frame(maxWidth: .infinity, alignment: .leading)

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
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.boldGreen)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(date, style: .date)
                            .font(.system(size: 20, weight: .semibold))
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
                                showDatePicker = true
                            }
                            .sheet(isPresented: $showDatePicker) {
                                DatePickerView(date: $date)
                            }
                    }

                    Group {
                        Spacer().frame(height: 24)
                        Text("Phone number")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.boldGreen)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ZStack {
                            HStack {
                                HStack {
                                    Text("US")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.boldGreen)
                                        .padding(10)
                                        .background {
                                            RoundedRectangle(cornerRadius: 48)
                                                .stroke(.gray.opacity(0.5), lineWidth: 2)
                                                .foregroundColor(.black.opacity(0.05))
                                        }
                                    Text("+1")
                                        .font(.system(size: 16, weight: .bold))
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
                                    .font(.system(size: 20, weight: .bold))
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
                            // TODO: Handle open later
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.boldGreen)
                                    .font(.system(size: 16, weight: .bold))
                                Spacer().frame(width: 30)
                                Text("Later")
                                    .foregroundColor(.boldGreen)
                                    .font(.system(size: 20, weight: .bold))
                            }
                        }
                        Spacer()
                        NavigationLink {
                            ScanBarCodeView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Text("Redeem")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.horizontal, 32)
                                .padding(.vertical, 12)
                                .background {
                                    RoundedRectangle(cornerRadius: 48)
                                        .foregroundColor(.boldGreen)
                                }
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.horizontal, 36)

            }
        }
    }
}

struct UserProfileInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileInputView(viewModel: UserProfileInputViewModel())
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
