import Fluent
import FluentPostgresDriver
import Vapor
import Mailgun


// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

   // app.http.server.configuration.port = 4200
    
    try app.databases.use(.postgres(url: Environment.databaseURL), as: .psql)
    //databases(databases: app.databases)
    migrate(migrations: app.migrations)

//    app.mailgun.configuration = .environment
//    app.mailgun.defaultDomain = .init("sandbox45a8eb3e436442b890f2d4d3ec5bc6f6.mailgun.org", .us)

    // register routes
    try routes(app)
}
