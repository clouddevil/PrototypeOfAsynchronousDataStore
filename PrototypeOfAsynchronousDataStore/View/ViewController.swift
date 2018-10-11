//
//  ViewController.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 19/09/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // MARK:- do we really need weak ptr here?
    private weak var applesStorage: ApplesStorage? = AppDelegate.applesStorage
    
    deinit {
        applesStorage?.applesCollection.unsubscribe(obj: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        applesStorage?.filter = .all
        
        // MARK:- perhaps, we should use weak self here
        applesStorage?.applesCollection.subscribeOnChanges(obj: self, block: {
            self.collectionView.reloadData()
        })
        
        tabBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applesStorage?.fetchApples()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionViewFlowLayout.itemSize = CGSize(width: self.view.frame.width, height: 66)
    }
    
    @IBAction func refreshButtonWasTaped(_ sender: Any) {
        applesStorage?.fetchApples()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return applesStorage?.applesCollection.apples.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AppleCollectionViewCell.self), for: indexPath) as! AppleCollectionViewCell
        
        
        let apple = applesStorage!.applesCollection.apples[indexPath.row]
        // Cell customization
        cell.appleTitle.text = apple.title
        cell.appleDescription.text = apple.state.rawValue
        cell.appleIcon.backgroundColor = apple.color.toUIColor()
        cell.appleIcon.layer.cornerRadius = cell.appleIcon.frame.width / 2
        
        return cell
    }
}

extension ViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        switch item.tag {
        case 0:
            applesStorage?.filter = .all
            break
        case 1:
            applesStorage?.filter = .needToEat
            break
        case 2:
            applesStorage?.filter = .eaten
            break
        default: break
            //Skip
        }
    }
}
