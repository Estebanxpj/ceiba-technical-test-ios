//
//  User.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import Foundation
import ObjectMapper
import RealmSwift

struct User: Mappable, Entity {
    typealias RealmEntityType = UserRealm

    var id: Int = 0
    var name: String = ""
    var email: String = ""
    var phone: String = ""

    public init(entity: RealmEntityType) {
        self.id = entity.id
        self.name = entity.name
        self.email = entity.email
        self.phone = entity.phone
    }

    init(map: ObjectMapper.Map){
        mapping(map: map)
    }

    mutating func mapping(map: ObjectMapper.Map) {
        id    <- map["id"]
        name  <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
    }

    var realmObject: UserRealm {
        return UserRealm(entity: self)
    }
}

class UserRealm: Object, RealmEntity {
    typealias EntityType = User
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""

    convenience required init(entity: EntityType) {
        self.init()
        self.id = entity.id
        self.name = entity.name
        self.email = entity.email
        self.phone = entity.phone
    }
    
    var entityObject: User {
        return User(entity: self)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
