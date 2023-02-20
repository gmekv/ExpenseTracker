//
//  CardView.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 19.02.23.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var transactionListVm: TransactionListViewModel
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [Color.blue, Color.white, Color.background], startPoint: .topLeading, endPoint: .bottom))
                .opacity(0.5)
                .frame(height: 220)
            VStack(spacing:15) {
                Text(transactionListVm.currentMonthDateString())
                    .foregroundColor(.black)
                Text("$\(String(format: "%.2f", transactionListVm.getDifferenceForCurrentMonth()))")
                    .font(.system(size: 28, weight: .bold))

                
                HStack(spacing:75) {
                    HStack {
                        Image(systemName: "arrow.up")
                            .foregroundColor(Color.green)
                        VStack(alignment: .leading, spacing: 4) {
                            
                            
                            Text("Income")
                                .font(.caption)
                                .opacity(0.7)
                       
                    Text("$\(String(format: "%.2f", transactionListVm.getTotalIncomeForCurrentMonth()))")
                        }}
                    HStack{
                        Image(systemName: "arrow.down")
                            .foregroundColor(Color.red)

                        VStack(alignment: .leading, spacing: 4) {
                            
                            
                            Text("Expense")
                                .font(.caption)
                                .opacity(0.7)
                            
                            Text("$\(String(format: "%.2f", transactionListVm.getTotalExpenseForCurrentMonth()))")
                        }}
                    
                    
                }}}}}

struct CardView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.sortedTransactions = transactionListPreviewData
        return transactionListVM } ()
    static var previews: some View {
        CardView()
            .environmentObject(transactionListVM)

    }
}
