//
//  TweetTableViewController.swift
//  SmashTagDemo
//
//  Created by Abdoulaye Diallo on 7/7/17.
//  Copyright © 2017 Abdoulaye Diallo. All rights reserved.
//

import UIKit
import Twitter


class TweetTableViewController: UITableViewController {
    
    fileprivate var tweets = [Array<Twitter.tweet>]()
    
    private var  searchText : String = "" {
        didSet{
            tweets.removeAll()
            tableView.reloadData()
             searchForTweets()
            title = searchText
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText = "#stanford"
        
    }
    
    
    // MARK: - Private Tweets.
    
    func searchForTweets()  {
        
        
        
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
}
