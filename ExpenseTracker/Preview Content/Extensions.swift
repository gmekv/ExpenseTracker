//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import Foundation
import SwiftUI

extension Color {
static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}



extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    } ()
}

extension String {
    func dateParse() -> Date { guard  let parsedDate = DateFormatter.allNumericUSA.date(from: self)
        else { return Date()}
        return parsedDate
    }
}
