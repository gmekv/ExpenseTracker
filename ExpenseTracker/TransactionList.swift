//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 27.01.23.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVm: TransactionListViewModel
    
    var body: some View {
        VStack {
            List {
                // MARK Transaction Groups
                ForEach(Array(transactionListVm.groupTransactionsBymonth()), id: \.key) {
                    month, transactions in
                    Section {
                        // Transaction List
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        // Transaction Month
                        Text(month)
                    }
                    
                    
                }
            }
            .listStyle(.plain)
            }
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM } ()
    static var previews: some View {
        Group {
            NavigationView {
                TransactionList()
                
            }
            
            NavigationView {
                
                TransactionList()
                    .preferredColorScheme(.dark)
            }
            
        }
        .environmentObject(transactionListVM)
    }}
