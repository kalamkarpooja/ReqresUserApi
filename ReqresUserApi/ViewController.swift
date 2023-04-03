//
//  ViewController.swift
//  ReqresUserApi
//
//  Created by Mac on 02/04/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    var urlString : String?
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var users = [User]()
    @IBOutlet weak var userCollectionView: UICollectionView!
    override func viewDidLoad() {
        jsonDecoder()
        registerCells()
    }
    func registerCells(){
        let uinib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        self.userCollectionView.register(uinib, forCellWithReuseIdentifier: "UserCollectionViewCell")
    }
    func jsonDecoder(){
        urlString = "https://reqres.in/api/users?page=2"
        url = URL(string: urlString!)
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest!){data,response,error in
            print(String(data: data!, encoding: .utf8)!)
            let getJsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            let jsonObject = getJsonObject["data"] as! [[String : Any]]
            for eachDictionary in jsonObject{
                let userId = eachDictionary["id"] as! Int
                let userFName = eachDictionary["first_name"] as! String
                let userLName = eachDictionary["last_name"] as! String
                let userEmail = eachDictionary["email"] as! String
                let userAvatar = eachDictionary["avatar"] as! String
                let newUserObject = User(id: userId, email: userEmail, first_name: userFName, last_name: userLName, avatar: userAvatar)
                self.users.append(newUserObject)
                DispatchQueue.main.async {
                    self.userCollectionView.reloadData()
                }
            }
        }.resume()
    }
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.userCollectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        cell.name.text = users[indexPath.row].first_name! + " " + users[indexPath.row].last_name!
        cell.email.text = users[indexPath.row].email
        let urlstring = users[indexPath.row].avatar
        let url = URL(string: urlstring!)
        cell.img.sd_setImage(with: url)
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 4
        cell.layer.borderColor = .init(genericCMYKCyan: 2, magenta: 2, yellow: 1, black: 3, alpha: 3)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 230, height: 245)
    }

}
