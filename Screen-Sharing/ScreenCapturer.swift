//
//  ScreenCapturer.swift
//  5.Screen-Sharing
//
//  Created by Rajkiran Talusani on 23/10/2020.
//  Copyright © 2020 tokbox. All rights reserved.
//

import Foundation
import OpenTok
import ReplayKit

class ScreenCapturer: NSObject, OTVideoCapture {
    var videoCaptureConsumer: OTVideoCaptureConsumer?
    var capturing = false
    
    override init() {
        
    }
    
    // MARK: - OTVideoCapture protocol
    func initCapture() {
        let recorder = RPScreenRecorder.shared();
        recorder.isMicrophoneEnabled = false;
            if #available(iOS 11.0, *) {
                recorder.startCapture(handler: { (sample, bufferType, error) in
                    if (bufferType == .video){
                        self.videoCaptureConsumer?.consumeImageBuffer(CMSampleBufferGetImageBuffer(sample)!, orientation: OTVideoOrientation.up, timestamp: CMSampleBufferGetPresentationTimeStamp(sample), metadata: nil)
                    }
                }) { (error) in
                    
                }
            } else {
                // Fallback on earlier versions
            }
        
        
    }
    
    func start() -> Int32 {
        capturing = true
        return 0
    }
    
    func stop() -> Int32 {
        capturing = false
        return 0
    }
    
    func releaseCapture() {
      
    }
    
    func isCaptureStarted() -> Bool {
        return capturing
    }
    
    func captureSettings(_ videoFormat: OTVideoFormat) -> Int32 {
        videoFormat.pixelFormat = .ARGB
        return 0
    }
}
