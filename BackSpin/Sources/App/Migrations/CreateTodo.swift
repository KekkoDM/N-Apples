import Fluent

struct CreateTodo: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("todos")
            .id()
            .field("title", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("List").delete()
    }
}

struct CreateList: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("List")
            .id()
            .field("idEvent", .string, .required)
            .field("nameList", .array(of: .string))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("List").delete()
    }
}
