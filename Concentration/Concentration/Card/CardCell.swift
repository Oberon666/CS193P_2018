//
//  CardCell.swift
//  Concentration
//
//  Created by Виталий Суханов on 26/02/2023.
//

import UIKit

final class CardCell: UICollectionViewCell {

    // properties

    static let identifier = "CardCell"

    var data: CardDataModel! {
        didSet { updateUI() }
    }

    var tapAction: ((CardCell) -> Void)?

    private var backImage: UIImageView
    private var value: UILabel

    // init

    override init(frame: CGRect) {
        backImage = UIImageView()
        backImage.image = UIImage(named: "question")
        value = UILabel()

        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - public

extension CardCell {

    func turnCard() {
        guard data != nil else { return }
        data.isFaseUp = !data.isFaseUp
        updateUI()
    }

    func setMached() {
        guard data != nil else { return }
        data.isMatched = true
        updateUI()
    }

}

// MARK: - private
extension CardCell {

    private func setupUI() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapAction))
        contentView.addGestureRecognizer(tapRecognizer)

        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor

        contentView.addSubview(backImage)
        backImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            backImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            backImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            backImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0)
        ])

        value.textAlignment = .center
        value.font = UIFont.systemFont(ofSize: 60)

        contentView.addSubview(value)
        value.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            value.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            value.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            value.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            value.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0)
        ])
        value.isHidden = true
    }

    private func updateUI() {
        guard data != nil else { return }
        value.text = data.value
        self.isHidden = data.isMatched

        backImage.isHidden = data.isFaseUp
        value.isHidden = !data.isFaseUp
    }

    @objc
    private func onTapAction() {
        tapAction?(self)
    }

}
