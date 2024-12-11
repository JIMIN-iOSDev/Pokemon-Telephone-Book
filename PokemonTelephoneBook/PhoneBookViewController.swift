//
//  PhoneBookViewController.swift
//  Pokemon Telephone Book
//
//  Created by Jimin on 12/10/24.
//

import UIKit
import SnapKit
import Alamofire

class PhoneBookViewController: UIViewController {
    
    private var phoneNumberData = PhoneNumberData()
    
    // 이미지뷰
    private let pokemonImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.layer.borderColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        image.layer.borderWidth = 2.0
        return image
    }()
    
    // 이미지 생성 버튼
    private lazy var randomimageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(fetchRandomPokemonImage), for: .touchUpInside)
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
    
    // 전화번호 입력란
    private let numberTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    // 적용 버튼
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(buttonTapped))
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = self.rightButton
        
        phoneNumberData.loadContacts()
        configureUI()
        
        pokemonImage.layer.cornerRadius = (view.bounds.width / 2) / 2
        pokemonImage.layer.masksToBounds = true
    }
    
    // 랜덤 포켓몬 이미지 가져오기
    @objc func fetchRandomPokemonImage() {
        let randomID: Int = .random(in: 1...1000)
        let url = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        
        AF.request(url).responseDecodable(of: Pokemon.self) { response in
            switch response.result {
            case .success(let Pokemon):
                if let imageURL = Pokemon.sprites.frontDefault {
                    self.fetchImage(from: imageURL)
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func fetchImage(from url: String) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.pokemonImage.image = image
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
    
    struct Pokemon: Codable {
        let sprites: Sprites
    }
    
    struct Sprites: Codable {
        let frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    // 적용 버튼 눌렀을 때
    @objc private func buttonTapped() {
        guard let name = nameTextView.text, !name.isEmpty,
              let phoneNumber = numberTextView.text, !phoneNumber.isEmpty else { return }
        
        let profileImageData = pokemonImage.image?.jpegData(compressionQuality: 0.8)
        let newContact = PhoneBook(profileImage: profileImageData, name: name, phoneNumber: phoneNumber)
        
        phoneNumberData.addContact(newContact)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    private func configureUI() {
        [pokemonImage, randomimageButton, nameTextView, numberTextView]
            .forEach { view.addSubview($0) }
        
        pokemonImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(130)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(view.bounds.width / 2)
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

