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

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var theTableView: UITableView!
    var leaderList:[LeaderboardModel] = []
    var refLeaderboard:DatabaseReference!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("making a cell")
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
        // Do any additional setup after loading the view.
        //FirebaseApp.configure()
        
        refLeaderboard = Database.database().reference().child("leaderboard")
        //refLeaderboard.query
        
        refLeaderboard.queryOrdered(byChild: "leaderScore").observe(DataEventType.value, with: { (snapshot) in
            
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
                self.leaderList.reverse()
                self.theTableView.reloadData()
                
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
