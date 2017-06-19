//
//  Meal.swift
//  FoodTracker
//
//  Created by Jonny McAllister on 3/6/17.
//  Copyright © 2017 Jonny Mac. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    //MARK Properties:
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    struct PropertyKey {
      static let name = "name"
      static let photo = "photo"
      static let rating = "rating"
    }
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // Require name
        guard !name.isEmpty else {
          return nil
        }
        
        // Ensure rating is between 0 and 5
        guard (0...5 ~= rating) else {
          return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        // unecessary but best practice
        super.init()

    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Name is required. Fail if we can't decode it
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name of the stored Meal obejct", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // call designated initializer
        self.init(name: name, photo: photo, rating: rating)
    }
    
}
