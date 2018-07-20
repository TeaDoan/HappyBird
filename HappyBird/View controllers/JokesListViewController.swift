//
//  JokesListViewController.swift
//  HappyBird
//
//  Created by Thao Doan on 7/14/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit


class JokesListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    struct Contants {
        static let jokeCellIdentifier = "jokeCell"
    }
    
    private var jokes = [Value]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJokes()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.rgb(0, 217, 141)]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchJokes()
    }
    
    func fetchJokes() {
        APIService.shared.fetchJokes { (values) in
            guard let jokes = values else {return}
            DispatchQueue.main.async {
                self.jokes = jokes
                self.tableView.reloadData()
            }
           
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Contants.jokeCellIdentifier, for: indexPath) as! JokesListTableViewCell
        let joke = jokes[indexPath.row]
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 180))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 18.0
        whiteRoundedView.layer.masksToBounds = true
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
//        whiteRoundedView.backgroundColor = UIColor.white
        whiteRoundedView.applyGradient(colours:[UIColor.rgb(0, 217, 141),UIColor.rgb(0, 191, 124)] )
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        cell.jokeLabel.text = joke.joke
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map {$0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}

