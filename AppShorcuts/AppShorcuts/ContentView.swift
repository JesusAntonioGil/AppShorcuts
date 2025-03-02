//
//  ContentView.swift
//  AppShorcuts
//
//  Created by Jesus Antonio Gil on 2/3/25.
//

import SwiftUI
import SwiftData
import AppIntents


@Model
class Memory {
    var caption: String
    var date: Date
    @Attribute(.externalStorage) var imageData: Data
    
    init(caption: String, date: Date, imageData: Data) {
        self.caption = caption
        self.date = date
        self.imageData = imageData
    }
    
    var uiImage:UIImage? {
        .init(data: imageData)
    }
}


struct ContentView: View {
    @Query(sort: [.init(\Memory.date, order: .reverse)], animation: .smooth)
    var memories: [Memory]

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memories) { memory in
                    Section(memory.caption) {
                        if let uiImage = memory.uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Memories")
            .overlay {
                if memories.isEmpty {
                    VStack {
                        Text("No memories yet.")
                            .font(.headline)
                        
                        Text("Tap the plus button to add your first memory.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(15)
                }
            }
        }
    }
}



#Preview {
    ContentView()
}



struct AddMemoryIntent: AppIntent {
    static var title: LocalizedStringResource = "Add New Memory"
    
    @Parameter(
        title: .init(stringLiteral: "Choose a Image"),
        description: "Memory to be added",
        supportedContentTypes: [.image],
        inputConnectionBehavior: .connectToPreviousIntentResult
    ) var imageFile: IntentFile
    
    @Parameter(title: "Caption") var caption: String
    
    
    func perform() async throws -> some IntentResult {
        print(caption)
        return .result()
    }
}
