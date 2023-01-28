//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK TITLE
                    Text("Overview")
                        .font(.title2)
                    // Mark Chart
                    
                    NavigationLink("new") {
                        NewexpenseView()
                    }
                    
                // Mark: Transaction list
                    RecentTransactionList()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK NOtification item
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
                
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
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
