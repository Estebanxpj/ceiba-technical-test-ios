import ObjectMapper

struct User: Mappable {
    typealias RealmDomainType = UserRealm

    var id: Int?
    var name: String?
    var email: String?
    var phone: String?

    public init(entity: RealmDomainType) {
        self.id = entity.id
        self.name = entity.name
        self.email = entity.email
        self.phone = entity.phone
    }

    required init(map: Map){
        mapping(map: map)
    }

    func mapping(map: Map) {
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