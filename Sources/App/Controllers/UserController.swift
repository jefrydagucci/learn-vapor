///**
/**

Created by: Jefry Eko Mulya on 16/01/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent
import Vapor

struct UserController: RouteCollection {
    
    /*
    POST http://localhost:8080/api/users/
    {
       "name" : "Jefry",
       "username": "jefrydagucci"
    }
    */
    func boot(routes: RoutesBuilder) throws {
        routes.post("api", "users", use: createHandler)
        routes.get("api", "users", use: getAllHandler)
    }
    
    func createHandler(req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map { user }
    }
    
    /*
    GET http://localhost:8080/api/users/
    [
     {
        "name" : "Jefry",
        "username": "jefrydagucci"
     },
     {
        "name" : "Jefry2",
        "username": "jefrydagucci2"
     }
     ]
    */
    func getAllHandler(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }
}

