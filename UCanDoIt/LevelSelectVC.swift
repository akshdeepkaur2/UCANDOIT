//
//  LevelSelectVC.swift
//  UCanDoIt
//
//  Created by Pardeep on 12/11/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit
import Lottie

//MARK: -
class LevelSelectVC: UIViewController {
    
    @IBOutlet weak var ladyAnimationView : AnimationView!
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAnimations()
    }
    
    //MARK: - Setups
    func setupAnimations(){
        ladyAnimationView.backgroundBehavior = .pauseAndRestore
        ladyAnimationView.loopMode = .loop
        ladyAnimationView.play()
    }
    
    func startGame(_ level: GameLevels){
        let gameObj = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameVC
        gameObj.gameLevel = level
        self.navigationController?.pushViewController(gameObj, animated: true)
    }
    
    
    
    //MARK: - UIButton Actions
    
    @IBAction func easyLevelAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.startGame(.Easy)
    }
    
    @IBAction func mediumLevelAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.startGame(.Medium)
    }
    
    @IBAction func hardLevelAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.startGame(.Hard)
    }
    
    @IBAction func backAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.navigationController?.popViewController(animated: true)
    }
}
