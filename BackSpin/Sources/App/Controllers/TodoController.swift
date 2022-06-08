import Fluent
import Vapor

struct TodoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":todoID") { todo in
            todo.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Todo] {
        try await Todo.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Todo {
        let todo = try req.content.decode(Todo.self)
        try await todo.save(on: req.db)
        return todo
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await todo.delete(on: req.db)
        return .ok
    }
}

struct ListController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("lists")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":listID") { todo in
            todo.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [List] {
        try await List.query(on: req.db).all()
    }

    func create(req: Request) async throws -> List {
        let todo = try req.content.decode(List.self)
        try await todo.save(on: req.db)
        return todo
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let todo = try await List.find(req.parameters.get("listID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await todo.delete(on: req.db)
        return .ok
    }
}
