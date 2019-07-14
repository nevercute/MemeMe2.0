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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
