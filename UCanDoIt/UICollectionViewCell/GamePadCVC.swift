//
//  GamePadCVC.swift
//  UCanDoIt
//
//  Created by Pardeep on 14/11/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit
import Lottie

class GamePadCVC: UICollectionViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var btnSelectPad: UIButton!
    
    private let padAnimationTag = 2835
    private let padImages : [String] = ["1","2","3","4","5","6","7","8","9","10"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addAnimationView(){
        
        self.removeAnimationView()
        
        let animationName = self.padImages[Helper.shared.getRandomNumber(min: 0, max: (self.padImages.count - 1))]
        
        let animationView = AnimationView(name: animationName)
        animationView.frame = self.shadowView.bounds
        animationView.tag = padAnimationTag
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
        self.shadowView.addSubview(animationView)
        self.shadowView.bringSubviewToFront(self.btnSelectPad)
        
        self.btnSelectPad.isUserInteractionEnabled = true
    }
    
    func removeAnimationView(){
        
        self.btnSelectPad.isUserInteractionEnabled = true
        if let oldAnimationView = self.shadowView.viewWithTag(padAnimationTag){
            oldAnimationView.removeFromSuperview()
        }
    }
    
}
