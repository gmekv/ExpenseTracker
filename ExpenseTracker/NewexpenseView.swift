//
//  NewexpenseView.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 28.01.23.
//

import SwiftUI

struct NewexpenseView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    @State private var selectedDate = Date()
    @State private var itsexpense = false
    @State private var itsdeposit = false
    
    let minDate = Calendar.current.date(from: DateComponents(year: 2022, month: 1))!
    let maxDate = Date()
    @State private var newamount = 0.0
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            //            VStack {
            //                VStack {
            //
            VStack {
                VStack(spacing: 15) {
                    Text("Add New Income/Expense 💸")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    TextField("Amount", value: $newamount, format: .currency(code: "USD"))
                        .keyboardType(.numberPad)
                        .font(.system(size: 35))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                        .frame(maxWidth: 250)
                        .background{
                            Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 25)
                    
                    //Mark CheckBox
                    Label {
                        HStack(spacing: 10) {
                            ZStack {
                                Image(systemName: itsdeposit == true ? "checkmark" : "")
                                
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.black,lineWidth: 2)
                                    .opacity(0.5)
                                    .frame(width: 20, height: 20)
                                    .onTapGesture {
                                        if itsdeposit == true {
                                            itsdeposit = false
                                        } else {
                                            itsdeposit = true
                                            itsexpense = false
                              
                                            
                                        }
                                    }
                            }
                            Text("Income")

                            ZStack {
                             
                                            Image(systemName: itsexpense == true ? "checkmark" : "")
                                            
                                            RoundedRectangle(cornerRadius: 2)
                                                .stroke(.black,lineWidth: 2)
                                                .opacity(0.5)
                                                .frame(width: 20, height: 20)
                                                .onTapGesture {
                                                    if itsexpense == true {
                                                        itsexpense = false
                                                    } else {
                                                        itsexpense = true
                                                        itsdeposit = false
                                            
                                        }}
                            }
                            Text("Expense")
                        }
                    } icon: {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.title3)
                    }
                    
                    
                    
                    //Mark Custom Labels
                    HStack {
                        Label {
                            DatePicker("Select date", selection: $selectedDate, in: minDate...maxDate, displayedComponents: .date)
                                .padding(.trailing, 75)
                            
                        } icon: {
                            Image(systemName: "calendar")
                                .font(.title3)
                                .foregroundColor(Color.black)
                                .padding(.leading, 75)
                        }
                        
                        
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .frame(width: 275, height: 50)
                    }
                    .padding(.top)
                    
                    
                }
                    
                
                    // Your view layout
                    Button(action: {
                        // Create a new transaction
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        let dateString = dateFormatter.string(from: selectedDate)
                        let newTransaction = Transaction(
                            id: transactionListVM.sortedTransactions.count + 1,
                            date: dateString,
                            institution: "My Bank",
                            account: "Checking",
                            merchant: "Amazon",
                            amount: Double(newamount) ,
                            type: "credit",
                            categoryId: 1,
                            category: "Shopping",
                            isPending: false,
                            isTransfer: false,
                            isExpense: itsexpense,
                            isEdited: false
                        )
                        
                        // Append the new transaction to the transactions array
                        
                        transactionListVM.transactions.append(newTransaction)
                        print("added")
                        print(newTransaction)
                        
                    }) {
                        Text("Add Transaction")}
                
                
            }}}}

struct NewexpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewexpenseView()
    }
}
