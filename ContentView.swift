import SwiftUI

struct ContentView: View {
    @StateObject private var game = Game()
    
    var body: some View {
        VStack {
            // Rakip skor ve eli
            Text("Rakip: \(game.opponentScore) Puan")
            HStack {
                ForEach(game.opponentHand.prefix(5)) { card in
                    CardView(card: card, isFaceUp: false)
                }
            }
            
            // Yerdeki kartlar
            HStack {
                ForEach(game.tableCards) { card in
                    CardView(card: card, isFaceUp: true)
                }
            }
            .frame(height: 100)
            
            // Oyuncu eli ve skor
            Text("Sen: \(game.playerScore) Puan")
            ScrollView(.horizontal) {
                HStack {
                    ForEach(game.playerHand) { card in
                        CardView(card: card, isFaceUp: true)
                            .onTapGesture {
                                game.playCard(card: card)
                            }
                    }
                }
            }
            .frame(height: 150)
        }
        .padding()
    }
}

struct CardView: View {
    let card: Card
    let isFaceUp: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(isFaceUp ? Color.white : Color.red)
                .frame(width: 60, height: 90)
                .shadow(radius: 3)
            
            if isFaceUp {
                VStack {
                    Text(card.value)
                        .font(.headline)
                    Text(card.suit)
                        .font(.subheadline)
                }
            }
        }
    }
}
