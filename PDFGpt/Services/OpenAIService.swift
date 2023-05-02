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
    
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "OpenAI-info", ofType: "plist") else {
          fatalError("Couldn't find file 'OpenAI-info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
        }
          print(value)
        return value
      }
    }
    
    
    func fetchModels() async throws -> OpenAIModelsReponse {
        
        let openAIURL = URL(string: "https://api.openai.com/v1/models")!
        
        var openAIRequest = URLRequest(url: openAIURL)
        
        openAIRequest.setValue("Bearer \(apiKey)",
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


func fetchCompletion(text: String) async throws -> OpenAICompletionModel {
    
    let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    var openAIRequest = URLRequest(url: openAIURL)
    
    openAIRequest.httpMethod = "POST"
    
    openAIRequest.setValue("Bearer \(apiKey)",
                           forHTTPHeaderField: "Authorization")
    
    openAIRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    let completionBody = CompletionBody(model: "gpt-3.5-turbo",
                                        messages: [Prompt(role: "user", content: text)],
                                        temperature:  0.7)
    
    let jsonData = try JSONEncoder().encode(completionBody)
    openAIRequest.httpBody = jsonData
    
    
    //   var sessionConfiguration = URLSessionConfiguration.default
    
    // sessionConfiguration.httpAdditionalHeaders = [
    //    "Authorization": "Bearer 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"
    //]
    
    //let session = URLSession(configuration: sessionConfiguration)
    
    
    let (data, response) = try await URLSession.shared.data(for: openAIRequest)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw OpenAIError.invalidStatusCode
    }
    
    let decodeData = try JSONDecoder().decode(OpenAICompletionModel.self, from: data)
    
    return decodeData
        
    }
}
