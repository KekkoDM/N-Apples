import Fluent
import Vapor

import SMTPKitten
import VaporSMTPKit

extension SMTPCredentials {
    static var `default`: SMTPCredentials {
        return SMTPCredentials(
            hostname: "in-v3.mailjet.com",
            port: 587,
            ssl: .startTLS(configuration: .default),
            email: "napples.developers@gmail.com",
            password: "Napples2022!"
        )
    }
}
struct UserStruct: Content{
    
    var name:String
    var surname:String
    var idEvent: String
    var email: String
    var namweList: String
    var numFriends: Int
}

struct ListsStruct: Codable {
    let idEvent: String
    let lists: [String]
}

struct ReservationStruct : Codable{
    let idEvent: String
    let name: String
    let surname: String
    let email: String
    let nameList: String
    let numFriends: Int
}

func routes(_ app: Application) throws {
    
    app.get("res", ":id") { req -> EventLoopFuture<View> in
        let id = req.parameters.get("id")!
        return List.query(on: req.db).filter(\.$idEvent == id).all().flatMap{ list in
            return req.view.render("index", ListsStruct(idEvent: list.first?.idEvent ?? "", lists: list.first?.nameList ?? []))
        }
    }
    
    app.get("take") { req -> EventLoopFuture<View> in
        //        let id = req.parameters.get("id")!
        
        return req.view.render("HTMLMail")
    }
    
    //    app.get(":idEvent") { req -> String in
    //        guard let idEvent = req.parameters.get("username",as: String.self) else {throw Abort(.badRequest)}
    //
    //        return idEvent
    //    }
    
    app.post("reservation") { req  -> EventLoopFuture<String> in
        let res = try req.content.decode(ReservationStruct.self)
        
        
        let reservation = Todo(name: res.name, surname: res.surname, email: res.email, nameList: res.nameList, idEvent: res.idEvent, numFriends: res.numFriends)
        let email = Mail(
            from: "napples.developers@gmail.com",
            to: [
                MailUser(name: "Myself", email: res.email)
            ],
            subject: "Your new mail server!",
            contentType: .plain,
            text: "You've set up mail!"
        )
        
        return reservation.save(on: req.db).flatMap{ req.application.sendMail(email, withCredentials: .default).map {
            return "Check your mail!"
        }
            
        }
    }
    
    app.post("lists"){req  -> EventLoopFuture<List> in
        let data = try req.content.decode(List.self)
        let list = List(idEvent: data.idEvent, nameList: data.nameList)
        return list.save(on: req.db).map{list}
    }
    
    
    app.post("findLists"){req  -> EventLoopFuture<[List]> in
        let data = try req.content.decode(List.self)
        return List.query(on: req.db).filter(\.$idEvent == data.idEvent).all()
    }
    
    app.post("findReservation"){req  -> EventLoopFuture<[Todo]> in
        let data = try req.content.decode(Todo.self)
        return Todo.query(on: req.db).filter(\.$id == data.id!).all()
    }
    
    
    try app.register(collection: TodoController())
    
    try app.register(collection: ListController())
    
}

