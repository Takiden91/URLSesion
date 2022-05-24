//
//  Course.swift
//  URLSesion
//
//  Created by mac on 09.05.2022.
//


struct Course: Decodable {
    let name: String
    let link: String
    let imageUrl: String
    let numberOfLessons: Int
    let numberOfTests: Int
    
    init(dictCourse: [String: Any]) {
        name = dictCourse["name"] as? String ?? ""
        link = dictCourse["link"] as? String ?? ""
        imageUrl = dictCourse["imageUrl"] as? String ?? ""
        numberOfLessons = dictCourse["number_of_lessons"] as? Int ?? 0
        numberOfTests = dictCourse["number_of_tests"] as? Int ?? 0
    }
    
    static func getCourses(from jsonData: Any) -> [Course] {
        guard let jsonData = jsonData as? Array<[String: Any]> else { return [] }
        
//        var courses: [Course] = []
//        for dictCourse in jsonData {
//            let course = Course(dictCourse: dictCourse)
//            courses.append(course)
        
        
        return jsonData.compactMap{ Course(dictCourse: $0)}
        }
        
    
}

struct WebsiteDesription: Decodable {
    let courses: [Course]
    let websiteDescription: String
    let websiteName: String
}
