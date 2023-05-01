//
//  OpenAIModels.swift
//  PDFGpt
//
//  Created by David Laiymani on 01/05/2023.
//

import Foundation

struct OpenAIModel: Codable, Hashable {
    
    var id: String
    var created: Int
    var root: String
    
}

struct OpenAIModelsReponse: Decodable {
    var data: [OpenAIModel]
}
