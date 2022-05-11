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
    

