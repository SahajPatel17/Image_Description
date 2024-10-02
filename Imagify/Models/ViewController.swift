import UIKit
import AVFoundation


protocol CameraVCDelegate: AnyObject {
    func CapturePicture()
}
final class CameraVC: UIViewController{
    
    let session = AVCaptureSession()
    var camera : AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var cameraCaptureOutput : AVCapturePhotoOutput?
    weak var cameraDelegate: CameraVCDelegate?
    var image : URL?
    
    init(cameraVCDelegate: CameraVCDelegate){
        super.init(nibName: nil, bundle: nil)
        self.cameraDelegate = cameraVCDelegate
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    private func setupCaptureSession() {
        session.sessionPreset = AVCaptureSession.Preset.high
        camera = AVCaptureDevice.default(for: AVMediaType.video)
        
        
        do {
            let cameraCaptureInput = try AVCaptureDeviceInput(device: camera!)
            cameraCaptureOutput = AVCapturePhotoOutput()
            
            session.addInput(cameraCaptureInput)
            session.addOutput(cameraCaptureOutput!)
        } catch {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.layer.bounds
        
        
        view.layer.addSublayer(previewLayer!)

        
        
        session.startRunning()
    }
    
    
    func CapturePicture(){
        let settings = AVCapturePhotoSettings()
        cameraCaptureOutput!.capturePhoto(with: settings, delegate: self)
        session.stopRunning()
    }
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingLivePhotoToMovieFileAt outputFileURL: URL, duration: CMTime, photoDisplayTime: CMTime, resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        
        cameraDelegate?.CapturePicture()
        image! = outputFileURL
        
    }
    
}
