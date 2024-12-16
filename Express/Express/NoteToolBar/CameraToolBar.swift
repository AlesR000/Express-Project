//
//  CameraToolBar.swift
//  Express
//
//  Created by Alessandro Rippa on 12/12/24.
//

import SwiftUI
import AVFoundation

struct CameraToolBar: View {
    
    @Binding var showCamera: Bool
    
    var body: some View {
        NavigationStack{
            
            ZStack {
                CameraPreview()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    
                    
                }
            }
        }
    }
}

struct CameraPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}


class CameraViewController: UIViewController {
    
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo

        // Usa la fotocamera frontale
        guard let frontalCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Fotocamera frontale non disponibile")
            return
        }
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else{
            print("Fotocamera posteriore non disponibile")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: frontalCamera)
            if let session = captureSession, session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print("Errore configurazione fotocamera: \(error.localizedDescription)")
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.layer.bounds
        if let previewLayer = previewLayer {
            view.layer.addSublayer(previewLayer)
        }

        captureSession?.startRunning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession?.stopRunning()
    }
}

/*
#Preview {
    CameraToolBar()
}
*/
