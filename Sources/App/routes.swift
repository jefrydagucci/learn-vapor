import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req in
        return "Hello, world!"
    }
    
    //bottles/99
    app.get("bottles", ":count") { req -> Bottles in
        guard let count = req.parameters.get("count", as: Int.self) else {
            throw Abort(.badRequest)
        }
        return Bottles(count: count)
    }
    
    //hello/Tim -> Hello Tim
    app.get("hello", ":name") { req -> String in
        guard let name = req.parameters.get("name", as: String.self) else {
            throw Abort(.badRequest)
        }
        return "Hello \(name)"
    }
    
    /*
     POST http://localhost:8080/bottles/
     {
        "count" : 99
     }
     */
    app.post("bottles") { (req) -> String in
        let bottles = try req.content.decode(Bottles.self)
        return "There we \(bottles.count) bottles"
    }
    
//    /*
//     Accept and return JSON
//     POST http://localhost:8080/user-info/
//     {
//        "name" : "Tim",
//        "age": 17
//     }
//     */
//    app.post("user-info") { (req) -> UserInfo in
//        return try req.content.decode(UserInfo.self)
//    }
    
    /*
    Accept and return JSON
    POST http://localhost:8080/user-info/
    {
       "name" : "Tim",
       "age": 17
    }
    */
    app.post("user-info") { (req) -> UserMessage in
        let user = try req.content.decode(UserInfo.self)
        let message = "Hello \(user.name), you are \(user.age)"
        return UserMessage(message: message)
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
    
    try app.register(collection: UserController())
}
