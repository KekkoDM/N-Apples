import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "na",
        password: Environment.get("DATABASE_PASSWORD") ?? "napples",
        database: Environment.get("DATABASE_NAME") ?? "napples"
    ), as: .psql)

    app.migrations.add(CreateTodo())
    app.migrations.add(CreateList())
    app.views.use(.leaf)

    // register routes
    try routes(app)
}
