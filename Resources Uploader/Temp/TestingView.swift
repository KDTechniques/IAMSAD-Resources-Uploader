//
//  TestingView.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-07.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var fileNames: [String]
    @Binding var imagesData: [Data]
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            for result in results {
                if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { (url, error) in
                        if let url = url {
                            DispatchQueue.main.async {
                                self.parent.fileNames.append(url.lastPathComponent)
                            }
                        }
                    }
                    
                    // Load image data
                    result.itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, error in
                        if let data = data {
                            DispatchQueue.main.async {
                                self.parent.imagesData.append(data)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // Allow multiple selections
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}

struct ContentView: View {
    @State private var showPhotoPicker = false
    @State private var fileNames: [String] = []
    @State private var imagesData: [Data] = []
    
    var body: some View {
        VStack {
            Button("Select Photos") {
                showPhotoPicker = true
            }
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPicker(fileNames: $fileNames, imagesData: $imagesData)
            }
            
            List(fileNames, id: \.self) { fileName in
                Text(fileName)
            }
            
            ScrollView {
                ForEach(imagesData, id: \.self) { data in
                    if let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
