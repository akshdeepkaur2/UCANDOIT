//
//  GameVC.swift
//  UCanDoIt
//
//  Created by Pardeep on 12/11/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit
import Lottie

//MARK: -
class GameVC: UIViewController {
    
    @IBOutlet weak var clvGamePad : UICollectionView!
    @IBOutlet weak var beatAnimationView : AnimationView!
    
    private let gamePadCellIdentifier = "GamePadCVC"
    private let padDefaultColor : UIColor = .systemRed
    private let numerOfPads = 12
    private let padImages : [String] = ["1.json","2.json","3.json","4.json","5.json","6.json","7.json","8.json","9.json","10.json"]
    
    //MARK: - UIViewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCustomCells()
        self.updateCollectionViewLayout()
        self.setupAnimations()
    }
    
    //MARK: - Setups
    func setupAnimations(){
        beatAnimationView.backgroundBehavior = .pauseAndRestore
        beatAnimationView.loopMode = .loop
        beatAnimationView.play()
    }
    func registerCustomCells(){
        self.clvGamePad.register(UINib(nibName: gamePadCellIdentifier, bundle: nil), forCellWithReuseIdentifier: gamePadCellIdentifier)
    }
    
    func updateCollectionViewLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let itemWidth = (ScreenSize.SCREEN_WIDTH - 30) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        clvGamePad!.collectionViewLayout = layout
    }
    
    //MARK: - UIButton Actions
    @IBAction func backAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.navigationController?.popViewController(animated: true)
    }
}

extension GameVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numerOfPads
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gamePadCellIdentifier, for: indexPath) as! GamePadCVC
        cell.shadowView.backgroundColor = padDefaultColor
        
        return cell
    }
    
}
