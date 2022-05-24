//
//  MainViewController.swift
//  URLSesion
//
//  Created by mac on 09.05.2022.
//

import UIKit

enum UserActions: String, CaseIterable {
    case downLoadeImage = "Download Image"
    case exempleOne = "Exemple One"
    case exempleTwo = "Exemple Two"
    case exempleThree = "Exemple Three"
    case exempleFour = "Exemple Four"
    case ourCourses = "Our Courses"
    case postRequest = "Post Request"
    case ourCoursesAlamofire = "Our Courses Alamofire"
}



class MainViewController: UICollectionViewController {

    private let userActions = UserActions.allCases
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
        cell.userActionLable.text = userActions[indexPath.item].rawValue
        cell.layer.cornerRadius = 20
        return cell
    }

    
    // MARK: UICollectionViewDeligate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downLoadeImage:
            performSegue(withIdentifier: "ShowImage", sender: self)
        case .exempleOne:
            performSegue(withIdentifier: "ExempleOne", sender: self)
        case .exempleTwo:
            performSegue(withIdentifier: "ExempleTwo", sender: self)
        case .exempleThree:
            performSegue(withIdentifier: "ExempleThree", sender: self)
        case .exempleFour:
            performSegue(withIdentifier: "ExempleFour", sender: self)
        case .ourCourses:
            performSegue(withIdentifier: "OurCourses", sender: self)
        case .postRequest:
            postRequest()
        case .ourCoursesAlamofire:
            performSegue(withIdentifier: "OurCoursesAlamofire", sender: self)
        }
    }
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "ShowImage" {
            let corsesVC = segue.destination as! CoursesViewController
            switch segue.identifier {
            case "ExempleOne":
                corsesVC.fetchDataV1()
            case "ExempleTwo":
                corsesVC.fetchDataV2()
            case "ExempleThree":
                corsesVC.fetchDataV3()
            case "ExempleFour":
                corsesVC.fetchDataV4()
            case "OurCourses":
                corsesVC.fetchData()
            case "OurCoursesAlamofire":
                corsesVC.fetchDataWithAlamofire()
            default: break
            }
        }
    }
    


}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48 , height: 100)
    }
}
    
extension MainViewController {
    private func postRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let userData = [
            "course": "Networking",
            "lesson": "Get and Post"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, respons, _ in
            guard let respons = respons, let data = data else { return }
            print(respons)
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                    
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
}
