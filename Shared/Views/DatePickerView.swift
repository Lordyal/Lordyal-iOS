//
//  DatePickerView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 09/06/2023.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    @Binding var show: Bool
    var body: some View {
        ZStack {
            Color.lightGreen
                .ignoresSafeArea()
            VStack (alignment: .trailing) {
                Button {
                    show.toggle()
                } label: {
                    Text("Done")
                        .font(.SemiBold())
                        .foregroundColor(.mediumGreen)
                        .padding(.trailing, 10)
                }
                
                DatePicker(selection: $date, displayedComponents: [.date]) {
                    Text(date, style: .date)
                }
                .datePickerStyle(GraphicalDatePickerStyle())
                .tint(.boldGreen)
                .colorInvert().colorMultiply(.mediumGreen)
            }
            .padding()
        }
        .frame(height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct DatePickerView_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        DatePickerView(date: .constant(Date()), show: $show)
    }
}
