//
//  ListGamesCollectionViewCell.swift
//  Gramedia Tes
//
//  Created by tashya on 11/7/18.
//  Copyright © 2018 FajriCorp. All rights reserved.
//

import UIKit

class ListGamesCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        //        label.textColor = UIColor.blue
        label.text = "Ragnarok M : Eternal Love XXX"
        label.numberOfLines = 2
        return label
    }()
    
    lazy var subTitlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        label.text = "The classic adventure returns"
        return label
    }()
    
    lazy var purchaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = UIColor.gray
        label.text = "In-App Purchases"
        return label
    }()
    
    lazy var gamesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.autoSetDimensions(to: CGSize(width: 60, height: 60))
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy var downloadButton: UIButton = {
       let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor(red: 1.0/255.0, green: 126.0/255.0, blue: 228.0/255.0, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
        button.autoSetDimensions(to: CGSize(width: 70, height: 30))
        button.backgroundColor = UIColor.groupTableViewBackground
        return button
    }()
    
    var item: DataItem? {
        didSet {
            guard let itemName = item?.name else { return }
            guard let itemPrice = item?.price else { return }
            setupGamesImage()
            titlelabel.text = itemName
            subTitlelabel.text = "Rp \((itemPrice/100).formattedWithSeparator)"
            
        }
    }
    
    func setupView(){
        addSubview(gamesImage)
        addSubview(titlelabel)
        addSubview(subTitlelabel)
        addSubview(downloadButton)
        addSubview(purchaseLabel)
        
        gamesImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        gamesImage.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        
        titlelabel.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 10)
        titlelabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        titlelabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)
        titlelabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        
        
        subTitlelabel.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 10)
        subTitlelabel.autoPinEdge(.top, to: .bottom, of: titlelabel, withOffset: 5)
        
        downloadButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
        downloadButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        downloadButton.autoPinEdge(.leading, to: .trailing, of: titlelabel, withOffset: 10, relation: .greaterThanOrEqual)
        downloadButton.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        downloadButton.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
        
        purchaseLabel.autoAlignAxis(.vertical, toSameAxisOf: downloadButton)
        purchaseLabel.autoPinEdge(.top, to: .bottom, of: downloadButton, withOffset: 5)
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
