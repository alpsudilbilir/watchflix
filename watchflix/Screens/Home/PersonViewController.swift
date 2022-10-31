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
    private let personBioLabel   = WFLabel(fontSize: 16, weight: .light, textAlignment: .natural)
    private let scrollView = UIScrollView()
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
        title = "Person"
        view.backgroundColor = .secondarySystemBackground
        setupViews()
        constraintViews()
        fetchPerson()
    }
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(personImageView)
        scrollView.addSubview(personTitleLabel)
        scrollView.addSubview(bioTitleLabel)
        scrollView.addSubview(personBioLabel)
    }
    private func constraintViews() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
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
        personBioLabel.snp.makeConstraints { make in
            make.top.equalTo(bioTitleLabel.snp.bottom).offset(5)
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
                    self?.bioTitleLabel.text = "Biography"
                    self?.personImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + (person.profile_path ?? "-")))
                    self?.personBioLabel.text = person.biography
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
