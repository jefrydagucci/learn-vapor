///**
/**

Created by: Jefry Eko Mulya on 16/01/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent
import Vapor

final class Reminder: Model, Content {
    static let schema = "reminders"
    
    @ID(key: "id") var id: Int?
    
    @Field(key: "title") var title: String
    
    @Parent(key: "userID") var user: User

    init() { }

    init(id: Int? = nil, title: String, userID: User.IDValue) {
        self.id = id
        self.title = title
        self.$user.id = userID
    }
}
