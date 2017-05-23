//
//  DetailVC.swift
//  Template
//
//  Created by Kasey Baughan on 5/22/17.
//  Copyright © 2017 Kasey Baughan. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    //MARK: - Vars and Inits
    let wine: Wine
    
    init(wine: Wine) {
        self.wine = wine
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Outlets
//    lazy var textField: UITextField! = {
//        let view = UITextField()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.borderStyle = .RoundedRect
//        view.textAlignment = .Center
//        
//        return view
//    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }

}

//MARK: - Build UI
extension DetailVC {
    
    fileprivate func buildUI() {
        //main descriptions
        let nameLabel = UILabel(frame: CGRect(x: 60, y: 20, width: view.bounds.width - 70, height: 200))
        nameLabel.text = wine.name
        let categoryLabel = UILabel(frame: CGRect(x: 60, y: 240, width: view.bounds.width - 70, height: 50))
        categoryLabel.text = "Special Kind"//hard coded, fix
        let image = UIImage(named: "wine.jpg")
        let imageView = UIImageView(frame: CGRect(x: -30, y: 20, width: 80, height: 2000))
        imageView.image = image
        let priceLabel = UILabel(frame: CGRect(x: 60,
                                               y: categoryLabel.frame.origin.y + categoryLabel.frame.height + 10,
                                               width: view.bounds.width - 70,
                                               height: 50))
        priceLabel.text = wine.price.currency
        let ozLabel = UILabel(frame: CGRect(x: 60,
                                            y: priceLabel.frame.origin.y + priceLabel.frame.height + 10,
                                            width: view.bounds.width - 70,
                                            height: 40))
        ozLabel.text = wine.oz
        //separation
        let separator = UIView(frame: CGRect(x: 60,
                                             y: ozLabel.frame.origin.y + ozLabel.frame.height + 10,
                                             width: view.bounds.width - 10,
                                             height: 2))
        separator.backgroundColor = UIColor.gray
        //product attribs begin
        let labels: [UILabel] = wine.attributeList.map() {
            WineAttributeLabel(text: $0 + ": " + $1)
        }
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.frame = CGRect(x: 60,
                                 y: separator.frame.origin.y + separator.frame.height + 10,
                                 width: stackView.frame.width,
                                 height: stackView.frame.height)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //add everything in
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 2000)
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(separator)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }
    
}

