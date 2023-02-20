//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 26.01.23.
//

import SwiftUI

struct RecentTransactionListView: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @State var showsheet = false

    var body: some View {
    
            VStack {
                HStack {
                    // Mark Header Title
                    Text("Recent Transactions")
                        .bold()
                    Spacer()
                    
                    //MARK header link
                    NavigationLink {
                        TransactionListView()
                    } label: {
                        HStack(spacing: 4) {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(Color.text)
                    }
                    
                }
                
                
                
                // MARK: Recent Transaction List
                VStack{
                    ForEach(Array(transactionListVM.sortedTransactions.prefix(4).enumerated()), id: \.element) { index,
                        transaction in TransactionRowView(transaction: transaction)
                        
                        Divider()
                            .opacity(index == 4 ? 0 : 1)
                    }
                    
                }
                
                
                
            }
            .padding()
            .background(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: 100, x: 0, y: 5)
        
        }
    }


struct RecentTransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
         
    }()
    static var previews: some View {
        RecentTransactionListView()
            .environmentObject(transactionListVM)

        RecentTransactionListView()
            .preferredColorScheme(.dark)
            .environmentObject(transactionListVM)
    }
}
