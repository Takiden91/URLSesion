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
    let number_of_lessons: Int
    let number_of_tests: Int
}

struct WebsiteDesription: Decodable {
    let courses: [Course]
    let websiteDescription: String
    let websiteName: String
}
