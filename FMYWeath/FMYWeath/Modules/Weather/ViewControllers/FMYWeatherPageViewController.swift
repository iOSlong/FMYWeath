//
//  FMYWeatherPageViewController.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/6.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit



class FMYWeatherPageViewController: UIPageViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate{

    var segmentView:CNSegmentView?

    var arrVCItems:NSMutableArray?       = NSMutableArray()

    var weatherPageHandle : ((_ pageIndex:Int) ->())?

    //MARK: 继承构造方法，实现翻页效果的设置
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .gray
        //MARK: setDelegate is important
        self.dataSource = self
        self.delegate = self

    }


    // MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let index = self.arrVCItems?.index(of: viewController)

        if index! > 0 {
            let beforeVC = self.arrVCItems?[index! - 1] as? FMYWeatherPageItemViewController

            return beforeVC
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let index = self.arrVCItems?.index(of: viewController)

        if index! < (self.arrVCItems?.count)! - 1 {
            let afterVC = self.arrVCItems?[index! + 1] as? FMYWeatherPageItemViewController

            return afterVC
        }

        return nil
    }



    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let objectVC = previousViewControllers[0]
        let index = self.arrVCItems?.index(of: objectVC)
        print("finished:",index ?? "")
        let objectCurrent = self.viewControllers?[0]
        let indexCurrent  = self.arrVCItems?.index(of: objectCurrent ?? "")
        self.segmentView?.selectedIndex = indexCurrent!
        if self.weatherPageHandle != nil {
            self.weatherPageHandle?(indexCurrent!)
        }
    }

}
