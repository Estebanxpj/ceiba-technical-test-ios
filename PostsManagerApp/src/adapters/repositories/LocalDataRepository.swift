import UIKit
import RealmSwift

class LocalDataRepository<T>: RealmServiceProtocol where T: RealmEntity, T: Object, T.EntityType: Entity {
    
    typealias RealmEntityType = T
    
    private let realm = try! Realm()
    
    func save(item: T.EntityType) throws {
        try realm.write {
            realm.add(item.realmObject as! T)
        }
    }
    
    func save(items: [T.EntityType]) throws {
        try realm.write {
            items.forEach {
                realm.add($0.realmObject as! T, update: .all)
            }
        }
    }
    
    func fetch(predicate: NSPredicate?, sorted: Sorted?) -> [T.EntityType] {
        var objects = realm.objects(T.self)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        return objects.compactMap {
            $0.entityObject
        }
    }
    
    func fetchAll() -> [T.EntityType] {
        return realm.objects(T.self).compactMap {
            $0.entityObject
        }
    }
}