//
//  Meal.swift
//  FoodTracker
//
//  Created by Jonny McAllister on 3/6/17.
//  Copyright © 2017 Jonny Mac. All rights reserved.
//

import UIKit

class Meal {
    //MARK Properties:
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
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
        
    }
}
