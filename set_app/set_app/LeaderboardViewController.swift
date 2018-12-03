//
//  LeaderboardViewController.swift
//  set_app
//
//  Created by Mia Bendy on 12/2/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

//view controller for the leaderboard
class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var theTableView: UITableView!
    var leaderList:[LeaderboardModel] = []
    var refLeaderboard:DatabaseReference!
    
    //number of people in the leaderboard
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderList.count
    }
    
    //makes a cell for the leaderboard for each leader
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  theTableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as! LeaderBoardTableViewCell
        cell.name.text = leaderList[indexPath.row].leaderName!
        cell.score.text = String(leaderList[indexPath.row].leaderScore!)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(UINib(nibName: "LeaderBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "leaderboardCell")
        refLeaderboard = Database.database().reference().child("leaderboard")
        DispatchQueue.global().async{ //asynchronously get the leaderboard data
            self.refLeaderboard.queryOrdered(byChild: "leaderScore").observe(DataEventType.value, with: { (snapshot) in
                
                if snapshot.childrenCount > 0 {
                    
                    self.leaderList.removeAll()
                    for leaders in snapshot.children.allObjects as! [DataSnapshot] {
                        let leaderObject = leaders.value as? [String: AnyObject]
                        let leaderName = leaderObject?["leaderName"]
                        let leaderScore = leaderObject?["leaderScore"]
                        let leaderId = leaderObject?["id"]
                        
                        let leader = LeaderboardModel(id: leaderId as! String?, leaderName: leaderName as! String?, leaderScore: leaderScore as! Int?)
                        
                        self.leaderList.append(leader)
                        
                    }
                    
                    DispatchQueue.main.async { //reload the data for the table view
                        self.leaderList.reverse()
                        self.theTableView.reloadData()
                    }
                    
                }
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
