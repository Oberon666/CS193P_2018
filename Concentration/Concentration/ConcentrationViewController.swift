//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Виталий Суханов on 26/02/2023.
//

import Foundation
import UIKit

final class ConcentrationViewController: UIViewController {

    private let collectionView: UICollectionView
    private let label: UILabel
    private let game: GameLogic

    // init

    init() {
        let viewLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)

        label = UILabel()
        label.textAlignment = .center

        game = GameLogic(theme: .animal, unicCardCount: 6)

        super.init(nibName: nil, bundle: nil)

        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - private
extension ConcentrationViewController {

    private func setupUI() {
        collectionView.backgroundColor = .clear

        view.backgroundColor = .white
        title = "Concentration game"

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        game.updateUI = { [weak self] in
            guard let self else { return }
            self.label.text = "count: \(self.game.flipCount)"
        }
        label.text = "count: \(game.flipCount)"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16.0),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0)
        ])
    }

}

// MARK: - UICollectionViewDataSource
extension ConcentrationViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cardData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        cell.data = game.cardData[indexPath.row]
        cell.tapAction = game.tapAction
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension ConcentrationViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }

}

// MARK: - UICollectionViewDelegate
extension ConcentrationViewController: UICollectionViewDelegate {

    // TODO:

}
