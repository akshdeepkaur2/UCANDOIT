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
    @IBOutlet weak var easyAnimationView : AnimationView!
    @IBOutlet weak var mediumAnimationView : AnimationView!
    @IBOutlet weak var hardAnimationView : AnimationView!
    
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
        
        easyAnimationView.backgroundBehavior = .pauseAndRestore
        easyAnimationView.loopMode = .loop
        easyAnimationView.play()
        
        mediumAnimationView.backgroundBehavior = .pauseAndRestore
        mediumAnimationView.loopMode = .loop
        mediumAnimationView.play()
        
        hardAnimationView.backgroundBehavior = .pauseAndRestore
        hardAnimationView.loopMode = .loop
        hardAnimationView.play()
    }
    
    func startGame(){
        let gameObj = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameVC
        self.navigationController?.pushViewController(gameObj, animated: true)
    }
    
    
    
    //MARK: - UIButton Actions
    
    @IBAction func easyLevelAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.startGame()
    }
    
    @IBAction func mediumLevelAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.startGame()
    }
    
    @IBAction func hardLevelAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.startGame()
    }
    
    @IBAction func backAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.navigationController?.popViewController(animated: true)
    }
}
