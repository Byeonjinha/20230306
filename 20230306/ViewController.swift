//
//  ViewController.swift
//  20230306
//
//  Created by Byeon jinha on 2023/03/06.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    
    var isAllLoad = false
    let imageURLs = [
        "https://wallpaperaccess.com/download/europe-4k-1369012",
        "https://wallpaperaccess.com/download/europe-4k-1318341",
        "https://wallpaperaccess.com/download/europe-4k-1379801",
        "https://wallpaperaccess.com/download/cool-lion-167408",
        "https://wallpaperaccess.com/download/iron-man-323408"
    ]

    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        return layout
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load All Images", for: .normal)
        button.configuration = .filled()
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(620)
        }
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        button.addTarget(self, action: #selector(tapAllLoad), for: .touchUpInside)
    }
    
    @objc func tapAllLoad() {
        isAllLoad.toggle()
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.prepareForReuse()
        cell.imageURL = imageURLs[indexPath.row]
        cell.setData(isAllLoad: isAllLoad)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 80)
    }
}
