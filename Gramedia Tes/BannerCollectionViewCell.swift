//
//  BannerCollectionViewCell.swift
//  Gramedia Tes
//
//  Created by tashya on 11/6/18.
//  Copyright © 2018 FajriCorp. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var newGameslabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = UIColor(red: 1.0/255.0, green: 126.0/255.0, blue: 228.0/255.0, alpha: 1)
        label.text = "NEW GAME"
        return label
    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
//        label.textColor = UIColor.blue
        label.text = "Ragnarok M : Eternal Love"
        return label
    }()
    
    lazy var subTitlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.gray
        label.text = "The classic adventure returns"
        return label
    }()
    
    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var item: DataItem? {
        didSet {
            guard let itemName = item?.name else { return }
            guard let itemPrice = item?.price else { return }
            if let urlImage = item?.imageURL {
                bannerImage.setupImage(urlString: urlImage)
            }
            titlelabel.text = itemName
            if itemPrice > 0 {
                subTitlelabel.text = "Rp \((itemPrice/100).formattedWithSeparator)"
            } else {
                subTitlelabel.text = "Free"
            }
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerImage.clipsToBounds = true
        bannerImage.layer.masksToBounds = true
        
        bannerImage.layer.cornerRadius = 8
    }
    
    func setupView(){
        addSubview(newGameslabel)
        addSubview(titlelabel)
        addSubview(subTitlelabel)
        addSubview(bannerImage)
        
        newGameslabel.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
        newGameslabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 5)
        
        titlelabel.autoPinEdge(.top, to: .bottom, of: newGameslabel, withOffset: 5)
        titlelabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 5)
        titlelabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5)
        
        subTitlelabel.autoPinEdge(.top, to: .bottom, of: titlelabel, withOffset: 5)
        subTitlelabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 5)
        subTitlelabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5)
        
        bannerImage.autoPinEdge(.top, to: .bottom, of: subTitlelabel, withOffset: 5)
        bannerImage.autoPinEdge(toSuperviewEdge: .leading, withInset: 5)
        bannerImage.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5)
        bannerImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 25)
        
    }
}
