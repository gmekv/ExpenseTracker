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
     
        ScrollView {
            VStack {
                
                
                ForEach(transactionListVm.sortedTransactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
                //                ForEach(Array(transactionListVm.sortedTransactions.prefix(100).enumerated()), id: \.element) { index,
                //                    transaction in TransactionRow(transaction: transaction)
                //                }}
            }
        }
        .background(Color.background)
    }}
     
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
