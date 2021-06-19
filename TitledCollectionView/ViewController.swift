//
//  ViewController.swift
//  TitledCollectionView
//
//  Created by Kenneth Dubroff on 6/18/21.
//

import UIKit

protocol TitledCollectionViewDelegate: AnyObject {
    func itemWasSelected(_ fruit: Fruit)
    func itemWasSelected(_ vegetable: Vegetable)
}

class TitledCollectionView: UIView {

    var produce: Produce? {
        didSet {
            titleLabel.text = produce?.description
        }
    }
    
    weak var delegate: TitledCollectionViewDelegate?
  
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, collectionView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Layout())
        collectionView.register(ProduceCollectionViewCell.self, forCellWithReuseIdentifier: ProduceCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    /// programmatic init
    init(produce: Produce) {
        super.init(frame: .zero)
        // didSet not available in init
        defer { self.produce = produce }
        self.translatesAutoresizingMaskIntoConstraints = false
        // allow gestures to propagate through views
        isUserInteractionEnabled = true
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = .systemBackground
        addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension TitledCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        produce?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProduceCollectionViewCell.identifier, for: indexPath) as! ProduceCollectionViewCell
        
        switch produce {
        case .fruit:
            cell.viewModel = Fruit.allCases[indexPath.item].viewModel
        case .vegetable:
            cell.viewModel = Vegetable.allCases[indexPath.item].viewModel
        default: // handles optionality
            break
        }
        
        return cell
        
    }
    
}

enum Produce: String {
    case fruit
    case vegetable
    
    var description: String {
        rawValue.capitalized
    }
    
    var count: Int {
        switch self {
        case .fruit:
            return Fruit.allCases.count
        case .vegetable:
            return Vegetable.allCases.count
        }
    }
}

enum Fruit: String, CaseIterable {
    case apple
    case orange
    case dragonFruit
    
    var description: String {
        var name: String = ""
        
        for char in String(describing: rawValue) {
            let strChar = String(char)
            if strChar != strChar.uppercased() {
                name.append(strChar)
            } else {
                // add a space when we come to the camel-cased character
                name.append(" \(strChar)")
            }
        }
        
        return name.capitalized
    }
    
    var viewModel: ProduceViewModel {
        ProduceViewModel(description: description)
    }
}

enum Vegetable: String, CaseIterable {
    case broccoli
    case carrot
    case sweetPeas
    
    var description: String {
        var name: String = ""
        
        for char in String(describing: rawValue) {
            let strChar = String(char)
            if strChar != strChar.uppercased() {
                name.append(strChar)
            } else {
                // add a space when we come to the camel-cased character
                name.append(" \(strChar)")
            }
        }
        
        return name.capitalized
    }
    
    var viewModel: ProduceViewModel {
        ProduceViewModel(description: description)
    }
}

struct ProduceViewModel {
    let description: String
}

class ProduceCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProduceCollectionViewCell"
    
    var viewModel: ProduceViewModel? {
        didSet {
            titleLabel.text = viewModel?.description
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .systemBackground
        setupViews()
    }
    
    private func setupViews() {
        
        if !subviews.contains(titleLabel) {
            addSubview(titleLabel)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -2),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -2),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 2)
        ])
    }
    
}

class TitledCollectionViewController: UIViewController {
    lazy var fruitView = TitledCollectionView(produce: .fruit)
    lazy var vegetableView = TitledCollectionView(produce: .vegetable)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fruitView.delegate = self
        vegetableView.delegate = self
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(fruitView)
        view.addSubview(vegetableView)
        
        NSLayoutConstraint.activate([
            fruitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            fruitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            fruitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            fruitView.heightAnchor.constraint(equalToConstant: TitledCollectionView.Layout.heightConstant),
            
            vegetableView.topAnchor.constraint(equalTo: fruitView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            vegetableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            vegetableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            vegetableView.heightAnchor.constraint(equalToConstant: TitledCollectionView.Layout.heightConstant),
        ])
    }
}

extension TitledCollectionViewController: TitledCollectionViewDelegate {
    
    func itemWasSelected(_ fruit: Fruit) {
        print("Fruit named \(fruit.description) was selected")
    }
    
    func itemWasSelected(_ vegetable: Vegetable) {
        print("Vegetable named \(vegetable.description) was selected")
    }
    
}

extension TitledCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateControllerDelegate(with: indexPath.item)
    }
    
    private func updateControllerDelegate(with item: Int) {
        switch self.produce {
        case .fruit:
            let fruit = Fruit.allCases[item]
            delegate?.itemWasSelected(fruit)
        case .vegetable:
            let vegetable = Vegetable.allCases[item]
            delegate?.itemWasSelected(vegetable)
        default: // nil value
            break
        }
        
    }
}


extension TitledCollectionView {
    
    class Layout: UICollectionViewFlowLayout {
        static let heightConstant: CGFloat = 150
        
        override func prepare() {
            super.prepare()
            guard let collectionView = collectionView else { return }
            // TODO: why -13 to make the size even? section insets?
            itemSize = CGSize(width: collectionView.frame.width / 3 - 13, height: Self.heightConstant - 40)
            scrollDirection = .horizontal
            sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
}
