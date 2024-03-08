//
//  ViewController.swift
//  iOSNewsApp
//
//  Created by Evita Sihombing on 27/02/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionVewCategory: UICollectionView!
    @IBOutlet weak var tableBerita: UITableView!
    @IBOutlet weak var headlineTableView: UITableView!
    
    var categories: [Category] = []
    let userDef = UserDefaults.standard
    
    var articles: [ArticleData] = []
    var headlineData: ArticleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionVewCategory.delegate = self
        collectionVewCategory.dataSource = self
        collectionVewCategory.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellCategory")
        
        userDef.set(0, forKey: "categoryIndex")
        getCategoryData()
        collectionVewCategory.reloadData()
        
        tableBerita.dataSource = self
        tableBerita.delegate = self
        
        headlineTableView.dataSource = self
        headlineTableView.delegate = self

        tableBerita.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cellBerita")
        headlineTableView.register(UINib(nibName: "HeadlineTableViewCell", bundle: nil), forCellReuseIdentifier: "headlineCell")
        loadNewsData()
    }
    
    func getCategoryData() {
        if let path = Bundle.main.path(forResource: "Category", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as? [String: Any] {
                        if let results = jsonDict["results"] as? [[String: Any]] {
                            for result in results {
                                if let id = result["id"] as? Int,
                                   let isActive = result["is_active"] as? Bool,
                                   let name = result["name"] as? String {
                                    let category = Category(id: id, isActive: isActive, name: name)
                                    categories.append(category)
                                }
                            }
                        }
                        let activeCategories = categories.filter({ $0.isActive })
                        print("Active Categories: ")
                        activeCategories.forEach { print($0.name) }
                    }
                } catch {
                    print("Error Parsing Json: \(error)")
                }
            }
        }
    }
    
    func loadNewsData() {
        guard let fileURL = Bundle.main.url(forResource: "News", withExtension: "json") else {
            print("JSON file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let newsArticle = try JSONDecoder().decode(NewsArticle.self, from: data)
            
            if let firstArticle = newsArticle.results.first {
                headlineData = firstArticle
            }
            
            articles = Array(newsArticle.results.dropFirst())
            
            headlineTableView.reloadData()
            tableBerita.reloadData()
            
            // parse data article in tableview
//            self.articles = newsArticle.results
            
        } catch {
            print("Error decoding JSON:", error)
        }
    }
    
    func loadHeadlineData() {
        headlineTableView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionVewCategory.dequeueReusableCell(withReuseIdentifier: "cellCategory", for: indexPath) as! CategoryCollectionViewCell
        
        
        let category = categories[indexPath.row]
        cell.labelCategory.text = category.name
        
        if userDef.integer(forKey: "categoryIndex") == indexPath.row {
            cell.backgroundCellView.layer.borderColor = UIColor.red.cgColor
        } else {
            cell.backgroundCellView.layer.borderColor = UIColor.black.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        userDef.set(indexPath.row, forKey: "categoryIndex")
        collectionView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == headlineTableView {
            return headlineData != nil ? 1 : 0
        } else {
            return articles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == headlineTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as! HeadlineTableViewCell
            cell.titleBeritaLabel.text = headlineData?.title
            cell.publisherLabel.text = headlineData?.source
            cell.timestampsLabel.text = headlineData?.pubDate
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellBerita", for: indexPath) as! NewsTableViewCell
            let article = articles[indexPath.row]
            cell.titleLabel.text = articles[indexPath.row].title
            cell.publisherLabel.text = articles[indexPath.row].source
            cell.timestampLabel.text = articles[indexPath.row].pubDate
   
            var priceText = ""
            for index in 0..<min(1, article.prices.count) {
                let price = article.prices[index]
                let chagePct = article.prices[index].changePct
                let percentageString = doubleToPercentage(chagePct)
                priceText += "\(price.code): (\(percentageString))"
                cell.BTCLabel.text = priceText
            }
            
            var priceTag = ""
            for indexData in 1..<min(2, article.prices.count) {
                let price = article.prices[indexData]
                let chagePct = article.prices[indexData].changePct
                let percentageString = doubleToPercentage(chagePct)
                priceTag += "\(price.code): (\(percentageString))"
                cell.BBCALabel.text = priceTag
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableBerita {
            let article = articles[indexPath.row]
            let link = article.link
            
            let detailsViewController = DetailsViewController()
            detailsViewController.articleLink = link
            present(detailsViewController, animated: true, completion: nil)
        } else {
            headlineTableView.reloadData()
            let article = headlineData?.link
            let link = article
            
            let detailsViewController = DetailsViewController()
            detailsViewController.articleLink = link
            present(detailsViewController, animated: true, completion: nil)
        }
    }
    
    func doubleToPercentage(_ value: Double) -> String {
        let percentageValue = String(format: "%.2f", value * 100)
        return "\(percentageValue)%"
    }
}


