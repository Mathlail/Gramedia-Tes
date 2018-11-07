//
//  ListGamesBigCollectionViewCell.swift
//  Gramedia Tes
//
//  Created by tashya on 11/7/18.
//  Copyright © 2018 FajriCorp. All rights reserved.
//

import UIKit

class ListGamesBigCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var subTitlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        return label
    }()
    
    lazy var purchaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = UIColor.gray
        label.text = "In-App Purchases"
        label.numberOfLines = 2
        label.autoSetDimension(.width, toSize: 50)
        return label
    }()
    
    lazy var gamesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.autoSetDimensions(to: CGSize(width: 80, height: 80))
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor(red: 1.0/255.0, green: 126.0/255.0, blue: 228.0/255.0, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
        button.autoSetDimensions(to: CGSize(width: 80, height: 30))
        button.backgroundColor = UIColor.groupTableViewBackground
        return button
    }()
    
    lazy var separatorView: UIView = {
        let separator = UIView()
        separator.autoSetDimension(.height, toSize: 1.5)
        separator.backgroundColor = UIColor.groupTableViewBackground
        return separator
    }()
    
    var item: DataItem? {
        didSet {
            guard let itemName = item?.name else { return }
            guard let itemPrice = item?.price else { return }
            setupGamesImage()
            titlelabel.text = itemName
            if itemPrice > 0 {
                subTitlelabel.text = "Rp \((itemPrice/100).formattedWithSeparator)"
            } else {
                subTitlelabel.text = "Free"
            }
            
            
        }
    }
    
    func setupView(){
        addSubview(gamesImage)
        addSubview(titlelabel)
        addSubview(subTitlelabel)
        addSubview(downloadButton)
        addSubview(purchaseLabel)
        addSubview(separatorView)
        
        gamesImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        gamesImage.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        
        titlelabel.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 15)
        titlelabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        titlelabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        subTitlelabel.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 15)
        subTitlelabel.autoPinEdge(.top, to: .bottom, of: titlelabel, withOffset: 3)
        
        downloadButton.autoPinEdge(.top, to: .bottom, of: subTitlelabel, withOffset: 15)
        downloadButton.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 15)
        
        purchaseLabel.autoAlignAxis(.horizontal, toSameAxisOf: downloadButton)
        purchaseLabel.autoPinEdge(.leading, to: .trailing, of: downloadButton, withOffset: 5)
        
        separatorView.autoPinEdge(toSuperviewEdge: .bottom)
        separatorView.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 15)
        separatorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
    }
    
    func setupGamesImage(){
        guard let urlImage = item?.imageURL else { return }
        let url = URL(string: urlImage)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                self.gamesImage.image = UIImage(data: data!)
            }
            }.resume()
    }

}
