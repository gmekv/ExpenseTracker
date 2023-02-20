//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import SwiftUI

struct ContentView: View {
    @State var showsheet = false
    
    @EnvironmentObject var transactionListVm: TransactionListViewModel

    
    var body: some View {
        ZStack {
        

            NavigationView {
                ScrollView {
                    VStack {
                        VStack(alignment: .leading, spacing: 10) {
                            // MARK TITLE
                            Text("Overview")
                                .font(.title2)
                            
                            
                            // Mark balance card
                        
                             CardView()
                            
                            VStack {
                                // Mark recent transactions
                                RecentTransactionListView()
                                
                            }
                        }
                        .padding()
                    }
                }
                .background(Color.background).edgesIgnoringSafeArea(.bottom)
                
            }
            //Mark add new transaction
            Button(action: {
                self.showsheet.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 30))
            }
            .padding(.bottom, 100)
            .background(Color.clear)
            .offset(x: 0, y: 425)
        }
        .sheet(isPresented: $showsheet, onDismiss: nil) {
            NewexpenseView()
        }
   
    }}


struct ContentView_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.sortedTransactions = transactionListPreviewData
        return transactionListVM } ()
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
            
        }
        .environmentObject(transactionListVM)
    }
}
