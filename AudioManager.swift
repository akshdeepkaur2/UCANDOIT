//
//  AudioManager.swift
//  UCanDoIt
//
//  Created by Pardeep on 12/11/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit
import AVFoundation

final class AudioManager: NSObject {

    static let shared = AudioManager()
    var player: AVAudioPlayer!
    var clickPlayer: AVAudioPlayer!
    
    private override init() {
        
    }
    
    func startInitialBackgroundMusic(){
        
        guard let bgMusicURL = Bundle.main.url(forResource: "initialBG", withExtension: ".wav") else {
            print("File Not Exist")
            return
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            self.player = try AVAudioPlayer(contentsOf: bgMusicURL)
            self.player.numberOfLoops = -1
            self.player.play()
            
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func clickMusic(){
        
        guard let clickURL = Bundle.main.url(forResource: "click", withExtension: ".wav") else {
            print("File Not Exist")
            return
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            self.clickPlayer = try AVAudioPlayer(contentsOf: clickURL)
            self.clickPlayer.play()
            
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
}
