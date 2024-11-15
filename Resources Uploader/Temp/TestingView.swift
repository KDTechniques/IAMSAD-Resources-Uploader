//
//  TestingView.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-07.
//

import SwiftUI

struct ContentView: View {
    @State private var showPhotoPicker = false
    @State private var fileName_ImageDataDictionary: [String : Data] = [:]
    
    private var fileNamesArray: [String] {
        Array(fileName_ImageDataDictionary.keys)
    }
    
    private var dataArray: [Data] {
        Array(fileName_ImageDataDictionary.values)
    }
    
    var body: some View {
        VStack {
            Button("Select Photos") {
                showPhotoPicker = true
            }
            
            List(fileNamesArray, id: \.self) { fileName in
                Text(fileName)
            }
            
            ScrollView {
                ForEach(dataArray, id: \.self) { data in
                    if let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    }
                }
            }
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPickerView(fileName_ImageDataDictionary: $fileName_ImageDataDictionary)
                .ignoresSafeArea()
            
        }
    }
}


#Preview {
    ContentView()
}
