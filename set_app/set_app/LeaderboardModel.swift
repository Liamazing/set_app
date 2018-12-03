//
//  LeaderboardModel.swift
//  set_app
//
//  Created by Nicole Ouzounian on 12/2/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

//model for our leaderboard from the database 
class LeaderboardModel {
    
    var id: String?
    var leaderName: String?
    var leaderScore: Int?
    
    init(id: String?, leaderName: String?, leaderScore: Int?){
        self.id = id
        self.leaderName = leaderName
        self.leaderScore = leaderScore
    }
}
