//
//  ViewController.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 19/09/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ApplesModuleViewController: UIViewController, ApplesModuleViewInput {
    
    var filter: AppleFilter!
    var output:ApplesModuleViewOutput!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        collectionView.dataSource = self
    }
    
    func setupInitialState() {
        filter = .all
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.obtainApples(filter)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionViewFlowLayout.itemSize = CGSize(width: self.view.frame.width, height: 66)
    }
    
    func updateApples() {
        self.collectionView.reloadData()
    }
    
    @IBAction func refreshButtonWasTaped(_ sender: Any) {
        output.obtainApples(filter)
    }
}

extension ApplesModuleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.output.appleCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AppleCollectionViewCell.self), for: indexPath) as! AppleCollectionViewCell
        
        // TODO: тут возоможна геренация другой обертки модели для view
        let apple = self.output.obtainApple(indexPath.row)
        // Cell customization
        cell.appleTitle.text = apple.title
        cell.appleDescription.text = apple.state.rawValue
        cell.appleIcon.backgroundColor = apple.color.toUIColor()
        cell.appleIcon.layer.cornerRadius = cell.appleIcon.frame.width / 2
        
        return cell
    }
}

extension ApplesModuleViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.filter = AppleFilter(rawValue: item.tag) ?? .all
    }
}
