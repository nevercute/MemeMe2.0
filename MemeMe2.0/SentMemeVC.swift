//
//  SentMemeVC.swift
//  MeMe1.0
//
//  Created by NEVERCUTE on 14/07/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import Foundation
import UIKit

class SentMemeVC: UITableViewController {
    
    //MARK: outlets
    
    //MARK: static meme var
    static var sentMemes = [Meme]()
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //read saved memes. Just now it is not finished. But I'll do it later. Thanks to you all, guys! Jast omit this comments, please
//        let sentMemePlistPaths = Bundle.main.paths(forResourcesOfType: "plist", inDirectory: nil)
//        for plistPath in sentMemePlistPaths {
//            if (plistPath as NSString).lastPathComponent == "SentMemes.plist" {
//                if let sentMemeDictionary = NSDictionary(contentsOfFile: plistPath) as? [String : AnyObject] {
//                    print(sentMemeDictionary)
//                }
//
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.updateMemeSavedDictionary()
    }
    
    
    //MARK: Table view cells configuration
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SentMemeVC.sentMemes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeCell")!
        let sentMeme = SentMemeVC.sentMemes[(indexPath as NSIndexPath).row]
        let sentMemeText = sentMeme.topText+" "+sentMeme.bottomText
        
        // Set image
        cell.textLabel?.text = sentMemeText
        cell.imageView?.image = sentMeme.memedImage
        
        return cell
    }
    
    //MARK: setuo detail view and push
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailVC") as! SentMemeDetailVC
        detailController.sentMeme = SentMemeVC.sentMemes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    fileprivate func updateMemeSavedDictionary() {
        let dict = ["savedMemes": SentMemeVC.sentMemes]
        
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let sentMemeDataFileName = "SentMemes.plist"
        let pathArray = [dirPath.path, sentMemeDataFileName]
        let path = "file:/"+pathArray.joined(separator: "/")
        if let filePath = URL(string: path) {
            print(filePath)
            do  {
                let data = try PropertyListSerialization.data(fromPropertyList: dict, format: PropertyListSerialization.PropertyListFormat.xml, options: 0)
                FileManager.default.createFile(atPath: path, contents: data, attributes: [:])
                print("Successfully write")
                
            } catch (let err){
                print(err.localizedDescription)
            }
        }
    }
}


