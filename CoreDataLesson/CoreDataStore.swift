//
//  CoreDataStore.swift
//  RedditApp
//
//  Created by Kristina Šlekytė on 08/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStore: NSObject {
    var favorites: [NSManagedObject] = []
    
    func save(_ item: Reddit) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Favorite",
                                       in: managedContext)!
        let favorite = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
        favorite.setValue(item.smileTypes, forKeyPath: "smileTypes")
        favorite.setValue(item.count, forKeyPath: "count")
        do {
            try managedContext.save()
            favorites.append(favorite)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func delete(_ item: Reddit) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        guard let title = item.smileTypes else {
             return
        }
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS %@", title)
        
        do {
            favorites = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            if (favorites.count>0) {
               managedContext.delete(favorites.first!)
            }
        } catch {
            print("Error.")
        }
    }
    
    func fetchData() -> [Reddit] {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
        var RedditArray = [Reddit]()
        do {
            favorites = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for favorite in favorites {
            let reddit = Reddit()
            reddit.smileTypes = favorite.value(forKey: "smileTypes") as! String?
            reddit.count = favorite.value(forKey: "count") as! Int?
            RedditArray.append(reddit)
        }
        return RedditArray
    }
    
    func searchData(_ title: String) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        request.predicate = NSPredicate(format: "title CONTAINS %@", title)
        do {
            favorites = try managedContext.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
        } catch {
            print("Error.")
        }
        return favorites.count>0
    }
    
//    func getManagedContext() -> NSManagedObjectContext {
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return nil
//        }
//        return appDelegate.persistentContainer.viewContext
//    }
    
//    class func someMethod(closure: () -> Void) {
//        // secret stuff
//    }
}
