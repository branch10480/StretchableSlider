//
//  SliderViewController.swift
//  UIComponent
//
//  Created by branch10480 on 2022/01/17.
//

import UIKit

public class SliderViewController: UIViewController {
  typealias Item = (vc: ImageViewController, imageURL: String)
  
  private var images: [String] = []
  private var pageVC: UIPageViewController!
  private var vcs: [ImageViewController] = []
  
  public var didPageChange: ((Int) -> ())?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    // Add PageViewController
    addChild(pageVC)
    pageVC.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(pageVC.view)
    pageVC.didMove(toParent: self)
    if let v = pageVC.view {
      NSLayoutConstraint.activate([
        v.topAnchor.constraint(equalTo: view.topAnchor),
        v.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        v.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        v.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      ])
    }
    pageVC.delegate = self
    pageVC.dataSource = self
    
    configurePages()
  }
  
  private func configurePages() {
    var newVCs: [ImageViewController] = []
    // Set pages
    for imageURL in images {
      let vc = ImageViewController(nibName: "ImageViewController", bundle: Bundle(for: ImageViewController.self))
      vc.configure(imageURL: imageURL)
      newVCs.append(vc)
    }
    let initialVC = [newVCs.first].compactMap{ $0 }
    if !initialVC.isEmpty {
      pageVC.setViewControllers(initialVC, direction: .forward, animated: false, completion: nil)
    }
    vcs = newVCs
  }
  
  public func set(images: [String]) {
    self.images = images
  }
  
  public func setIndex(_ newIndex: Int, animated: Bool = true) {
    guard newIndex < vcs.count, newIndex >= 0 else { return }
    guard let currentIndex = currentIndex else {
      let vc = vcs[newIndex]
      pageVC.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
      return
    }
    guard newIndex != currentIndex else { return }
    let direction: UIPageViewController.NavigationDirection
    if newIndex < currentIndex {
      direction = .reverse
    } else {
      direction = .forward
    }
    let vc = vcs[newIndex]
    pageVC.setViewControllers([vc], direction: direction, animated: animated, completion: nil)
  }
  
  var currentIndex: Int? {
    guard let vc = pageVC.viewControllers?.first as? ImageViewController,
          let index = vcs.firstIndex(of: vc) else {
      return nil
    }
    return index
  }
  
}

extension SliderViewController: UIPageViewControllerDataSource {
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = vcs.firstIndex(where: { vc in
      vc == viewController
    }), vcs.count > 1 else {
      return nil
    }
    
    if index - 1 >= 0 {
      return vcs[index - 1]
    } else {
      return vcs.last
    }
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = vcs.firstIndex(where: { vc in
      vc == viewController
    }), vcs.count > 1 else {
      return nil
    }
    
    if index + 1 < vcs.count {
      return vcs[index + 1]
    } else {
      return vcs.first
    }
  }
  
}

extension SliderViewController: UIPageViewControllerDelegate {
  public func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    guard completed else { return }
    guard let newIndex = currentIndex else { return }
    didPageChange?(newIndex)
  }
}
