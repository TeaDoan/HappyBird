//
//  RamdonQuotesViewController.swift
//  HappyBird
//
//  Created by Thao Doan on 7/12/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

struct Contants {
    static let cellIdentifier = "randomQuote"
}

class RandomFunQuoteTableViewController : UITableViewController {
    
    var photoArray = Array(1...104).compactMap {"us\($0)"}
    var randomQuote : [RandomQuotes] = []
    var imageDictionary = [IndexPath : UIImage]()
    var randomImageIndecies = Array(0...103)
//    var postShown = [Bool](repeating: false, count: 4 )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.shared.fetchRandomFunQuote { (quote) in
            if let quote = quote {
                DispatchQueue.main.async {
                    self.randomQuote = quote
                     self.tableView.reloadData()
                }
            }
            APIService.shared.fetchRandomQuotes(completion: { (quote) in
                if let quote = quote {
                    DispatchQueue.main.async {
                        self.randomQuote = quote
                        self.tableView.reloadData()
                    }
                }
            })
        }
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.rgb(0, 217, 141)]

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return randomQuote.count
        }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Contants.cellIdentifier, for: indexPath) as! QuoteTableViewCell
        cell.delegate = RandomQuoteController.shared
        let quote = randomQuote[indexPath.row]
        self.tableView.separatorStyle = .none
        if let image = imageDictionary[indexPath] {
            cell.backgroundView = UIImageView(image: image)
        } else {
            let rand = Int(arc4random_uniform(UInt32(randomImageIndecies.count - 1)))
            UIGraphicsBeginImageContext(cell.frame.size)
            UIImage(named:photoArray[randomImageIndecies[rand]])?.draw(in: (cell.contentView.bounds))
            randomImageIndecies.remove(at: rand)
            if randomImageIndecies.count == 0 {
                randomImageIndecies = Array(0...photoArray.count)
            }
            let imageToShow : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            imageDictionary[indexPath] = imageToShow
            cell.backgroundView = UIImageView(image: imageToShow)
            cell.backgroundView?.contentMode = .scaleAspectFit
        }
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 10
//        cell.layer.cornerRadius = 10
//        cell.clipsToBounds = true
        cell.quote = quote
        cell.quoteLabel.text = quote.quote
        cell.quoteLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cell.authorLabel.text = quote.author
        cell.favorriteButton.contentMode = .scaleAspectFit
        
         return cell
     }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // IF you want this animation uncomment these lines.
let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform
        //Define the final state (After the animation)
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
    }
}
