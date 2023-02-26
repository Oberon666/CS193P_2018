//
//  GameLogic.swift
//  Concentration
//
//  Created by Виталий Суханов on 26/02/2023.
//

import Foundation

final class GameLogic {

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

    private(set) var cardData: [CardDataModel]
    private(set) var flipCount = 0

    // init

    init(theme: Theme, unicCardCount: Int) {
        cardData = []
        currentTheme = theme
        fillCardData(unicCardCount: unicCardCount)
    }

}

// MARK: -

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

    func onCardTap() {
        print(">>> onCardTap")
        flipCount += 1
    }

}
