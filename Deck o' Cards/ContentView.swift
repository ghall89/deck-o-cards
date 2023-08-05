import SwiftUI

struct CardView: View {
	@Binding var card: PlayingCard
	
	var body: some View {
		Image(!card.flipped ? card.imgName : "cardBack_red5")
			.resizable()
			.aspectRatio(contentMode: .fit)
			.onTapGesture {
				card.flipped.toggle()
			}
			.rotation3DEffect(.degrees(card.flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
	}
}

struct ContentView: View {
	@AppStorage("cardScale") var scale: Double = 90
	@State var cardDeck: [PlayingCard] = []
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: [
				GridItem(.adaptive(minimum: scale)),
			], content: {
				ForEach($cardDeck) { $card in
					CardView(card: $card)
				}
				.onMove(perform: { indices, newOffset in
					cardDeck.move(fromOffsets: indices, toOffset: newOffset)
				})
				.animation(.easeIn, value: cardDeck)
			})
			.padding()
		}
		.toolbar(content: {
			ToolbarItem {
				Button(action: {
					cardDeck.shuffle()
				}, label: {
					Label("Shuffle", systemImage: "shuffle")
				})
			}
			ToolbarItem(content: {
				Button(action: {
					cardDeck.indices.forEach {
						cardDeck[$0].flipped = false
					}
				}, label: {
					Label("Flip Up", systemImage: "arrow.uturn.up")
				})
			})
			ToolbarItem( content: {
				Button(action: {
					cardDeck.indices.forEach {
						cardDeck[$0].flipped = true
					}
				}, label: {
					Label("Flip Down", systemImage: "arrow.uturn.down")
				})
			})
			ToolbarItem(content: {
				Button(action: {
					cardDeck.indices.forEach {
						cardDeck[$0].flipped.toggle()
					}
				}, label: {
					Label("Flip Toggle", systemImage: "arrow.up.arrow.down")
				})
			})
		})
		
		.onAppear(perform: {
			cardDeck = generateDeck()
		})
	}
}
