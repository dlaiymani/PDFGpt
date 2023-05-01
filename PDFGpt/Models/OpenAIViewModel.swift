//
//  OpenAIViewModel.swift
//  PDFGpt
//
//  Created by David Laiymani on 01/05/2023.
//

import Foundation

@MainActor
class OpenAIViewModel: ObservableObject {
    
    enum State {
        case notAvailable
        case loading
        case success(data: OpenAIModelsReponse)
       // case successForInfo(data: User)
        case failed(error: Error)
    }
    
    @Published var state: State = .notAvailable
    @Published var hasError: Bool = false
    
    private let service: OpenAIService
    
    init(service: OpenAIService) {
        self.service = service
    }
    
    func getModels() async {
        self.state = .loading
        self.hasError = false
        do {
            let followers = try await service.fetchModels()
            self.state = .success(data: followers)
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
            print(error)
        }
    }
}
