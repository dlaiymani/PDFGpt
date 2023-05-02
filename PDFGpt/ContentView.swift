//
//  ContentView.swift
//  PDFGpt
//
//  Created by David Laiymani on 01/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = OpenAIViewModel(service: OpenAIService())
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .success(let models):
                ForEach(models.data, id: \.self) {model in
                    Text("\(model.id)")
                }
                
            case .successForCompletion(let completion):
                Text(completion.choices[0].message.content)
            case .loading:
                ProgressView()
                
            default:
                EmptyView()
            }
        }
        .padding()
        .task {
           // await viewModel.getModels()
            await viewModel.getCompletion(text: "Write a tagline for an ice cream shop.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
