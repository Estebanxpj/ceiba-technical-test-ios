import ObjectMapper

struct Post: Mappable {
    typealias RealmDomainType = PostRealm

    var id: Int?
    var userId: Int?
    var title: String?
    var body: String?
    
    required init(map: Map){
        mapping(map: map)
    }

    func mapping(map: Map) {
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
    typealias EntityType = User
    
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: String = ""
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