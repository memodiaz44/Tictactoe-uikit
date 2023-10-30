//
//  ViewController.swift
//  tictactoe
//
//  Created by Adel Diaz on 18/10/23.
//

import UIKit

class MainViewController: UIViewController {

    let boardView = BoardViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addBoardView()
    }
    
    func addBoardView(){
        addChild(boardView)
        view.addSubview(boardView.view)
        
     
        boardView.didMove(toParent: self)
    }
}

