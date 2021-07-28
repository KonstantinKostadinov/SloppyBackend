import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    //MARK: Unprotected API
    let unprotectedApi = app.routes
    try unprotectedApi.register(collection: AppUserController.Unprotected())
    
    //MARK: Password Protected API
    let passwordProtectedApi = unprotectedApi.grouped(AppUser.authenticator())
    try passwordProtectedApi.register(collection: AppUserController.PasswordProtected())

    //MARK: Token Protected API
    try app.jwt.signers.use(.es512(key: .generate()))
    let tokenProtectedApi = unprotectedApi.grouped(AppUserAuthenticator())
    try tokenProtectedApi.register(collection: AppUserController.TokenProtected())

    let tokenProtectedContainerApi = unprotectedApi.grouped(AppUserAuthenticator())
    try tokenProtectedContainerApi.register(collection: AppPlantsController.TokenProtected())
}
