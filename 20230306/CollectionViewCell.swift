//
//  collectionViewCell.swift
//  20230306
//
//  Created by Byeon jinha on 2023/03/06.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    func setData(isAllLoad: Bool) {
          // 기존 태스크 및 프로그래스 옵저버 해제
          task?.cancel()
          observation?.invalidate()
          
          isLoad = isAllLoad
          
          if isLoad {
              self.button.isSelected = true
          }
      }
    
    private var observation: NSKeyValueObservation!
    
    private var task: URLSessionDataTask!
    
    private var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    let placeholderImage = UIImage(systemName: "photo")
    
    var imageURL: String? = nil
    
    var isLoad: Bool = false {
        didSet {
            if isLoad {
                // 이미지가 로드 되기 전 이미지 재사용을 막기위해 placeholderImage로 대체 후 로드.
                super.prepareForReuse()
                self.imageView.image = placeholderImage
                loadImage(url: imageURL ?? "http://image.dongascience.com/Photo/2017/03/14900752352661.jpg")
            } else {
                self.imageView.image = placeholderImage
            }
        }
    }
    
    let imageView: UIImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(systemName: "photo")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var button: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.setTitle("Stop", for: .selected)
        button.configuration = .filled()
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    func reset() {
        imageView.image = .init(systemName: "photo")
        progressView.progress = 0
        button.isSelected = false
    }
    
    func loadImage(url: String) {
        // 기존 태스크 취소
        task?.cancel()
        
        // 이미지 URL
        let imageUrl = URL(string: url)!
        
        // URL 요청 생성
        let request = URLRequest(url: imageUrl)
        
        // URL 데이터 다운로드 태스크 생성
        task = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                guard error.localizedDescription == "cancelled" else {
                    fatalError(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.reset()
                }
                return
            }
            // 다운로드 완료 후 처리할 작업
            if let data = data {
                
                // 다운로드한 데이터를 UIImage로 변환
                let image = UIImage(data: data)
                
                // 이미지 뷰에 이미지 설정
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.button.isSelected = false
                }
                
            }
        }
        observation = task.progress.observe(\.fractionCompleted, options: [.new]) { progress, _ in
            DispatchQueue.main.async {
                self.progressView.progress = Float(progress.fractionCompleted)
            }
        }

        // 태스크 실행
        task.resume()
        
    }
    weak var delegate: CustomCellDelegate?
    
    
    @objc func tapLoad(_ sender: UIButton)  {
          sender.isSelected = !sender.isSelected
          
          if sender.isSelected {
              self.isLoad = true
          } else {
              task?.cancel()
              self.reset()
          }
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(progressView)
        self.addSubview(button)
        self.backgroundColor = .clear
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(100)
        }
        progressView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(30)
            $0.width.equalTo(120)
        }
        button.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
            $0.leading.equalTo(progressView.snp.trailing)
        }
        
        button.addTarget(self, action: #selector(tapLoad), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// CustomCellDelegate 프로토콜을 정의합니다.
protocol CustomCellDelegate: AnyObject {
    func cellCheckBoxButtonTapped(sender: CollectionViewCell)
}
