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
        routes.get("api", "users", ":userID", use: getHandler)
        routes.delete("api", "users", ":userID", use: deleteHandler)
        routes.put("api", "users", ":userID", use: updateHandler)
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
    
    /*
     GET http://localhost:8080/api/users/1
     {
     "name" : "Jefry",
     "username": "jefrydagucci"
     }
     */
    func getHandler(req: Request) throws -> EventLoopFuture<User> {
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    /*
     DELETE http://localhost:8080/api/users/1
     */
    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return try getHandler(req: req)
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
    
    /*
     PUT http://localhost:8080/api/users/1
     {
     "name" : "Jefry",
     "username": "jefrydagucci"
     }
     */
    func updateHandler(req: Request) throws -> EventLoopFuture<User> {
        let updatedUser = try req.content.decode(User.self)
        return try getHandler(req: req)
            .flatMap { user in
                user.name = updatedUser.name
                user.username = updatedUser.name
                return user.save(on: req.db).map { user }
        }
    }
    
//    func updateHandler(req: Request) throws -> EventLoopFuture<User> {
//        let updatedUser = try req.content.decode(User.self)
//        return User.find(req.parameters.get("userID"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap { user in
//                user.name = updatedUser.name
//                user.username = updatedUser.name
//                return user.save(on: req.db).map { user }
//        }
//    }
}

