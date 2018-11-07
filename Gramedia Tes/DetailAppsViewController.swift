//
//  DetailAppsViewController.swift
//  Gramedia Tes
//
//  Created by tashya on 11/8/18.
//  Copyright © 2018 FajriCorp. All rights reserved.
//

import UIKit

class DetailAppsViewController: UIViewController {
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var subTitlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    lazy var gamesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.autoSetDimensions(to: CGSize(width: 120, height: 120))
//        imageView.backgroundColor = .black
        return imageView
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
    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.autoSetDimensions(to: CGSize(width: 80, height: 30))
        button.backgroundColor = UIColor(red: 1.0/255.0, green: 126.0/255.0, blue: 228.0/255.0, alpha: 1)
        return button
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-more-20"), for: .normal)
        button.layer.cornerRadius = 15
        button.autoSetDimensions(to: CGSize(width: 30, height: 30))
        button.backgroundColor = UIColor(red: 1.0/255.0, green: 126.0/255.0, blue: 228.0/255.0, alpha: 1)
        return button
    }()
    
    var dataGames: DataItem?{
        didSet{
            guard let itemName = dataGames?.name else { return }
            guard let itemPrice = dataGames?.price else { return }
            setupGamesImage()
            titlelabel.text = itemName
            subTitlelabel.text = "Rp \((itemPrice/100).formattedWithSeparator)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        view.addSubview(gamesImage)
        view.addSubview(titlelabel)
        view.addSubview(subTitlelabel)
        view.addSubview(downloadButton)
        view.addSubview(purchaseLabel)
        view.addSubview(moreButton)
        
        gamesImage.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        gamesImage.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        
        titlelabel.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 15)
        titlelabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        titlelabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        subTitlelabel.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 15)
        subTitlelabel.autoPinEdge(.top, to: .bottom, of: titlelabel, withOffset: 5)
        
        downloadButton.autoPinEdge(.top, to: .bottom, of: subTitlelabel, withOffset: 15)
        downloadButton.autoPinEdge(.leading, to: .trailing, of: gamesImage, withOffset: 15)
        
        purchaseLabel.autoAlignAxis(.horizontal, toSameAxisOf: downloadButton)
        purchaseLabel.autoPinEdge(.leading, to: .trailing, of: downloadButton, withOffset: 5)
        
        moreButton.autoAlignAxis(.horizontal, toSameAxisOf: downloadButton)
        moreButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
    }
    func setupGamesImage(){
        guard let urlImage = dataGames?.imageURL else { return }
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
