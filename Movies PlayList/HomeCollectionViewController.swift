//
//  HomeCollectionViewController.swift
//  Movies PlayList
//
//  Created by Mina on 05/02/2023.
//

import UIKit



class HomeCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout {

    
    var movies = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData { result in
            DispatchQueue.main.async {
                self.movies = result!.items
                self.collectionView.reloadData()
            }
        }
    }
   
   func fetchData( completion: @escaping (MyResult?) -> Void){
        let url = URL(string: "https://imdb-api.com/en/API/BoxOffice/k_5w7z14eo")
        guard let url = url else { return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { data, response, error in
            do {
                 var result : MyResult?
                 result = try JSONDecoder().decode(MyResult.self, from: data!)
                completion(result)
            }catch {
                completion(nil)
                print("error")
            }
            }
            task.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return movies.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! MovieCollectionViewCell
        
        cell.configure(with : movies[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width * 0.325, height: collectionView.frame.height * 0.325)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
    }
    
}
struct MyResult : Codable {
    var items : [Item]
    var errorMessage : String
}
struct Item : Codable {
    var id : String?
    var rank :String?
    var title :String?
    var image : String?
    var weekend : String?
    var gross :String?
    var weeks : String?
}
