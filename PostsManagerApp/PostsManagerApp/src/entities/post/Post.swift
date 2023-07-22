//
//  Post.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import Foundation
import ObjectMapper
import RealmSwift

struct Post: Mappable, Entity {
    typealias RealmEntityType = PostRealm

    var id: Int = 0
    var userId: Int = 0
    var title: String = ""
    var body: String = ""
    
    public init(entity: RealmEntityType){
        self.id = entity.id
        self.userId = entity.userId
        self.title = entity.title
        self.body = entity.body
    }
    
    init(map: ObjectMapper.Map){
        mapping(map: map)
    }

    mutating func mapping(map: ObjectMapper.Map) {
        id    <- map["id"]
        userId  <- map["userId"]
        title <- map["title"]
        body <- map["body"]
    }

    var realmObject: PostRealm {
        return PostRealm(entity: self)
    }
}

class PostRealm: Object, RealmEntity {
    
    typealias EntityType = Post
    
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""

    convenience required init(entity: EntityType) {
        self.init()
        self.id = entity.id
        self.userId = entity.userId
        self.title = entity.title
        self.body = entity.body
    }
    
    var entityObject: Post {
        return Post(entity: self)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
