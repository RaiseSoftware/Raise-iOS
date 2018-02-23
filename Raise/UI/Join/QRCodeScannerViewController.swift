//
//  QRCodeScannerViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/22/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRCodeScannerViewControllerDelegate: class {
    func qrCodeFound(value: String)
}

class QRCodeScannerViewController: UIViewController {

    weak var delegate: QRCodeScannerViewControllerDelegate?

    let captureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()

        let metadataOutput = AVCaptureMetadataOutput()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video), let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice), captureSession.canAddInput(videoInput), captureSession.canAddOutput(metadataOutput) else {
            assertionFailure("Unable to setup video for device")
            return
        }

        captureSession.addInput(videoInput)
        captureSession.addOutput(metadataOutput)

        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]

        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill

        view.layer.insertSublayer(videoPreviewLayer, at: 0)

        captureSession.startRunning()
    }

    @IBAction func closePressed() {
        dismiss(animated: true)
    }
}

extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first,
            let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
            let value = readableObject.stringValue else {
                return
        }

        captureSession.stopRunning()
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        delegate?.qrCodeFound(value: value)

        closePressed()
    }
}
