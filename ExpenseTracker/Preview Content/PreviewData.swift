//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import Foundation
import SwiftUI




var transactionPreviewData = Transaction(id: 25, date: "02/16/2022",
                      institution: "Desjardins",
                      account: "Visa Desjardins",
                      merchant: "STM",
                      amount: 6.50,
                      type: "debit",
                      categoryId: 101,
                      category: "Public Transportation",
                      isPending: true,
                      isTransfer: false,
                      isExpense: true,
                      isEdited: false)





var transactionListPreviewData = [Transaction] (repeating: transactionPreviewData, count: 10)
