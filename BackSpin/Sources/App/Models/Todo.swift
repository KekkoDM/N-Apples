import Fluent
import Vapor

final class Todo: Model, Content {

    static let schema = "Reservation"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String

    @Field(key: "surname")
    var surname: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "idEvent")
    var idEvent: String
    
    @Field(key: "nameList")
    var nameList: String
    
    @Field(key: "numFriends")
    var numFriends: Int

    init() { }

    init(name: String, surname: String, email: String, nameList: String, idEvent: String, numFriends: Int) {
        self.name = name
        self.surname = surname
        self.email = email
        self.nameList = nameList
        self.idEvent = idEvent
        self.numFriends = numFriends
    }
    
//    init(id: UUID, username: String, password: String){
//        self.id = id
//        self.username = username
//        self.password = password
//    }
}
