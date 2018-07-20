//
//  QuoteOfTheDayViewController.swift
//  HappyBird
//
//  Created by Thao Doan on 7/10/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class QuoteOfTheDayViewController: UIViewController {
    
    final var photoArray = Array(1...104).compactMap { "us\($0)" }
    override func viewDidLoad() {
        super.viewDidLoad()
      updateView()
     navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.rgb(0, 217, 141)]
    }
    func updateView() {
            let rand = Int(arc4random_uniform(UInt32(photoArray.count)))
            UIGraphicsBeginImageContext(view.frame.size)
            UIImage(named:photoArray[rand])?.draw(in: self.view.bounds)
            let imageToShow : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: imageToShow)
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            backgroundView.contentMode = .scaleAspectFit
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
        fetchQuote()
       
    }
    func fetchQuote() {
//        APIService.shared.fetchQuote { (susscess) in
//            guard let susscess = susscess else {return}
//            guard let quote = susscess.first?.quote,
//                  let title = susscess.first?.title,
//                  let author = susscess.first?.author else {return}
//                DispatchQueue.main.async {
//                self.oneDayAQuote.text = quote
//                self.oneDayAQuote.textColor = .white
//                self.titleLabel.text = title.capitalized
//                self.authorLabel.text = "\(author.capitalized)"
//            }
//        }
        APIService.shared.fetchRanDomJoke { (joke) in
            guard let joke = joke else {return}
            DispatchQueue.main.async {
            self.oneDayAQuote.text = joke.joke
            self.titleLabel.text = "Random Joke"
            self.oneDayAQuote.textColor = .white 
            }
        }
    }
   
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var oneDayAQuote: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UITableViewDelegate Methods
    @IBAction func unwindHome(segue: UIStoryboardSegue) {
        
        }
   
    @IBAction func updateHomeContentInfo(seuge: UIStoryboardSegue) {
        let sourViewController = seuge.source as! HomeCategoryListTableViewController
        
        
        
    }
}
