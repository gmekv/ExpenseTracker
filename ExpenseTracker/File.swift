//
//  File.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 28.01.23.
//

import Foundation


struct newTransaction: Codable, Identifiable, Hashable {
    let id: Int
    let date : Date
    let institution: String
    let account: String
    let merchant: String
    let amount: Double
    let type: String
    let categoryId: Int
    let category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    
    
    
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    
    
    enum TransactionType: String {
        case debit = "debit"
        case credit = "credit"
    }
  
    
}
