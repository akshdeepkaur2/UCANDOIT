//
//  GameVC.swift
//  UCanDoIt
//
//  Created by Pardeep on 12/11/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit

//MARK: -
class GameVC: UIViewController {

    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UIButton Actions
    @IBAction func backAction(_ sender: UIButton){
        AudioManager.shared.clickMusic()
        self.navigationController?.popViewController(animated: true)
    }
}
