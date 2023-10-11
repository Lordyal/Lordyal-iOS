//
//  Font+Extension.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/2/23.
//

import SwiftUI

extension Font {
    
    static func Body(size: CGFloat = 16, relativeTo: TextStyle = .body) -> Font {
        Font.custom("OpenSans-Regular", size: size, relativeTo: relativeTo)
    }
    
    static func SemiBold(size: CGFloat = 20, relativeTo: TextStyle = .title3) -> Font {
        Font.custom("OpenSans-SemiBold", size: size, relativeTo: relativeTo)
    }
    
    static func Bold(size: CGFloat = 30, relativeTo: TextStyle = .title3) -> Font {
        Font.custom("OpenSans-Bold", size: size, relativeTo: relativeTo)
    }
    
    static func ExtraBold(size: CGFloat = 48, relativeTo: TextStyle = .title) -> Font {
        Font.custom("OpenSans-ExtraBold", size: size, relativeTo: relativeTo)
    }
    
    static func Title(size: CGFloat = 30, relativeTo: TextStyle = .title) -> Font {
        Font.custom("SFUFuturaBold", size: size, relativeTo: relativeTo)
    }
}
