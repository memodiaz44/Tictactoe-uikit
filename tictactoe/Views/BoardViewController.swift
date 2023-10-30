//
//  BoardViewController.swift
//  tictactoe
//
//  Created by Adel Diaz on 18/10/23.
//

import UIKit

class BoardViewController: UIViewController {

    private let boardGame: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let board = UICollectionView(frame: .zero, collectionViewLayout: layout)
        board.allowsSelection =  true
        board.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "unique")
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    
    var cellStates: [Bool] = []
      
      func configure(withCellStates cellStates: [Bool]) {
          self.cellStates = cellStates
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(boardGame)
        boardGame.backgroundColor = .systemGray2
        
        boardGame.frame = view.bounds
        
        NSLayoutConstraint.activate([
                // Center the table view in the view controller's view
            boardGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   boardGame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
                   // Set the width and height of the collection view
                   boardGame.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
                   boardGame.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            
               ])

        boardGame.delegate = self
        boardGame.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        boardGame.contentOffset.y = (boardGame.contentSize.height - boardGame.bounds.height) / 2
    }
    
    
    
    init() {
           super.init(nibName: nil, bundle: nil)
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}


class CustomCollectionViewCell: UICollectionViewCell {

    var declaredWinner = false
    let actButton = UIButton()
    var moveMade = false
    var isButtonEnabled = true
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
        contentView.addSubview(actButton)

        actButton.translatesAutoresizingMaskIntoConstraints = false
        actButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        actButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        actButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        actButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  
            actButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
    
    }
    
    let playerImageX = UIImage(named: PlayerX.mark)
    let playerImageO = UIImage(named: PlayerO.mark)
    
    
    @objc func buttonClicked()  {
        if PlayerO.winner || PlayerX.winner {
              return
          }
     
        
        if let collectionView = superview as? UICollectionView,
            let indexPath = collectionView.indexPath(for: self) {
            actButton.tag = indexPath.row
            if PlayerX.turn == true {
                actButton.setImage(playerImageX, for: .normal)
                PlayerX.move.append(actButton.tag) // Store the move in PlayerX's moves array
                toggleTurn(&PlayerX, &PlayerO)
            } else {
                actButton.setImage(playerImageO, for: .normal)
                PlayerO.move.append(actButton.tag) // Store the move in PlayerO's moves array
                toggleTurn(&PlayerO, &PlayerX)
            }

            if didPlayerWin(PlayerX) {
                isButtonEnabled = false
                declaredWinner = true
                
                moveMade = true
                print("Player X has won!")
                
            } else if didPlayerWin(PlayerO) {
                isButtonEnabled = false
                declaredWinner = true
                print("Player O has won!")
            }
      

            print("Button Clicked \(actButton.tag), PlayerX moves: \(PlayerX.move), PlayerO moves: \(PlayerO.move)")
        }
        
        
    }
 
    override func prepareForReuse() {
          super.prepareForReuse()
        actButton.removeTarget(self, action: nil, for: .touchUpInside)
        
        
      }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BoardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unique", for: indexPath) as! CustomCollectionViewCell

        cell.actButton.removeTarget(self, action: nil, for: .touchUpInside)

              let chessRow = indexPath.row / 3
              if chessRow % 2 == 0 {
                  if indexPath.row % 2 == 0 {
                       cell.backgroundColor = UIColor.white
                  }else{
                      cell.backgroundColor = UIColor.white
                  }
              } else{
                  if indexPath.row % 2 == 0 {
                      cell.backgroundColor = UIColor.white
                  }else{
                      cell.backgroundColor = UIColor.white
                  }
              }
    
        
        cell.moveMade = false
          
              return cell
          }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Divide the width by 3 to create a 3x3 grid
            let width = collectionView.frame.size.width / 4.0
            let height = width
            return CGSize(width: width, height: height)
        }
    
    
}

