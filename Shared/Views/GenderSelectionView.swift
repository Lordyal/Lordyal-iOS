//
//  GenderSelectionView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 08/06/2023.
//

import SwiftUI

struct GenderSelectionView: View {
    var gender: Gender
    var selected: Bool

    var onTap: () -> Void

    var iconName: String? {
        switch gender {
        case .male:
            return selected ? "male_select" : "male_unselect"
        case .female:
            return selected ? "female_select" : "female_unselect"
        case .other:
            return nil
        }
    }
    
    var body: some View {
        HStack {
            if let iconName = iconName {
                Image(iconName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(contentMode: .fit)
            }
            Text(gender.label)
                .font(.SemiBold())
                .foregroundColor(selected ? .white : .boldGreen)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .foregroundColor(selected ? .mediumGreen : .white)
                .cornerRadius(48)
                .shadow(color: .gray.opacity(0.3), radius: 10)
        }
        .onTapGesture {
            onTap()
        }
    }
}

enum Gender {
    case male
    case female
    case other

    var label: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .other:
            return "Other"
        }
    }
}

struct GenderModel {
    var gender: Gender
    var selected: Bool

    var iconName: String? {
        switch gender {
        case .male:
            return selected ? "male_select" : "male_unselect"
        case .female:
            return selected ? "female_select" : "female_unselect"
        case .other:
            return nil
        }
    }
}

struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView(
            gender: .other, selected: true
        ) {}
    }
}
