//
//  TicTacToeGame.swift
//  TicTacToe
//
//  Created by Dylan on 9/2/21.
//

import Foundation

struct TTTGame {
    
    static func checkForWin(_ testedArray: Array<Int>){
        //Check for win here
    }
    
    private(set) var boxes: Array<Box>
    private(set) var turn: String = "X"
    
    var winner: (String?, Array<Int>) {
        
        let winningCombosList: Array<Array<Int>> = [
            [0,1,2],
            [3,4,5],
            [6,7,8],
            [0,3,6],
            [1,4,7],
            [2,5,8],
            [0,4,8],
            [2,4,6]
        ]
        
        let xList = boxes.indices.filter({boxes[$0].content == "X"}) //List of indices occupied by X
        let oList = boxes.indices.filter({boxes[$0].content == "O"}) //List of indices occupied by O
        
        for combo in winningCombosList { //Checks if Player X Wins
            var tempCombo = combo
            for occupiedBox in xList {
                if tempCombo.contains(occupiedBox) {
                    tempCombo.removeAll(where: {$0 == occupiedBox})
                }
                if tempCombo == [] {
                    return ("X", combo)
                }
            }
        }
        for combo in winningCombosList { //Checks if Player O Wins
            var tempCombo = combo
            for occupiedBox in oList {
                if tempCombo.contains(occupiedBox) {
                    tempCombo.removeAll(where: {$0 == occupiedBox})
                }
                if tempCombo == [] {
                    return ("O", combo)
                }
            }
        }
        
        if xList.count + oList.count == 9 { //If no winner, then check if all squares are occupied
            return ("-", [])
        }
        
        return (nil, [])
    }
    
    mutating func choose(box: Box) {
        if let chosenBoxId = boxes.firstIndex(where: {$0.id == box.id}), //If the clicked box is a valid box
           boxes[chosenBoxId].isOccupiedBy == nil, //If the clicked box is unoccupied
           winner.0 == nil{ //If the winner hasn't been chosen
            
            boxes[chosenBoxId].isOccupiedBy = turn // Occupies the box with the player's intent
            
            
            if winner.0 == nil { //If the winner hasn't been chosen
                switch turn { //Switches the player's turn to the other player
                case "X": turn = "O"
                case "O": turn = "X"
                default: turn = ""
                }
            }
            
            //boxes[chosenBoxId].isOccupiedByO = true
        }
    }
    
    init() {
        boxes = []
        for index in 0..<9 {
            boxes.append(Box(id: index))
        }
    }
    
    struct Box: Identifiable {
        var isOccupiedBy: String? = nil
        var color: String = "blue"
        var content: String {
            switch isOccupiedBy {
            case "X": return "X"
            case "O": return "O"
            default: return ""
            }
        }
        let id: Int
    }
}
