//
//  ViewController.swift
//  LiveDemo
//
//  Created by leo on 16/10/10.
//  Copyright © 2016年 io.ltebean. All rights reserved.
//

import UIKit
import LFLiveKit

class ViewController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    
    lazy var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: .medium3)
        
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)!
        session.delegate = self
        session.captureDevicePosition = .back
        session.preView = self.previewView
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        session.captureDevicePosition = .front

        session.running = true
        let stream = LFLiveStreamInfo()
        stream.url = "rtmp://rtmp.shoppie.tv/live/test";
        session.startLive(stream)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        session.running = false
        session.stopLive()
    }


}

extension ViewController: LFLiveSessionDelegate {
    
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        print("state changed: \(state.rawValue)")
    }
    
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print("error: \(errorCode)")

    }

}

