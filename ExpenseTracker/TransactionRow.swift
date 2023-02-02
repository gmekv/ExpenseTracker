//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import SwiftUI
import SwiftUIFontIcon



struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            // Mark: Transaction  Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon)
                }
            VStack(alignment: .leading, spacing: 6) {
                //MARK: Transaction Merchant
                
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                
                //Mark: Transaction Date
                Text(transaction.date)
               
            }
            Spacer()
            // MARK Transaction Amount
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .bold()
                .padding(.trailing)
            
                
        }
        
        .padding([.top, .bottom, .leading], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: transactionPreviewData)
        TransactionRow(transaction: transactionPreviewData)
            .preferredColorScheme(.dark)
    }
}
