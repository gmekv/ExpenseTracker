//
//  NewexpenseView.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 28.01.23.
//

import SwiftUI

struct NewexpenseView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel

    var body: some View {
     

                // Your view layout
                Button(action: {
                    // Create a new transaction
                    let newTransaction = Transaction(
                        id: transactionListVM.transactions.count + 1,
                        date: "2022-03-03",
                        institution: "My Bank",
                        account: "Checking",
                        merchant: "Amazon",
                        amount: 100.0,
                        type: "credit",
                        categoryId: 1,
                        category: "Shopping",
                        isPending: false,
                        isTransfer: false,
                        isExpense: true,
                        isEdited: false
                    )

                    // Append the new transaction to the transactions array
                    transactionListVM.transactions.append(newTransaction)
                    print("added")
                }) {
                    Text("Add Transaction")
                }
            }
        
}

struct NewexpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewexpenseView()
    }
}
