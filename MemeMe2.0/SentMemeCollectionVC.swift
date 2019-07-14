//
//  SentMemeCollectionVC.swift
//  MeMe1.0
//
//  Created by NEVERCUTE on 14/07/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionVC: UICollectionViewController {
    
    //MARK: outlets
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Implement flowLayout here.
        let interitemSpacing:CGFloat = 3.0
        let lineSpacing:CGFloat = 6.0
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0.0
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0.0
        let topSafeAreaHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
        let bottomSafeAreaHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        let widthDimension = (view.frame.size.width - (2 * interitemSpacing)) / 3.0
        let heightDimension = (view.frame.size.height - (4 * lineSpacing)
            - navBarHeight - tabBarHeight - topSafeAreaHeight - bottomSafeAreaHeight) / 5.0 as CGFloat
        
        flowLayout.sectionFootersPinToVisibleBounds = true
        flowLayout.minimumInteritemSpacing = interitemSpacing
        flowLayout.minimumLineSpacing = lineSpacing
        flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    //MARK: setup collection view cells
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SentMemeVC.sentMemes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionCell", for: indexPath) as! SentMemeCollectionCell
        let sentMeme = SentMemeVC.sentMemes[(indexPath as NSIndexPath).row]
        
        // Set the image
        cell.sentMemeImage.image = sentMeme.memedImage
        cell.topTextLabel.text = sentMeme.topText
        cell.bottomTextLabel.text = sentMeme.bottomText
        return cell
    }
    
    //MARK: setuo detail view and push
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailVC") as! SentMemeDetailVC
        detailController.sentMeme = SentMemeVC.sentMemes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
