//
//  MessagesViewController.swift
//  healthpoints-imessage
//
//  Created by Joseph Smith on 10/24/17.
//  Copyright © 2017 Joseph Smith. All rights reserved.
//

import UIKit
import Messages



class MessagesViewController: MSMessagesAppViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var collectionView: UICollectionView!
    let defaults = UserDefaults(suiteName: "group.HealthPointsClub")
    var list: [[Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let data = defaults?.object(forKey: "widgetValues") as! Data
        list = NSKeyedUnarchiver.unarchiveObject(with: data) as! [[Any]]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let dateString = formatter.string(from: Date())
        var total = 0
        for attribute in list {
            total += attribute[1] as! Int
        }
        list.insert([dateString,total,UIColor.white], at: 0)
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
    
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
        
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
        
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
        
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messagesCell", for: indexPath) as! MessagesCollectionViewCell
        cell.descriptionLabel.text = (list[indexPath.row][0] as! String).description
        cell.pointsLabel.text = (list[indexPath.row][1] as! Int).description
        cell.backgroundColor = (list[indexPath.row][2] as! UIColor)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsAcross: CGFloat = CGFloat(4)
        //let cellsAcross: CGFloat = CGFloat(4)
        
        let spaceBetweenCells: CGFloat = 1
        let spacers = (cellsAcross-1)*spaceBetweenCells
        let dim = ((collectionView.bounds.width - spacers)) / cellsAcross
        if let cell = collectionView.cellForItem(at: indexPath) as? MessagesCollectionViewCell{
            var size = 14.0
            switch cellsAcross {
            case 4.0:
                size = 14.0
            case 3.0:
                size = 24.0
            case 2.0:
                size = 50.0
            default:
                size = 14.0
            }
            
            cell.pointsLabel.font = UIFont.systemFont(ofSize: (CGFloat(size)), weight: UIFont.Weight.heavy)
        }
        
        return CGSize(width: dim, height: dim)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        let cell = collectionView.cellForItem(at: indexPath) as! MessagesCollectionViewCell
        
        let viewFromNib = Bundle.main.loadNibNamed("AttributeCellView", owner: self, options: nil)?[0] as! AttributeCellView
        viewFromNib.descriptionLabel.text = cell.descriptionLabel.text!
        viewFromNib.pointsLabel.text = cell.pointsLabel.text!
        viewFromNib.backgroundColor = cell.backgroundColor

        UIGraphicsBeginImageContext(viewFromNib.frame.size)
        viewFromNib.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if  let conversation = activeConversation {
            let layout = MSMessageTemplateLayout()
            layout.image = image
            
            layout.caption = cell.descriptionLabel.text!
            if cell.pointsLabel.text! == "1" {
                layout.subcaption = "I got " + cell.pointsLabel.text! + " point!!!"
            }
            else {
                layout.subcaption = "I got " + cell.pointsLabel.text! + " points!!!"
            }
            let message = MSMessage()
            message.shouldExpire = false
            message.layout = layout
            
            conversation.insert(message, completionHandler: { (error: Error?) in
                print(error ?? "")
            }
            )}
    }
    
}

