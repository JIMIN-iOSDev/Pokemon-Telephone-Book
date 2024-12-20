//
//  ViewController.swift
//  Pokemon Telephone Book
//
//  Created by Jimin on 12/9/24.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {

    private let phoneNumberData = PhoneNumberData()
    
    // 제목
    private let listLabel: UILabel = {
        let label = UILabel()
        label.text = "친구목록"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    // 추가버튼
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(navigateToSecondScreen), for: .touchUpInside)
        return button
    }()
    
    // 전화번호부 리스트
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        phoneNumberData.loadContacts()
        tableView.reloadData()
    }

    // 네비게이션 연결
    @objc func navigateToSecondScreen() {
        let seconVC = PhoneBookViewController()
        navigationController?.pushViewController(seconVC, animated: true)
    }
    
    // 첫 화면 구성요소 위치
    private func configureUI() {
        view.backgroundColor = .white
        
        [listLabel, addButton, tableView]
            .forEach { view.addSubview($0) }
        
        listLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(90)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(listLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as? TableViewCell else { return UITableViewCell() }
        cell.configureCell(phoneBook: phoneNumberData.contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phoneNumberData.contacts.count
    }
}
