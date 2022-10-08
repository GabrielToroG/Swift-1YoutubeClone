//
//  RootPageViewController.swift
//  Swift-1YoutubeClone
//
//  Created by Gtoro on 07-10-22.
//

import UIKit

protocol PageProtocol: AnyObject {
    func getCurrentPageView(index: Int)
}
// MARK: -


class PageViewController: UIPageViewController {
    
    // MARK: - Variable
    var subViewControllers = [UIViewController]() // PageViewController content
    var currentIndexPageView = 0
    weak var delegatePage: PageProtocol?

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setupViewController()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupViewController() {
        subViewControllers = [
            HomeViewController(),
            VideosViewController(),
            PlaylistsViewController(),
            ChannelsViewController(),
            AboutViewController()
        ]
        addTagToEachViewController()
        setViewControllersIntoPageFromIndex(index: 0, direction: .forward, animated: true)
    }
    
    fileprivate func addTagToEachViewController() {
        _ = subViewControllers.enumerated().map({$0.element.view.tag = $0.offset})
    }
    
    fileprivate func setViewControllersIntoPageFromIndex(index: Int, direction: NavigationDirection, animated: Bool) {
        setViewControllers([subViewControllers[index]], direction: direction, animated: animated)
    }
}

// MARK: -
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // El page view controller va a tener 5 páginas
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    // Cual será el control anterior
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = subViewControllers.firstIndex(of: viewController) ?? 0
        if index <= 0 { // Para que al devolverse en la página 0, no pase nada
            return nil
        }
        return subViewControllers[index-1]
    }
    
    // Cual será el control próximo
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = subViewControllers.firstIndex(of: viewController) ?? 0
        if index >= (subViewControllers.count-1) { // Para que al avanzar en la página 0, no pase nada
            return nil
        }
        return subViewControllers[index+1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let index = pageViewController.viewControllers?.first?.view.tag {
            currentIndexPageView = index
            delegatePage?.getCurrentPageView(index: index)
        }
    }
}
