//
//  CardData.swift
//  Concentration
//
//  Created by Виталий Суханов on 26/02/2023.
//

import Foundation

struct CardDataModel {

    private static var identifierCount = 0
    private let identifier: Int

    var isFaseUp: Bool
    var isMatched: Bool
    let value: String

    init(_ value: String) {
        identifier = CardDataModel.identifierCount
        CardDataModel.identifierCount += 1

        self.value = value
        isFaseUp = false
        isMatched = false
    }

}

// MARK: - Hashable
extension CardDataModel: Hashable {

    static func ==(lhs: CardDataModel, ths: CardDataModel) -> Bool {
        return lhs.identifier == ths.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

}
