//
//  MainPageViewController.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/13/23.
//

import UIKit

final class RocketsVC: UIPageViewController {

    var presenter: RocketsPresenterProtocol!
    private var rocketViewControllers = [UIViewController]()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setup()
        presenter.showRockets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}


extension RocketsVC {
    func setup() {
        dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}


// MARK: - UIPageViewControllerDataSource
extension RocketsVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = rocketViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        return index == 0 ? rocketViewControllers.last : rocketViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = rocketViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        if viewController == rocketViewControllers.last {
            return rocketViewControllers.first
        } else {
            return rocketViewControllers [index + 1]
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        rocketViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
}

extension RocketsVC {
    func setFirstViewController() {
        DispatchQueue.main.async { [weak self] in
            guard let vc = self?.rocketViewControllers[0] else { return }
            self?.setViewControllers(
                [vc],
                direction: .forward,
                animated: true
            )
        }

    }
}

// MARK: - MainViewProtocol
extension RocketsVC: RocketsViewProtocol {
    func showRockets() {
        rocketViewControllers = []
        presenter.rockets.forEach { rocket in
            DispatchQueue.main.async { [weak self, rocket] in
                let vc = self?.presenter.getRocketPage(rocket: rocket) ?? UIViewController()
                self?.rocketViewControllers.append(vc)
            }
        }
        setFirstViewController()
    }
}
