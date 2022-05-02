//
//  HightlightViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/04/05.
//

import UIKit

class HighlightViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "HighlightCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HighlightCollectionViewCell")
        }
    }

    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 64)

        // Do any additional setup after loading the view.
    }
}

extension HighlightViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightCollectionViewCell", for: indexPath)
        return cell
    }
}
