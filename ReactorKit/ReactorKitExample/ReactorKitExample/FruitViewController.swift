//
//  FruitViewController.swift
//  ReactorKitExample
//
//  Created by 박희지 on 4/15/24.
//

import UIKit
import SnapKit
import Then
import ReactorKit
import RxCocoa

final class FruitViewController: UIViewController, View {
    
    // MARK: - Properties
    private lazy var appleButton = UIButton(type: .system).then {
        $0.setTitle("사과", for: .normal)
    }
    
    private lazy var bananaButton = UIButton(type: .system).then {
        $0.setTitle("바나나", for: .normal)
    }
    
    private lazy var grapesButton = UIButton(type: .system).then {
        $0.setTitle("포도", for: .normal)
    }
    
    private lazy var selectedLabel = UILabel()
    
    private lazy var stack = UIStackView(arrangedSubviews: [
        appleButton,
        bananaButton,
        grapesButton,
        selectedLabel
])
        .then {
            $0.axis = .vertical
            $0.spacing = 20
    }
    
    var disposeBag = DisposeBag()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    func configureLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Helpers
    func bind(reactor: FruitReactor) {
        // Input
        appleButton.rx.tap
            .map { FruitReactor.Action.apple }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        bananaButton.rx.tap
            .map { FruitReactor.Action.banana }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        grapesButton.rx.tap
            .map { FruitReactor.Action.grapes }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state
            .map(\.fruitName)
            .distinctUntilChanged()
            .map { $0 }
            .subscribe(with: self) { owner, value in
                owner.selectedLabel.text = value
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isLoading)
            .distinctUntilChanged()
            .map { $0 }
            .subscribe(with: self) { owner, value in
                if value {
                    owner.selectedLabel.text = "로딩중입니다."
                }
            }
            .disposed(by: disposeBag)
    }
}
