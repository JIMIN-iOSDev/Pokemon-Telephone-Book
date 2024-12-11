//
//  TableViewCell.swift
//  Pokemon Telephone Book
//
//  Created by Jimin on 12/9/24.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCell"
    
    // 이미지
    private let pokemonimageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.layer.cornerRadius = 30
        image.layer.borderColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        image.layer.borderWidth = 2.0
        return image
    }()
    
    // 이름
    private let namelabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    // 전번
    private let numberlabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        
        [pokemonimageView, namelabel, numberlabel]
            .forEach { contentView.addSubview($0) }
        
        pokemonimageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(60)
            $0.centerY.equalToSuperview()
        }
        
        namelabel.snp.makeConstraints {
            $0.leading.equalTo(pokemonimageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        numberlabel.snp.makeConstraints {
            $0.leading.equalTo(namelabel.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
