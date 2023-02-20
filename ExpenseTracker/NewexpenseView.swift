//
//  NewexpenseView.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 28.01.23.
//

import SwiftUI

struct NewexpenseView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var itsexpense = false
    @State private var itsdeposit = false
    
    let minDate = Calendar.current.date(from: DateComponents(year: 2022, month: 1))!
    let maxDate = Date()
    @State private var newamount = 0.0
    @State  var showingChoiceAlert = false
    @State  var showingAmountAlert = false

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 250) {
                VStack(spacing: 50) {
                    addnewexpenseview
                    
                    //Mark CheckBox
                    Label {
                        HStack(spacing: 10) {
                            incomebrack
                            Text("Income")
                            
                            expensebrack
                            Text("Expense")
                        }
                    } icon: {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.title3)
                    }
                    //Mark Custom Labels
                    datebac
                    
                        .padding(.bottom, 100)
                }
                
                

                button
            }
            .alert(isPresented: $showingAmountAlert) {
                Alert(title: Text("Error"), message: Text("Please fill the Income/Expense field"), dismissButton: .default(Text("Ok")))
            }.alert(isPresented: $showingChoiceAlert) {
                Alert(title: Text("Error"), message: Text("Please choose either Income or Expense"), dismissButton: .default(Text("Ok")))
            }
        }
                
                
            }
}
extension NewexpenseView {
    private var addnewexpenseview: some View {
        VStack(spacing: 15) {
            Text("Add New Income/Expense 💸")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            TextField("Amount", value: $newamount, format: .currency(code: "USD"))
                .keyboardType(.numberPad)
                .font(.system(size: 35))
                .foregroundColor(itsexpense ? .red : (itsdeposit ? .green : .black))
                .multilineTextAlignment(.center)
                .frame(minHeight: 60)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                .padding(.vertical, 10)
                .frame(maxWidth: 250)
            
                .padding(.horizontal, 20)
                .padding(.top, 25)
        }}
    
    private var incomebrack: some View {
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
        }}
    private var expensebrack: some View {
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
    }
    private var datebac: some View {
        HStack {
            Label {
                DatePicker("Select date", selection: $selectedDate, in: minDate...maxDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "en_US"))


                    .padding(.trailing, 75)
                
            } icon: {
                Image(systemName: "calendar")
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .padding(.leading, 75)
            }
        }}
    
    private var button: some View {
        // Your view layout
        
        Button(action: {
            if newamount == 0.0 {
                   // Show an alert for missing income/expense choice
                self.showingAmountAlert = true
                

            } else if itsexpense == false && itsdeposit == false {
                self.showingChoiceAlert = true

                   
                   
                   //
               } else {
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
                        amount: Double(newamount),
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

                   
                   // Dismiss the sheet
                                 self.presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Add Transaction")
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
        }
        
                   }
struct NewexpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewexpenseView()
        NewexpenseView()
            .colorScheme(.dark)

    }
}
