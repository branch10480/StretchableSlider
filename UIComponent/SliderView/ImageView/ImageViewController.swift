//
//  ImageViewController.swift
//  UIComponent
//
//  Created by branch10480 on 2022/01/17.
//

import UIKit

public class ImageViewController: UIViewController {
  
  @IBOutlet weak private var imageView: UIImageView!
  
  private var image: UIImage?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    imageView.image = image
  }
  
  func configure(imageURL: String) {
    guard let url = URL(string: imageURL) else { return }
    do {
      let data = try Data(contentsOf: url)
      image = UIImage(data: data)
    } catch(let e) {
      print(e.localizedDescription)
    }
  }
  
}
