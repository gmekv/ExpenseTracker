//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
