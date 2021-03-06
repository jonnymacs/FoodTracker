//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Jonny Mac on 2/27/17.
//  Copyright © 2017 Jonny Mac. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        // didSet here updates the UI when the user changes the rating
        // pretty rad
        didSet { updateButtonSelectionStates() }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        // didSet - here allows the buttons to resize in the dev storyboard
        // when they are changed from the attributes control in xcode
        didSet { setupButtons() }
    }
    @IBInspectable var starCount: Int = 5 { didSet { setupButtons() } }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    //MARK: Button Action
    func ratingButtonTapped(button: UIButton) {     
        //guard let index = ratingButtons.index(of: button) else {
        //    fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        //}
        let index = ratingButtons.index(of: button)!
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        if selectedRating == rating {
            // If the selected star represents the current rating, 
            // reset the rating to 0
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar",
                                      in: bundle,
                                      compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            // Create the button
            let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Add the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)),
                                      for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for(index, button) in ratingButtons.enumerated() {
            // Buttons less than the rating are highlighted
            button.isSelected = index < rating
        }
    }
}
