//
//  WineListVC.swift
//  Template
//
//  Created by Kasey Baughan on 5/22/17.
//  Copyright © 2017 Kasey Baughan. All rights reserved.
//

import UIKit
import SVProgressHUD

class WineListVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    class func create() -> WineListVC {
        let storyboard = UIStoryboard(name: "WineListVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WineListVC") as! WineListVC
        return vc
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var wines = [Wine]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "WineCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "wineCell")
        grabWines()
    }
    
    fileprivate func grabWines() {
        SVProgressHUD.show()
        WineAPI.getWines() {
            [weak weakSelf = self] wines, error in
            SVProgressHUD.dismiss()
            guard let wines = wines else {
                //error
                return
            }
            weakSelf?.wines = wines
        }
    }

}

extension WineListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wines.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wineCell", for: indexPath) as! WineCell
        cell.indexPath = indexPath
        cell.wine = wines[indexPath.row]
        return cell
    }
    
}

extension WineListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC(wine: wines[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
