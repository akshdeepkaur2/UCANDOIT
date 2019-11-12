//
//  ViewController.swift
//  UCanDoIt
//
//  Created by Pardeep on 11/11/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var playAnimationView : AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioManager.shared.startInitialBackgroundMusic()
        
        playAnimationView.backgroundBehavior = .pauseAndRestore
        playAnimationView.loopMode = .loop
        playAnimationView.play()
        
    }
    
    //MARK: - UIButton Actions
    @IBAction func playAction(_ sender: UIButton){
        
        AudioManager.shared.clickMusic()
    }


}

