//
//  ViewController.swift
//  AgoraTest
//
//  Created by Aishat Olowoshile on 8/5/20.
//  Copyright © 2020 aishaolowoshile. All rights reserved.
//

import UIKit
import AgoraRtcKit

class ViewController: UIViewController {
    
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var speakerButton: UIButton!
    
    //weak var delegate: VCDelegate?
    var isStartingCall = false
    
    // reference for Agora RTC Engine
    fileprivate var agoraKit: AgoraRtcEngineKit!
    
    var mute = false
    var speakerPhone = false
    
    
//    fileprivate var bundleID: String {
//        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
//    }
    
    fileprivate let appID = "48ebbbb03599496fbed63da5161fe9e7"
    fileprivate let primaryCert = "cc845f36a27849069445fe151e65fe4f"
    fileprivate let channelName = "Houston"
    fileprivate let tempToken = "00648ebbbb03599496fbed63da5161fe9e7IACatvpikRAAxpkljifPcdECR3SS/0x00O/W1mx6SMXlFJnCBUAAAAAAEAACIYWFM103XwEAAQAzXTdf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initializeAgoraEngine()
        joinChannel()
    }

    @IBAction func didClickMuteButton(_ sender: Any) {
        // Stops/Resumes sending the local audio stream.
        self.mute = !mute
        agoraKit.muteLocalAudioStream(mute)
    }
    
    @IBAction func didClickEndButton(_ sender: Any) {
        leaveChannel()
    }
    
    @IBAction func didActivateSpeakerPhone(_ sender: Any) {
        self.speakerPhone = !speakerPhone
        agoraKit.setEnableSpeakerphone(speakerPhone)
    }
    

}

extension ViewController {
    
    //intialize agora kit object
    func initializeAgoraEngine() {
       // Initialize the AgoraRtcEngineKit object.
       agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: appID, delegate: self)
    }
    
    
    func joinChannel() {
        // Join a channel with a token.
        agoraKit.joinChannel(byToken: tempToken, channelId: channelName, info:nil, uid:0) { [unowned self] (channel, uid, elapsed) -> Void in
            self.agoraKit.setEnableSpeakerphone(true)
        }
       // self.logVC?.log(type: .info, content: "did join channel")
    }
    
    func leaveChannel() {
        // Leave the channel.
        agoraKit.leaveChannel(nil)
       // self.logVC?.log(type: .info, content: "did leave channel")
    }
}


extension ViewController: AgoraRtcEngineDelegate {
    
}

