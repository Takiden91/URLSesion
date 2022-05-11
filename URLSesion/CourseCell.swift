//
//  CourseCell.swift
//  URLSesion
//
//  Created by mac on 09.05.2022.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseNameLable: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numberOfTests: UILabel!
    


    func configure(with course: Course) {
        courseNameLable.text = course.name
        numberOfLessons.text = "Number of lessons: \(course.number_of_lessons)"
        numberOfTests.text = "Number of tests: \(course.number_of_tests)"
        
        DispatchQueue.global().async {
            
            
            guard let imageUrl = URL(string: course.imageUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.courseImage.image = UIImage(data: imageData)
            }
            
            
        }

    }
    
    
}
