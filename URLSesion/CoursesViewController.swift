//
//  CoursesViewControllerTableViewController.swift
//  URLSesion
//
//  Created by mac on 09.05.2022.
//

import UIKit
import Alamofire


class CoursesViewController: UITableViewController {
    private var courses: [Course] = []
    
    private let jsonUrlOne = "http://swiftbook.ru//wp-content/uploads/api/api_course"
    private let jsonUrlTwo = "http://swiftbook.ru//wp-content/uploads/api/api_courses"
    private let jsonUrlThree = "http://swiftbook.ru//wp-content/uploads/api/api_website_description"
    private let jsonUrlFour = "http://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
    


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CourseCell
        
        let course = courses[indexPath.row]
        cell.configure(with: course)
        

        return cell
    }
    
    
    //MARK: TableViewDelegate
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    
    
    func fetchDataV1() {
        guard let url = URL(string: jsonUrlOne) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
            let course = try JSONDecoder().decode(Course.self, from: data)
                print(course.name)
                print(course.imageUrl)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchDataV2() {
        guard let url = URL(string: jsonUrlTwo) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
            let course = try JSONDecoder().decode([Course].self, from: data)
                print(course)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchDataV3() {
        guard let url = URL(string: jsonUrlThree) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
            let websiteDescription = try JSONDecoder().decode(WebsiteDesription.self, from: data)
                print(websiteDescription.courses)
                print(websiteDescription.websiteDescription)
                print(websiteDescription.websiteName)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchDataV4() {
        guard let url = URL(string: jsonUrlFour) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
            let websiteDescription = try JSONDecoder().decode(WebsiteDesription.self, from: data)
                print(websiteDescription.courses)
                print(websiteDescription.websiteDescription)
                print(websiteDescription.websiteName)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchData() {
        guard let url = URL(string: jsonUrlTwo) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decoder.decode([Course].self, from: data)
               
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchDataWithAlamofire() {
        guard let url = URL(string: jsonUrlTwo) else { return }
        
        
        
        AF.request(url).validate().responseJSON { dataResponse in
            
            switch dataResponse.result {
            case .success(let value):
                self.courses = Course.getCourses(from: value)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
            
        }
        
    }
}
