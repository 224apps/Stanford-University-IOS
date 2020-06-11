//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Abdoulaye Diallo on 5/28/20.
//  Copyright © 2020 Abdoulaye Diallo. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards){ card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)){
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut){
                    self.viewModel.resetGame()
                    
                }
            }, label: { Text("New Game")})
        }
    }
}



struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaing: Double = 0
    private func startBonusTimeAnimation() {
        animatedBonusRemaing = card.bonusTimeRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaing = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp  || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90),
                            endAngle: Angle(degrees: -animatedBonusRemaing * 360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    }else {
                        Pie(startAngle: Angle(degrees: 0-90),
                            endAngle: Angle(degrees: 110-90), clockwise: true)
                    }
                }
                .padding(45)
                .opacity(0.4)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ?  360: 0))
                    .animation( card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            .rotation3DEffect(Angle.degrees(card.isFaceUp ? 0 : 180),
                              axis: (0,1,0))
        }
    }
    
    //MARK: - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}


