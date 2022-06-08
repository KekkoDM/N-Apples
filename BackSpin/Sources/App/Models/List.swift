import Fluent
import Vapor

final class List: Model, Content {
    static let schema = "List"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "idEvent")
    var idEvent: String
    
    @Field(key: "nameList")
    var nameList: [String]

    
    init() { }

    init(idEvent: String, nameList: [String]) {
        self.idEvent = idEvent
        self.nameList = nameList
    }
    
//    init(id: UUID, username: String, password: String){
//        self.id = id
//        self.username = username
//        self.password = password
//    }
}
