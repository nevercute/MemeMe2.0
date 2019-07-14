//
//  SentMemeVC.swift
//  MeMe1.0
//
//  Created by NEVERCUTE on 14/07/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import Foundation
import UIKit

class SentMemeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: outlets
    
    //MARK: local vars
    var sentMemes = [Meme]()
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: Table view cells configuration
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sentMemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeCell")!
        let sentMeme = self.sentMemes[(indexPath as NSIndexPath).row]
        let sentMemeText = sentMeme.topText+" "+sentMeme.bottomText
        
        // Set image
        cell.textLabel?.text = sentMemeText
        cell.imageView?.image = sentMeme.memedImage
        
        return cell
    }
    
    //MARK: setuo detail view and push
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailVC") as! SentMemeDetailVC
        detailController.sentMeme = self.sentMemes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
