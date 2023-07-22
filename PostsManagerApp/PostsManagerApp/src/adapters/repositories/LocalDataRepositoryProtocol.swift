//
//  LocalDataRepositoryProtocol.swift
//  PostsManagerApp
//
//  Created by Sebastian Betancur Salazar on 21/07/23.
//

import Foundation

struct Sorted {
    var key: String
    var ascending: Bool = true
}

protocol LocalDataRepositoryProtocol: class {
    associatedtype EntityType

    func save(item: EntityType) throws
    
    func save(items: [EntityType]) throws
    
    func fetch(predicate: NSPredicate?, sorted: Sorted?) -> [EntityType]
    
    func fetchAll() -> [EntityType]
}

protocol Entity {
    associatedtype RealmEntityType
    var realmObject: RealmEntityType { get }
}

protocol RealmEntity {
    associatedtype EntityType
    var entityObject: EntityType { get }
}
