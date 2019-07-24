//
//  ViewController.swift
//  RevCollView
//
//  Created by amritpal singh on 25/07/19.
//  Copyright © 2019 amritpal singh. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var ref:DatabaseReference!
    
    
    @IBOutlet weak var collectionViewCntrlr: UICollectionView!
    let reversedLayout = InvertedStackLayout()
    var colours = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        ref.observe(.value, with: { snapShot in
            
            let rootDict = snapShot.value as? [String:AnyObject] ?? [:]
            let dict = rootDict["colours"] as? [String:String] ?? [:]
            for color in dict
            {
                self.colours.append("\(color.key):\(color.value)")
            }
            
            DispatchQueue.main.async {
                self.collectionViewCntrlr.reloadData()
            }
            
        })
        
        collectionViewCntrlr.collectionViewLayout = reversedLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TextCollectionViewCell
        cell.text.text = colours[indexPath.row];
        return cell
    }
}


