//
//  CameraView.swift
//  Imagify
//
//  Created by bca on 10/28/23.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        <#code#>
    }
    
    func makeUIViewController(context: Context) -> CameraVC {
        CameraVC(cameraVCDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: CameraVC, context: Context) {
        <#code#>
    }
    
    final class Coordinator: NSObject, CameraVCDelegate{
        func CapturePicture() {
            print()
        }
    }
}

#Preview {
    CameraView()
}
