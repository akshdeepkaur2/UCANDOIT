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
    
    @IBOutlet weak var gameAnimationView : AnimationView!
    
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var lblScore : UILabel!
    @IBOutlet weak var lblLevel : UILabel!
    
    private let gamePadCellIdentifier = "GamePadCVC"
    private let padDefaultColor : UIColor = .systemRed
    private let numerOfPads = 12
    private var currentPadEnableIndex = -1
    
    private var gameTimer : Timer?
    private var gameSeconds : Int = 120//Seconds
    
    private var userScore : Int = 0
    private let scoreIncrementBy = 5
    
    var gameLevel : GameLevels = .Easy
    
    //MARK: - UIViewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopGameTimer()
    }
    
    deinit {
        self.stopGameTimer()
    }
    
    //MARK: - Setups
    func initialSetup(){
        AudioManager.shared.startGamePadMusic(Helper.shared.getPadMusic())
        self.initializeGameTimer()
        self.registerCustomCells()
        self.updateCollectionViewLayout()
        self.setupAnimations()
        self.setupLevel()
    }
    
    func setupLevel(){
        self.lblLevel.text = self.gameLevel == .Hard ? "HARD" : self.gameLevel == .Medium ? "MEDIUM" : self.gameLevel == .Easy ? "EASY" : "EASY"
    }
    
    func setupAnimations(){
        gameAnimationView.backgroundBehavior = .pauseAndRestore
        gameAnimationView.loopMode = .loop
        gameAnimationView.play()
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
    
    func initializeGameTimer(){
        
        self.stopGameTimer()
        gameTimer = Timer(timeInterval: 1, repeats: true, block: { [weak self] (timerObj) in
            
            self?.gameSeconds -= 1
            
            let gameFormattedTime = Helper.shared.formatSecondsToTime(self?.gameSeconds ?? 0)
            self?.lblTime.text = gameFormattedTime
            
            //Enable Animation After every 5 seconds
            if (self?.gameSeconds ?? 0) % (self?.gameLevel == .Hard ? 3 : self?.gameLevel == .Medium ? 4 : self?.gameLevel == .Easy ? 5 : 5) == 0{
                self?.enableRandomPad()
            }
            
            
            //Game Over
            if self?.gameSeconds ?? 0 <= 0{
                self?.stopGameTimer()
                self?.gameOver()
            }
        })
        
        RunLoop.current.add(self.gameTimer!, forMode: .common)
    }
    
    func stopGameTimer(){
        if self.gameTimer != nil{
            self.gameTimer?.invalidate()
            self.gameTimer = nil
        }
    }
    
    func gameOver(){
        
        let highScore = UserDefaults.standard.value(forKey: "User_High_Score") as? Int ?? 0
        if self.userScore > highScore{
            UserDefaults.standard.setValue(self.userScore, forKey: "User_High_Score")
        }
        
        let gameOver = self.storyboard?.instantiateViewController(withIdentifier: "GamOverVC") as! GamOverVC
        gameOver.yourScore = self.userScore
        self.navigationController?.pushViewController(gameOver, animated: true)
        
    }
    
    //MARK: - UIButton Actions
    @IBAction func backAction(_ sender: UIButton){
        
        AudioManager.shared.clickMusic()
        self.stopGameTimer()
        
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to go back. You will loose your scores.", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            AudioManager.shared.startInitialBackgroundMusic()
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.initializeGameTimer()
        }
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @objc @IBAction func padAction(_ sender: UIButton){
        if self.currentPadEnableIndex == -1{
            AudioManager.shared.clickLooseMusic()
        }else if self.currentPadEnableIndex == sender.tag{
            //Change Game Music
            sender.isUserInteractionEnabled = false
            AudioManager.shared.startGamePadMusic(Helper.shared.getPadMusic())
            
            //Increase User Score
            self.userScore += self.scoreIncrementBy
            self.lblScore.text = "Score: \(self.userScore)"
        }else{
            AudioManager.shared.clickLooseMusic()
        }
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
        cell.btnSelectPad.tag = indexPath.row
        cell.btnSelectPad.addTarget(self, action: #selector(self.padAction(_:)), for: .touchUpInside)
        
        return cell
    }
}


//MARK: - Random Actions
extension GameVC{
    
    func getPadCell(_ index: Int) -> GamePadCVC?{
        return self.clvGamePad.cellForItem(at: IndexPath(row: index, section: 0)) as? GamePadCVC
    }
    
    func enableRandomPad(){
        
        if let oldCell = self.getPadCell(self.currentPadEnableIndex){
            oldCell.removeAnimationView()
        }
        
        self.currentPadEnableIndex = Helper.shared.getRandomNumber(min: 0, max: (self.numerOfPads - 1))
        
        if let newCell = self.getPadCell(self.currentPadEnableIndex){
            newCell.addAnimationView()
        }
        
        let disableTimer = Timer(timeInterval:  self.gameLevel == .Hard ? 0.6 : self.gameLevel == .Medium ? 1.0 : self.gameLevel == .Easy ? 2.0 : 3.0, repeats: false) { (timerObj) in
            self.disableRandomPad()
        }
        
        RunLoop.current.add(disableTimer, forMode: .common)
        
        AudioManager.shared.padEnableMusic()
    }
    
    func disableRandomPad(){
        
        if let oldCell = self.getPadCell(self.currentPadEnableIndex){
            oldCell.removeAnimationView()
        }
        
        self.currentPadEnableIndex = -1
    }
}
