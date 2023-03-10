//
//  GameLogic.swift
//  Concentration
//
//  Created by Виталий Суханов on 26/02/2023.
//

import Foundation

final class GameLogic {

    // theme
    enum Theme {
        case sport
        case animal
        case fases

        var data: [String] {
            switch self {
            case .sport:
                return ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "⛷", "🎳", "⛳️"]
            case .animal:
                return ["🐶", "🦆", "🐹", "🐸", "🐘", "🦍", "🐓", "🐩", "🐦", "🦋", "🐙", "🐏"]
            case .fases:
                return ["😀", "😌", "😎", "🤓", "😠", "😤", "😭", "😰", "😱", "😳", "😜", "😇"]
            }
        }
    }

    private let currentTheme: Theme

    // properties

    var tapAction: ((CardCell) -> Void)?
    var updateUI: (() -> Void)?

    private(set) var cardData: [CardDataModel]
    private(set) var flipCount = 0

    private var faseUpCard: CardCell?

    // init

    init(theme: Theme, unicCardCount: Int) {
        cardData = []
        currentTheme = theme
        fillCardData(unicCardCount: unicCardCount)

        tapAction = { [weak self] cell in
            guard let self, !cell.data.isFaseUp else { return }

            self.flipCount += 1

            if let faseUpCard = self.faseUpCard {
                cell.turnCard()
                self.checkOpenCards(first: faseUpCard, two: cell)
                self.faseUpCard = nil
            } else {
                self.faseUpCard = cell
                cell.turnCard()
            }
            self.updateUI?()
        }
    }

}

// MARK: - private
extension GameLogic {

    private func fillCardData(unicCardCount: Int) {
        guard currentTheme.data.count >= unicCardCount else {
            assertionFailure()
            return
        }

        var data = currentTheme.data
        for _ in 1...unicCardCount {
            let position = Int.random(in: 0..<data.count)
            let symbol = data.remove(at: position)
            cardData.append(CardDataModel(symbol))
            cardData.append(CardDataModel(symbol))
        }
        cardData.shuffle()
    }

    private func checkOpenCards(first: CardCell, two: CardCell) {
        if first.data.value == two.data.value {
            first.setMached()
            two.setMached()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                first.turnCard()
                two.turnCard()
            }
        }
    }

}
