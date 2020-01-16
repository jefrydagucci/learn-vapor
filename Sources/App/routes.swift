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
    app.get("bottles", ":count") { req -> String in
        guard let count = req.parameters.get("count", as: Int.self) else {
            throw Abort(.badRequest)
        }
        return "There were \(count) bottles on the wall"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
}
