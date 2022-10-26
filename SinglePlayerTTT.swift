//
//  SwiftUIView.swift
//  TicTacToe
//
//  Created by Dylan on 9/2/21.
//

import SwiftUI


class SinglePlayerTTT: ObservableObject {
    
    typealias Box = TTTGame.Box
    
    @Published var model: TTTGame
    
    static func createTTTGame() -> TTTGame {
        return TTTGame()
    }
    
    init() {
        self.model = SinglePlayerTTT.createTTTGame()
    }
    
    var boxes: Array<Box> {
        return model.boxes
    }
    
    

    // MARK: Intents

    func choose(box: TTTGame.Box) {
        model.choose(box: box)
    }
    
    func newGame() {
        model = SinglePlayerTTT.createTTTGame()
    }

}
