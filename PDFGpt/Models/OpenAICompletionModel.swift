//
//  OpenAICompletionModel.swift
//  PDFGpt
//
//  Created by David Laiymani on 02/05/2023.
//

import Foundation

// MARK: - Prompt
struct CompletionBody: Codable {
    let model: String
    let messages: [Prompt]
    let temperature: Double
}

// MARK: - Message
struct Prompt: Codable {
    let role, content: String
}

// MARK: - Welcome
struct OpenAICompletionModel: Codable {
    let id, object: String
    let created: Int
    let model: String
    let usage: Usage
    let choices: [Choice]
}

// MARK: - Choice
struct Choice: Codable {
    let message: Message
    let finishReason: String
    let index: Int

    enum CodingKeys: String, CodingKey {
        case message
        case finishReason = "finish_reason"
        case index
    }
}

// MARK: - Message
struct Message: Codable {
    let role, content: String
}

// MARK: - Usage
struct Usage: Codable {
    let promptTokens, completionTokens, totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

