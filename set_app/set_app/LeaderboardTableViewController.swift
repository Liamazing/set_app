//
//  LeaderboardTableViewController.swift
//  set_app
//
//  Created by Nicole Ouzounian on 12/2/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LeaderboardTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewLeaderboard: UITableView!
    
    var refLeaderboard: DatabaseReference!
    var leaderName: DatabaseReference!
    var leaderScore: DatabaseReference!
    var name = ""
    var score = 1000
    
    // list to store all of the leaderboard scores
    var leaderList = [LeaderboardModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.delegate = self
        //tableView.dataSource = self
        
        FirebaseApp.configure()
        
        refLeaderboard = Database.database().reference().child("leaderboard")
        
        refLeaderboard.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                self.leaderList.removeAll()
                for leaders in snapshot.children.allObjects as! [DataSnapshot] {
                    let leaderObject = leaders.value as? [String: AnyObject]
                    let leaderName = leaderObject?["leaderName"]
                    let leaderScore = leaderObject?["leaderScore"]
                    let leaderId = leaderObject?["id"]
                    
                    let leader = LeaderboardModel(id: leaderId as! String?, leaderName: leaderName as! String?, leaderScore: leaderScore as! String?)
                    
                    self.leaderList.append(leader)
                    
                }
                
                self.tableViewLeaderboard.reloadData()
                
            }
            
        })
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addScore(_ sender: Any) {
        let addNewScore = UIAlertController(title: "Congratulations, youre score is 1000!", message: "Please enter your name", preferredStyle: .alert)
        
        addNewScore.addTextField { (textField) in
            textField.placeholder = "name"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.name = (addNewScore.textFields?.first?.text)!
            self.score = self.score + 50
            self.addLeader()
        }
        addNewScore.addAction(okAction)
        present(addNewScore, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addLeader(){
        //auto generate key
        let key = refLeaderboard.childByAutoId().key
        let scoreString = String(score)
        let newScore = ["id":key,
                         "leaderName": name,
                         "leaderScore": scoreString
                         ]
        refLeaderboard.child(key!).setValue(newScore)
        print("score added \(name)")
    }

    // TODO: IF BROKEN ADD VIEW DID APPEAR FUNC
    
    
    
    // MARK: - Table view data source
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
 
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaderList.count
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaderboardTableViewCell
        let leader: LeaderboardModel
        leader = leaderList[indexPath.row]
        
        cell.playerName.text = leader.leaderName
        cell.playerScore.text = leader.leaderScore
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
