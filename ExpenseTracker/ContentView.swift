//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
   @State var showsheet = false
    
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK TITLE
                    Text("Overview")
                        .font(.title2)
                    // Mark Chart
                    
                    
                   
                    
                    VStack {
                        RecentTransactionList()
                        
                        Spacer()
                        
                        Button(action: {
                            showsheet.toggle()
                        }) {
                            Text("Add New Transations 💸")
                        }
                        .padding()
                        .background(Color.primary)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
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
        .sheet(isPresented: $showsheet, onDismiss: nil) {
            NewexpenseView()
        }
    }
        
}

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
