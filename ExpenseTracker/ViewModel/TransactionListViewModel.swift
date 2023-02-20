//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction] >


final class TransactionListViewModel: ObservableObject {
    
    //MARK: New Expense Properties
    //    @Published var addNewExpense: Bool = false
    //    @Published var amount: String = ""
    //    @Published var type: ExpenseType = .all
    //    @Published var 
    
    // Mark: Chart date properties
    
    @Published var monthlyrevenue = 0.0
    @Published var monthlyexpense = 0.0

    @Published var currentMonthStartDate: Date = Date()
    
    
 


        //.map { $0.signedAmount }.reduce(0, +)
    
    @Published  var sortedTransactions: [Transaction] = []
    
    @Published var transactions: [Transaction] = [] {
        didSet {
            self.sortedTransactions = self.transactions.sorted {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let date0 = dateFormatter.date(from: $0.date) ?? Date()
                let date1 = dateFormatter.date(from: $1.date) ?? Date()
                return date0 > date1
            }
        }
    }
    
    var currentMonth: Date = Date() {
        didSet {
            currentMonthStartDate = self.currentMonth
        }
    }



    
    private var cancellables = Set<AnyCancellable> ()
    
    init() {
        getTransactions()
        print(sortedTransactions)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
       

        currentMonthStartDate = calendar.date(from: components)!
      
        print(currentMonthDateString())
     
    }
    
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                print(response)
                print(data)
                
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print(data)
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
        
            .decode(type: [Transaction].self, decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
        
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error Catching Transactions", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                    
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
                
            }
            .store(in: &cancellables)
    }
    
    // MARK monthly Transactions count
    func currentMonthDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium // Use .medium instead of .abbreviated
        
        let startDateString = dateFormatter.string(from: currentMonthStartDate)
        let endDateString = dateFormatter.string(from: Date())
        
        return startDateString + " - " + endDateString
    }
   



    func getExpenseTransactionsForCurrentMonth() -> [Transaction] {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        var expenseTransactions: [Transaction] = []

        for transaction in sortedTransactions {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if let transactionDate = dateFormatter.date(from: transaction.date) {
                let transactionMonth = Calendar.current.component(.month, from: transactionDate)
                let transactionYear = Calendar.current.component(.year, from: transactionDate)
                if transactionMonth == currentMonth && transactionYear == currentYear && transaction.isExpense {
                    expenseTransactions.append(transaction)
                } else if transactionMonth < currentMonth || transactionYear < currentYear {
                    break
                }
            }
        }

        return expenseTransactions
    }
    func getIncomeTransactionsForCurrentMonth() -> [Transaction] {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        var incomeTransactions: [Transaction] = []

        for transaction in sortedTransactions {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if let transactionDate = dateFormatter.date(from: transaction.date) {
                let transactionMonth = Calendar.current.component(.month, from: transactionDate)
                let transactionYear = Calendar.current.component(.year, from: transactionDate)
                if transactionMonth == currentMonth && transactionYear == currentYear && !transaction.isExpense {
                    incomeTransactions.append(transaction)
                } else if transactionMonth < currentMonth || transactionYear < currentYear {
                    break
                }
            }
        }

        return incomeTransactions
    }
    func getTotalExpenseForCurrentMonth() -> Double {
        let expenseTransactions = getExpenseTransactionsForCurrentMonth()
        return expenseTransactions.reduce(0.0) { $0 - $1.signedAmount }
    }
    
    //Mark

    func getTotalIncomeForCurrentMonth() -> Double {
        let incomeTransactions = getIncomeTransactionsForCurrentMonth()
        return incomeTransactions.reduce(0.0) { $0 + $1.signedAmount }
    }
    
    // MARK get balance of the currentmonth
    func getDifferenceForCurrentMonth() -> Double {
        let totalIncome = getTotalIncomeForCurrentMonth()
        let totalExpense = getTotalExpenseForCurrentMonth()
        let difference = totalIncome - totalExpense
        return difference
    }

    

    
    
    
    }
    
    

