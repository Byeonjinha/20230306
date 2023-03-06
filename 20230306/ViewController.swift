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
        "http://image.dongascience.com/Photo/2017/03/14900752352661.jpg",
        "https://cdn.pixabay.com/photo/2017/09/25/13/12/puppy-2785074__480.jpg",
        "https://cdn.pixabay.com/photo/2016/10/10/14/13/dog-1728494__480.png",
        "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313__480.jpg",
        "https://cdn.pixabay.com/photo/2018/01/09/11/04/dog-3071334__480.jpg"
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
        isAllLoad = true
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
