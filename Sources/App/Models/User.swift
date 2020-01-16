///**
/**

Created by: Jefry Eko Mulya on 16/01/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "username")
    var username: String

    init() { }

    init(id: Int? = nil, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}

