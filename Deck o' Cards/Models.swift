import Foundation

enum Suit: String, CaseIterable {
	case spades = "Spades"
	case hearts = "Hearts"
	case clubs = "Clubs"
	case diamonds = "Diamonds"
}

enum Value: String, CaseIterable {
	case two = "2"
	case three = "3"
	case four = "4"
	case five = "5"
	case six = "6"
	case seven = "7"
	case eight = "8"
	case nine = "9"
	case jack = "J"
	case queen = "Q"
	case king = "K"
	case ace = "A"
}

struct PlayingCard: Identifiable, Equatable {
	
	var id: UUID = UUID()
	var value: Value
	var suit: Suit
	var imgName: String {
		return "card\(suit.rawValue)\(value.rawValue)"
	}
	var flipped: Bool = false
}

func generateDeck() -> [PlayingCard] {
	var deckCards: [PlayingCard] = []
	
	for suit in Suit.allCases {
		for value in Value.allCases {
			deckCards.append(PlayingCard(value: value, suit: suit))
		}
	}
	
	return deckCards
}
