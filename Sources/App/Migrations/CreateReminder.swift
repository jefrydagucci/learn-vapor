///**
/**

Created by: Jefry Eko Mulya on 16/01/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent

struct CreateReminder: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Reminder.schema)
            .field("id", .int, .identifier(auto: true))
            .field("title", .string, .required)
            .field("userID", .int, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Reminder.schema).delete()
    }
}

