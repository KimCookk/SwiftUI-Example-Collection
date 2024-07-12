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
    let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    
    init() {
        publishTestData()
    }
    
    private func publishTestData() {
        let items = ["one", "two", "three"]
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.currentValuePublisher.send(items[i])
            }
        }
    }
}

class CombineViewModel: ObservableObject {
    
    @Published var data: [String] = []
    let dataService = CombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
// 두개의 차이는..?
//        test()
    }
    
    func addSubscribers() {
        dataService.currentValuePublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("ERROR : \(error.localizedDescription)")
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
            }
        }
    }
}

#Preview {
    CombineView()
}
