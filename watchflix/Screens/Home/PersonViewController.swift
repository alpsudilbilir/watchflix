//
//  PersonViewController.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 15.10.2022.
//

import UIKit
import SDWebImage
import SnapKit

class PersonViewController: UIViewController {
    
    private let personImageView  = WFImageView(cornerRadius: 90, border: true, contentMode: .scaleAspectFill)
    private let personTitleLabel = WFTitleLabel()
    private let bioTitleLabel    = WFTitleLabel()
    private let bioTextView      = {
        let textView             = UITextView()
        textView.font            = .systemFont(ofSize: 16, weight: .regular)
        textView.backgroundColor = .secondarySystemBackground
        textView.textColor       = .label
        textView.isEditable      = false
        
        return textView
    }()
    
    let personID: Int
    
    init(personID: Int) {
        self.personID = personID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupViews()
        layoutUI()
        fetchPerson()
    }
    
    private func configureViewController() {
        title = "Person"
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupViews() {
        view.addSubview(personImageView)
        view.addSubview(personTitleLabel)
        view.addSubview(bioTitleLabel)
        view.addSubview(bioTextView)
    }
    
    private func layoutUI() {
        personImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(180)
        }
        personTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(personImageView.snp.bottom).offset(5)
        }
        bioTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(personTitleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(5)
        }
        bioTextView.snp.makeConstraints { make in
            make.top.equalTo(bioTitleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
        }
    }
    
    private func fetchPerson() {
        MovieService.shared.requestPerson(with: personID, for: nil, type: Person.self) { [weak self] result in
            switch result {
            case .success(let person):
                DispatchQueue.main.async {
                    self?.personTitleLabel.text = person.name
                    self?.bioTitleLabel.text    = "Biography"
                    self?.bioTextView.text      = person.biography
                    self?.personImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + (person.profile_path)))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
