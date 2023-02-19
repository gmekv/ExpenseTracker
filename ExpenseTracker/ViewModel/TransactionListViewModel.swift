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
    
    var startDate: Date = Date()
     var endDate: Date = Date()
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
       
        self.startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: startDate))!

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

    func getTotalForCurrentMonth() -> Double {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        var totalAmount = 0.0

        for transaction in sortedTransactions {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if let transactionDate = dateFormatter.date(from: transaction.date) {
                let transactionMonth = Calendar.current.component(.month, from: transactionDate)
                let transactionYear = Calendar.current.component(.year, from: transactionDate)
                if transactionMonth == currentMonth && transactionYear == currentYear {
                    totalAmount += transaction.signedAmount
                } else if transactionMonth < currentMonth || transactionYear < currentYear {
                    break
                }
            }
        }

        return totalAmount
    }

//    func groupTransactionsBymonth() -> TransactionGroup {
//        guard !transactions.isEmpty else { return [:] }
//        let sortedTransactions = transactions.sorted { $0.dateParsed < $1.dateParsed }
//        let groupedTranasctions =  TransactionGroup(grouping: sortedTransactions) { "\($0.dateParsed.formatted(.dateTime.year()))-\($0.month)" }
//        return groupedTranasctions
//    }
    
//    func totalAmountInCurrentMonth() -> Decimal {
//        let currentMonth = Date().formatted(.dateTime.month())
//        let groupedTransactions = groupTransactionsBymonth()
//        let currentMonthTransactions = groupedTransactions[currentMonth] ?? []
//        let totalAmount = currentMonthTransactions.reduce(0) { $0 + $1.amount }
//        return Decimal(totalAmount)
//    }
//    func monthlybalance(sortedTransactions: [Transaction]) -> String {
//        let currentMonth = Calendar.current.component(.month, from: Date())
//        let transactionsInCurrentMonth = sortedTransactions.filter { Calendar.current.component(.month, from: $0.date) == currentMonth }
//        
//        var value: Double = 0
//        value = transactionsInCurrentMonth.reduce(0, { (partialResult, expense) -> Double in
//            return partialResult + (expense.isExpense == true ? -expense.amount : expense.amount)
//        })
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        return formatter.string(from: .init(value: value)) ?? "$0.00"
//    }


//    var totalAmount: Double {
//            return transactionsInCurrentMonth().reduce(0) { $0 + $1.signedAmount }
//        }
//    func transactionsInCurrentMonth() -> [Transaction] {
//           let currentMonthEndDate = Date()
//           return sortedTransactions.filter { transaction -> Bool in
//               let transactionDate = transaction.dateAsDate
//               return transactionDate >= currentMonthStartDate && transactionDate <= currentMonthEndDate
//           }
//       }
//    func accumulateTransactions() -> TransactionPrefixSum {
//        
//        print("accumateTran")
//        
//        guard !transactions.isEmpty else { return [] }
//        
//        
//        let today = "01/28/2022".dateParse()
//        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
//        print("dateInterval", dateInterval)
//        var sum: Double = .zero
//        var cumulativeSum = TransactionPrefixSum()
//        
//        
//    }
    
    
    
    }
    
    

