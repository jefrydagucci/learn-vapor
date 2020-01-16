///**
/**

Created by: Jefry Eko Mulya on 16/01/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(User.schema)
            .field("id", .int, .identifier(auto: true))
            .field("name", .string, .required)
            .field("username", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(User.schema).delete()
    }
}

