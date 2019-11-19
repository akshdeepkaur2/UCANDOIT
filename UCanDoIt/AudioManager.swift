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
    private var player: AVAudioPlayer!
    private var clickPlayer: AVAudioPlayer!
    private var loosePlayer: AVAudioPlayer!
    private var padEnablePlayer: AVAudioPlayer!
    
    private override init() {
        
    }
    
    func startInitialBackgroundMusic(){
        
        guard let bgMusicURL = Bundle.main.url(forResource: "initialBG", withExtension: ".wav") else {
            print("File Not Exist")
            return
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.player = try AVAudioPlayer(contentsOf: bgMusicURL)
            self.player.numberOfLoops = -1
            self.player.play()
            
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func gameOverMusic(){
        self.startGamePadMusic("game_over", isWav: true)
    }
    
    func startGamePadMusic(_ padName: String, isWav: Bool = false){
        
        if isWav {
            guard let bgMusicURL = Bundle.main.url(forResource: padName, withExtension: ".wav") else {
                print("File Not Exist")
                return
            }
            
            do{
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                self.player = try AVAudioPlayer(contentsOf: bgMusicURL)
                self.player.numberOfLoops = -1
                self.player.play()
                
            }catch let error{
                print(error.localizedDescription)
            }
        }else{
            guard let bgMusicURL = Bundle.main.url(forResource: padName, withExtension: ".mp3") else {
                print("File Not Exist")
                return
            }
            
            do{
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                self.player = try AVAudioPlayer(contentsOf: bgMusicURL)
                self.player.numberOfLoops = -1
                self.player.play()
                
            }catch let error{
                print(error.localizedDescription)
            }
        }
        
    }
    
    func clickMusic(){
        
        guard let clickURL = Bundle.main.url(forResource: "click", withExtension: ".wav") else {
            print("File Not Exist")
            return
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.clickPlayer = try AVAudioPlayer(contentsOf: clickURL)
            self.clickPlayer.play()
            
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func padEnableMusic(){
        
        guard let clickURL = Bundle.main.url(forResource: "open", withExtension: ".mp3") else {
            print("File Not Exist")
            return
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.padEnablePlayer = try AVAudioPlayer(contentsOf: clickURL)
            self.padEnablePlayer.play()
            
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func clickLooseMusic(){
        
        guard let clickURL = Bundle.main.url(forResource: "loose", withExtension: ".wav") else {
            print("File Not Exist")
            return
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.loosePlayer = try AVAudioPlayer(contentsOf: clickURL)
            self.loosePlayer.play()
            
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
}
