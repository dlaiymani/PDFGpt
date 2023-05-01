//
//  OpenAIService.swift
//  PDFGpt
//
//  Created by David Laiymani on 01/05/2023.
//

import Foundation

struct OpenAIService {
    enum OpenAIError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
        case invalidAPIKey
    }
    
    func fetchModels() async throws -> OpenAIModelsReponse {
        
        let openAIURL = URL(string: "https://api.openai.com/v1/models")!
        
        var openAIRequest = URLRequest(url: openAIURL)
        
        openAIRequest.setValue("Bearer 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",
                               forHTTPHeaderField: "Authorization")
        
        openAIRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        //   var sessionConfiguration = URLSessionConfiguration.default
        
        // sessionConfiguration.httpAdditionalHeaders = [
        //    "Authorization": "Bearer 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"
        //]
        
        //let session = URLSession(configuration: sessionConfiguration)
        
        
        let (data, response) = try await URLSession.shared.data(for: openAIRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw OpenAIError.invalidStatusCode
        }
        
        let decodeData = try JSONDecoder().decode(OpenAIModelsReponse.self, from: data)
        
        return decodeData
            
        }
    }
