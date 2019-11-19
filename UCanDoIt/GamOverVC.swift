//
//  GamOverVC.swift
//  UCanDoIt
//
//  Created by Pardeep on 17/11/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit

//MARK: -
class GamOverVC: UIViewController {
    
    @IBOutlet weak var lblYourScore : UILabel!
    @IBOutlet weak var lblHighScore : UILabel!
    
    var yourScore: Int = 0
    
    //MARK: - UIViewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioManager.shared.gameOverMusic()
        self.updateScoreUI()
    }
    
    //MARK: - Setups
    func updateScoreUI(){
        let highScore = UserDefaults.standard.value(forKey: "User_High_Score") as? Int ?? 0
        self.lblYourScore.text = "Your Score: \(self.yourScore)"
        self.lblHighScore.text = "High Score: \(highScore)"
    }
    
    //MARK: - UIButton Actions
    @IBAction func homeAction(_ sender: UIButton){
        AudioManager.shared.startInitialBackgroundMusic()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
