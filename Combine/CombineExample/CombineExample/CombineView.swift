//
//  CombineView.swift
//  CombineExample
//
//  Created by 김태성 on 7/12/24.
//

// https://www.youtube.com/watch?v=RUZcs0SWqnI

import SwiftUI
import Combine

class CombineDataService {
    
//    @Published var basicPublisher: String = "first publish"
//    let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishTestData()
    }
    
    private func publishTestData() {
        let items: [Int] = Array(0..<11)
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.passThroughPublisher.send(items[i])
                
                if i == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
    }
}

class CombineViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var error: String = ""
    let dataService = CombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
// 두개의 차이는..?
//        test()
    }
    
    func addSubscribers() {
        dataService.passThroughPublisher
        
            // Sequence Operations
            //            .first(where: { item in
            //                return item > 4
            //            })
//            .tryFirst(where: { item in
//                if item == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                
//                return item > 1
//            })
            .last(where: {
                $0 > 4
            })
            .map({String($0)})
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                    //print("ERROR : \(error.localizedDescription)")
                    break
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)
    }
    
    func test() {
        let items = ["one", "two", "three"]
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.data.append(items[i])
            }
        }
    }
    
}

struct CombineView: View {
    
    @StateObject private var viewModel = CombineViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.data, id: \.self) {
                    Text($0)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                if !viewModel.error.isEmpty {
                    Text(viewModel.error)
                }
            }
        }
    }
}

#Preview {
    CombineView()
}
