//
//  PhoneBookViewController.swift
//  Pokemon Telephone Book
//
//  Created by Jimin on 12/10/24.
//

import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
    
    // 이미지
    private let pokemonImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.layer.borderColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        image.layer.borderWidth = 2.0
        return image
    }()
    
    // 버튼
    private let randomimageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    // 이름 입력란
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    // 전번 입력란
    private let numberTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "연락처 추가"
        configureUI()
        
        pokemonImage.layer.cornerRadius = pokemonImage.bounds.width / 2
        pokemonImage.layer.masksToBounds = true
    }
    
    private func configureUI() {
        [pokemonImage, randomimageButton, nameTextView, numberTextView]
            .forEach { view.addSubview($0) }
        
        pokemonImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(view.bounds.width / 3)
        }
        
        randomimageButton.snp.makeConstraints {
            $0.top.equalTo(pokemonImage.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        nameTextView.snp.makeConstraints {
            $0.top.equalTo(randomimageButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        numberTextView.snp.makeConstraints {
            $0.top.equalTo(nameTextView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }
}

