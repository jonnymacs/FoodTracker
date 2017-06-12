//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Jonny Mac on 2/26/17.
//  Copyright © 2017 Jonny Mac. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class Tests
    
    // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testMealInitSucceeds() {
        // zero rating
        let zeroRatingMeal = Meal(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest Positive Rating
        let positiveRatingMeal = Meal(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testMealInitFails() {
        // Negative rating
        let negativeRatingMeal = Meal(name: "Negative", photo: nil, rating: -3)
        XCTAssertNil(negativeRatingMeal)
        
        // Rating exceeds maximum
        let ratingTooHigh = Meal(name: "Too High", photo: nil, rating: 8)
        XCTAssertNil(ratingTooHigh)
        
        // Empty name
        let emptyNameMeal = Meal(name: "", photo: nil, rating: 2)
        XCTAssertNil(emptyNameMeal)
        
    }
}
