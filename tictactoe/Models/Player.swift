//
//  Player.swift
//  tictactoe
//
//  Created by Adel Diaz on 21/10/23.
//

import Foundation

class Player: Identifiable {
    
    var mark: String
    var move: [Int]
    var turn: Bool
    var winner: Bool
    
    init(mark: String,  move: Int, turn: Bool, winner: Bool)  {
        self.mark = mark
        self.move = []
        self.turn = turn
        self.winner = winner
    }
}

var PlayerX = Player(mark: "xplayer", move: 0, turn: true, winner: false)
var PlayerO = Player(mark: "oplayer", move: 0, turn: true,  winner: false)


// posible winning moves
var winnings: [[Int]] = [
    // Horizontal rows
    [ 0, 1, 2 ],
    [ 3, 4, 5 ],
    [ 6, 7, 8 ],
    // Diagonals
    [ 0, 4, 8 ],
    [ 2, 4, 6 ],
    // Vertical rows
    [ 0, 3, 6 ],
    [ 1, 4, 7 ],
    [ 2, 5, 8 ],
]

// this array stores the moves/ints of the player
var selectedValues = [Int]()
//track player moves: Player.move
func storeMoves(_ playerMoves: Int) -> [Int]
{

 selectedValues.append(playerMoves)
    
 return selectedValues
}

//check if player won
func didPlayerWin(_ player: Player) -> Bool {
    var doesMoveMatchWinnings = false
    let playerMovesSet = Set(player.move)
    
    if winnings.map { Set($0) }.contains { $0.isSubset(of: playerMovesSet) } {
        doesMoveMatchWinnings = true
        player.winner = true
    }
    
    return doesMoveMatchWinnings
}

//hablde the turns
func toggleTurn(_ player1: inout Player, _ player2: inout Player) -> Bool {
    var isPlayerTurn = false //starts at false
    var swapPlayer: Bool
    
    if player1.turn == true { //player turn is set to true
        isPlayerTurn = true //value is set to true
        player2.turn = false //second value will be set to false
            //swap turn
        swapPlayer = player1.turn //swap value set to true
        player1.turn = player2.turn //2nd value set to false
        player2.turn = swapPlayer // snx  zlud pzxxdx false
        isPlayerTurn = swapPlayer //is player turn set to false
    }
    
return isPlayerTurn
}
