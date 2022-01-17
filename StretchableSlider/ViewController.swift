//
//  ViewController.swift
//  StretchableSlider
//
//  Created by branch10480 on 2022/01/17.
//

import UIKit
import UIComponent

class ViewController: UIViewController {

  @IBOutlet weak var sliderArea: UIView!
  
  private let images: [String] = [
    "https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/9c42156e261a4d2282370c03fce43a0a/9c42156e261a4d2282370c03fce43a0a.jpeg",
    "https://www.eathappyproject.com/wp-content/uploads/2021/02/The-Most-Beautiful-Flowers-in-the-World-With-Name-and-Picture.jpg",
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    // Add SliderViewController
    let sliderVC = SliderViewController()
    sliderVC.set(images: images)
    sliderVC.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(sliderVC)
    sliderArea.addSubview(sliderVC.view)
    sliderVC.didMove(toParent: self)
    
    if let sView = sliderVC.view {
      NSLayoutConstraint.activate([
        sView.topAnchor.constraint(equalTo: sliderArea.topAnchor),
        sView.bottomAnchor.constraint(equalTo: sliderArea.bottomAnchor),
        sView.leadingAnchor.constraint(equalTo: sliderArea.leadingAnchor),
        sView.trailingAnchor.constraint(equalTo: sliderArea.trailingAnchor),
      ])
    }
    
  }

}

