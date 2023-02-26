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

    // other

    var tapAction: ((CardCell) -> Void)?

    private(set) var cardData: [CardDataModel]
    private(set) var flipCount = 0

    private var faseUpCard: CardCell?

    // init

    init(theme: Theme, unicCardCount: Int) {
        cardData = []
        currentTheme = theme
        fillCardData(unicCardCount: unicCardCount)

        tapAction = { [weak self] cell in
            guard let self else { return }
            self.flipCount += 1

            if let faseUpCard = self.faseUpCard { // одна карта уже открыта
                if cell == faseUpCard { // тап на открытую карту
                    return
                }

                self.faseUpCard = nil
                self.turnCard(cell)
                self.checkOpenCards(first: faseUpCard, two: cell)
            } else {
                self.faseUpCard = cell
                self.turnCard(cell)
            }
        }
    }

}

// MARK: - private

extension GameLogic {

    private func fillCardData(unicCardCount: Int) {
        guard currentTheme.data.count >= unicCardCount*2 else {
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
            setMachedCard(first)
            setMachedCard(two)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.turnCard(first)
                self?.turnCard(two)
            }
        }
    }

    private func turnCard(_ card:CardCell) {
        card.data.isFaseUp = !card.data.isFaseUp
        card.updateUI()
    }

    private func setMachedCard(_ card:CardCell) {
        card.data.isMatched = true
        card.updateUI()
    }

}

// MARK: - puvlic

extension GameLogic {

    //

}
