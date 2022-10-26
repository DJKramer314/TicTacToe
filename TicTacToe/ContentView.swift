//
//  ContentView.swift
//  TicTacToe
//
//  Created by Dylan on 9/2/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var game = SinglePlayerTTT()
    
    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        VStack() {
                            let id = row*3 + column
                            BoxView(game, id: id)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer(minLength: GameConstants.spacerLength)
            
            Button(action:{
                game.newGame()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: GameConstants.cornerRadiusOfButton)
                        .foregroundColor(.green)
                    Text("New Game")
                        .foregroundColor(.white)
                        .font(.system(size:50, weight:.black))
                }
                .padding()
            })
        }
        .padding(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
            
            
    }
}


struct BoxView: View {
    
    private var id: Int
    
    @ObservedObject private var game: SinglePlayerTTT
    
    init(_ game: SinglePlayerTTT, id: Int) {
        self.game = game
        self.id = id
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: GameConstants.cornerRadiusOfBoxes)
                .aspectRatio(1/1,contentMode: .fit)
                .foregroundColor(game.model.winner.1.contains(id) ? .red : .blue) //This returns red if the box being drawn is the winner of the round's line, and blue otherwise.
            
            Text(game.model.boxes[id].content)
                .font(.system(size: GameConstants.textSize, weight: .black))
                .foregroundColor(.white)
        }
        .onTapGesture {
            game.choose(box: game.boxes[id])
        }
    }
}

struct GameConstants {
    static let cornerRadiusOfBoxes: CGFloat = 5
    static let cornerRadiusOfButton: CGFloat = 25
    static let textSize: CGFloat = 50
    static let spacerLength: CGFloat = 25
}
