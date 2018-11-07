//
//  HomeViewController.swift
//  Gramedia Tes
//
//  Created by tashya on 11/6/18.
//  Copyright © 2018 FajriCorp. All rights reserved.
//

import UIKit
import PureLayout

class HomeViewController: UIViewController, OpenDetailProtocol {
    
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var dataGames = [DataItem]()
    var dataListGames = [DataItem]()
    var dataNewReleaseGames = [DataItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getContent()
        setupView()
        collectionView.register(BaseBannerCollectionViewCell.self, forCellWithReuseIdentifier: "BaseBannerCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "NewGamesTitleCell")
        collectionView.register(BaseNewGamesCollectionViewCell.self, forCellWithReuseIdentifier: "BaseNewGamesCell")
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        title = "Games"
        view.addSubview(collectionView)
        
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        collectionView.autoPinEdge(toSuperviewEdge: .top)
    }
    
    func getContent(){
        let urlString = "https://store.steampowered.com/api/featuredcategories/"
        guard let url = URL(string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                let dictTopSellers = json["top_sellers"] as? [String:Any]
                let arrayTopSellers = dictTopSellers?["items"] as? [[String: Any]] ?? []
                
                let dictSpecials = json["specials"] as? [String:Any]
                let arraySpecials = dictSpecials?["items"] as? [[String: Any]] ?? []
                
                let dictNewRelease = json["new_releases"] as? [String:Any]
                let arrayNewRelease = dictNewRelease?["items"] as? [[String: Any]] ?? []
                
                for dict in arrayTopSellers {
                    let item = DataItem(json: dict)
                    self.dataGames.append(item)
                }
                
                for dict in arrayNewRelease {
                    let item = DataItem(json: dict)
                    self.dataNewReleaseGames.append(item)
                }
                
                for dict in arraySpecials {
                    let item = DataItem(json: dict)
                    self.dataListGames.append(item)
                }
                
                DispatchQueue.main.async {
                    print(self.dataNewReleaseGames)
                    self.collectionView.reloadData()
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
    
    func openListGames(){
        let vc = ListGamesViewController()
        vc.view.backgroundColor = .white
        vc.dataNewReleaseGames = dataNewReleaseGames
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didPressCell(data: DataItem) {
        let vc = DetailAppsViewController()
        vc.view.backgroundColor = .white
        vc.dataGames = data
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseBannerCell", for: indexPath) as! BaseBannerCollectionViewCell
            cell.dataGames = dataGames
            cell.collectionView.reloadData()
            cell.delegate = self
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewGamesTitleCell", for: indexPath)
            let titleLabel = UILabel(frame: CGRect(x: 10, y: 15, width: self.view.frame.width - 150, height: 30))
            titleLabel.text = "New Games We Love"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
            cell.contentView.addSubview(titleLabel)
            
            let seeAllButton = UIButton(frame: CGRect(x: self.view.frame.width - 90, y: 15, width: 70, height: 30))
            seeAllButton.setTitle("See All", for: .normal)
            seeAllButton.setTitleColor(UIColor(red: 1.0/255.0, green: 126.0/255.0, blue: 228.0/255.0, alpha: 1), for: .normal)
            seeAllButton.addTarget(self, action: #selector(openListGames), for: .touchUpInside)
            cell.contentView.addSubview(seeAllButton)
            
            let separatorView = UIView(frame: CGRect(x: 5, y: 10, width: Double(UIScreen.main.bounds.width - 10), height: 1))
            separatorView.backgroundColor = UIColor.groupTableViewBackground
            cell.contentView.addSubview(separatorView)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseNewGamesCell", for: indexPath) as! BaseNewGamesCollectionViewCell
            cell.dataListGames = dataListGames
            cell.collectionView.reloadData()
            cell.delegate = self
            return cell
        }
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        if indexPath.item == 0 {
            return CGSize(width: screenSize.width, height: 300)
        } else if indexPath.item == 1 {
            return CGSize(width: screenSize.width, height: 60)
        } else {
            return CGSize(width: screenSize.width, height: 240)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }

}





