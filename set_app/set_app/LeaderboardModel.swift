//
//  LeaderboardModel.swift
//  set_app
//
//  Created by Nicole Ouzounian on 12/2/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

class LeaderboardModel {
    
    var id: String?
    var leaderName: String?
    var leaderScore: String?
    
    init(id: String?, leaderName: String?, leaderScore: String?){
        self.id = id
        self.leaderName = leaderName
        self.leaderScore = leaderScore
    }
}
