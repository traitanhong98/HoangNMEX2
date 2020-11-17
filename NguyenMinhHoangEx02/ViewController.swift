//
//  ViewController.swift
//  NguyenMinhHoangEx02
//
//  Created by Hoang on 11/12/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

enum SeeMode: Int {
    case minimize, maximize
}

class ViewController: UIViewController {
    
    @IBOutlet weak var pageSegmentView: UISegmentedControl!
    @IBOutlet weak var seeModeSwitch: UISwitch!
    @IBOutlet weak var pageViewController: UIView!
    let dataModel = DataModel.shared
    let disposeBag = DisposeBag()
    var pagerViewController: UIPageViewController?
    var viewControllers: [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        setupRx()
        dataModel.getListDebts()
        dataModel.getListCredistor()
    }
    func setupRx() {
        pageSegmentView.rx.selectedSegmentIndex.asObservable().subscribe(onNext: { [weak self] (index) in
            guard let self = self,
                let pagerViewController = self.pagerViewController,
                let viewController = self.viewControllerAtIndex(index) else {
                    return
            }
            pagerViewController.setViewControllers([viewController],
                                                   direction: .forward,
                                                   animated: true,
                                                   completion: nil)
        }).disposed(by: disposeBag)
        seeModeSwitch.rx.isOn.asObservable().subscribe(onNext: { [weak self] (isOn) in
            guard let self = self,
                let viewController = self.viewControllerAtIndex(self.pageSegmentView.selectedSegmentIndex) else {
                    return
            }
            let seeMode: SeeMode = isOn ? .minimize : .maximize
            if let credistorVC = viewController as? CreditorViewController {
                credistorVC.seeMode.accept(seeMode)
            } else if let debtorVC = viewController as? DebtorViewController {
                debtorVC.seeMode.accept(seeMode)
            }
        }).disposed(by: disposeBag)
    }
    func setupPageViewController() {
        pagerViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation:
            .horizontal, options: nil)
        guard let pagerViewController = self.pagerViewController else { return }
        pagerViewController.delegate = self
        viewControllers += [
            DebtorViewController(nibName: "BorrowingViewController", bundle: nil),
            CreditorViewController(nibName: "DeptViewController", bundle: nil),
        ]
        pagerViewController.setViewControllers([viewControllerAtIndex(0)!], direction: .forward,
                                               animated: true, completion: nil)
        pagerViewController.dataSource = self
        addChild(pagerViewController)
        pageViewController.addSubview(pagerViewController.view)
        pagerViewController.view.frame = pageViewController.bounds
        pagerViewController.didMove(toParent: self)
        
        for view in pagerViewController.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if viewControllers.count == 0 || index >= viewControllers.count {
            return nil
        }
        return viewControllers[index]
    }
    func indexOfViewController(_ viewController: UIViewController) -> Int {
        return viewControllers.firstIndex(of: viewController) ?? NSNotFound
    }
    
}
extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index) }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        if index == NSNotFound {
            return nil
        }
        index += 1
        if index == viewControllers.count {
            return nil
        }
        return viewControllerAtIndex(index)
    }
}
