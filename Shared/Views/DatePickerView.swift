//
//  DatePickerView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 09/06/2023.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    var body: some View {
        ZStack {
            Color.lightGreen
                .ignoresSafeArea()
            VStack {
                DatePicker(selection: $date, displayedComponents: [.date]) {
                    Text(date, style: .date)
                }
                .datePickerStyle(GraphicalDatePickerStyle())
            }
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(date: .constant(Date()))
    }
}
