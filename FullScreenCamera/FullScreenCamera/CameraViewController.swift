//
//  ViewController.swift
//  FullScreenCamera
//
//  Created by joonwon lee on 28/04/2019.
//  Copyright © 2019 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class CameraViewController: UIViewController {
    // TODO: 초기 설정 1
    // - captureSession
    // - AVCaptureDeviceInput
    // - AVCapturePhotoOutput
    // - Queue
    // - AVCaptureDevice DiscoverySession
    
    let captureSession = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!     // 전,후면 스위치할거라 var
    let photoOutput = AVCapturePhotoOutput()
    
    let sessionQueue = DispatchQueue(label: "session Queue")
    let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInWideAngleCamera, .builtInTrueDepthCamera], mediaType: .video, position: .back)

    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var blurBGView: UIVisualEffectView!
    @IBOutlet weak var switchButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: 초기 설정 2
        previewView.session = captureSession
        sessionQueue.async {
            self.setupSession()
            self.startSession()
        }
        setupUI()
    }
    
    func setupUI() {
        photoLibraryButton.layer.cornerRadius = 10
        photoLibraryButton.layer.masksToBounds = true
        photoLibraryButton.layer.borderColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        photoLibraryButton.layer.borderWidth = 1
        
        captureButton.layer.cornerRadius = captureButton.bounds.height/2
        captureButton.layer.masksToBounds = true
        
        blurBGView.layer.cornerRadius = blurBGView.bounds.height/2
        blurBGView.layer.masksToBounds = true

    }
    
    
    @IBAction func switchCamera(sender: Any) {
        // TODO: 카메라는 1개 이상이어야함
        
        
        // TODO: 반대 카메라 찾아서 재설정
        
    }
    
    func updateSwitchCameraIcon(position: AVCaptureDevice.Position) {
        // TODO: Update ICON
        
        
    }
    
    @IBAction func capturePhoto(_ sender: UIButton) {
        // TODO: photoOutput의 capturePhoto 메소드


    }
    
    
    func savePhotoLibrary(image: UIImage) {
        // TODO: capture한 이미지 포토라이브러리에 저장
    }
}


extension CameraViewController {
    // MARK: - Setup session and preview
    func setupSession() {
        // TODO: captureSession 구성하기
        // - presetSetting 하기
        // - beginConfiguration
        // - Add Video Input
        // - Add Photo Output
        // - commitConfiguration
        
        captureSession.sessionPreset = .photo       // 해상도 설정
        captureSession.beginConfiguration()
        
        // add video input
        var defaultVideoDevice: AVCaptureDevice?
        guard let camera = videoDeviceDiscoverySession.devices.first else {     // 디바이스 세션에서 기기찾아 가져오기
            captureSession.commitConfiguration()
            return
        }
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: camera)
            
            if captureSession.canAddInput(videoDeviceInput) {       // videoinput 넣어도 되겠니? 물어보기
                captureSession.addInput(videoDeviceInput)
            } else {
                captureSession.commitConfiguration()
                return
            }
            
        } catch let error {
            captureSession.commitConfiguration()
            return
        }
        
        // add photo output
        photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey:
                                                                                    AVVideoCodecType.jpeg])], completionHandler: nil) // 사진 저장 형식 설정
        
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            captureSession.commitConfiguration()
            return
        }
        captureSession.commitConfiguration()
    }
    
    
    
    func startSession() {
        // TODO: session Start
        sessionQueue.async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
        
        

    }
    
    func stopSession() {
        // TODO: session Stop
        sessionQueue.async {
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // TODO: capturePhoto delegate method 구현
        
        
    }
}
