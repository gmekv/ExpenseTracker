//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 27.01.23.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var transactionListVm: TransactionListViewModel
    
    var body: some View {
        ZStack {
                  Color.background.edgesIgnoringSafeArea(.all)
                  ScrollView {
                      VStack {
                          Text("Transactions 💸")
                              .font(.system(size: 24, weight: .bold))

                          ForEach(transactionListVm.sortedTransactions) { transaction in
                              TransactionRowView(transaction: transaction)
                          }
                      }
                  }
              }
          }
      }
//                .background(Color.background).edgesIgnoringSafeArea

        
        
struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.sortedTransactions = transactionListPreviewData
        return transactionListVM } ()
    static var previews: some View {
        TransactionListView()
            .environmentObject(transactionListVM)

    }
}
