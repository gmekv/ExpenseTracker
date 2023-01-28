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
typealias TransactionPrefixSum = [(String, Double)]


final class TransactionListViewModel: ObservableObject {

    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable> ()
    
    init() {
        getTransactions()
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
    func groupTransactionsBymonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        let sortedTransactions = transactions.sorted { $0.dateParsed < $1.dateParsed }
        let groupedTranasctions =  TransactionGroup(grouping: sortedTransactions) { "\($0.dateParsed.formatted(.dateTime.year()))-\($0.month)" }
        return groupedTranasctions
    }

    
    
    
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
    
    

