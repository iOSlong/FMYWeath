//
//  FMYWDrivingExamSystemViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/18.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYWDrivingExamSystemViewController: FMYWViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var subject :String? = nil
    var model:String? = nil
    var testType:String? = "rand"


    var collectionView:UICollectionView? = nil
    var dataSourceArr:NSMutableArray? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.rootInfo != nil) {
            print(self.rootInfo ?? "empty rootInfo")
            self.subject = self.rootInfo?.object(forKey: "subject") as! String?
            self.model  = self.rootInfo?.object(forKey: "model") as! String?
            self.testType = self.rootInfo?.object(forKey: "testType") as! String?
        }


        self.configureCollectionView()

        self.netGetExamContent()
    }

    func configureCollectionView() -> Void {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: myScreenW, height: myScreenW * 0.6)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
    

        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: myScreenW, height: self.view.height - myNavBarH), collectionViewLayout: layout)
        self.collectionView?.delegate   = self
        self.collectionView?.dataSource = self

        self.collectionView?.register(FMYWExamCollectionCell.classForCoder(), forCellWithReuseIdentifier: "examCellIdentifier")

        self.view.addSubview(self.collectionView!)
    }


    // MARK: collectionView dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataSourceArr?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:FMYWExamCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "examCellIdentifier", for: indexPath) as? FMYWExamCollectionCell
        if cell == nil {
            cell = FMYWExamCollectionCell()
        }

        if indexPath.row < (self.dataSourceArr?.count)! {
            let item:FMYWExamModel? = self.dataSourceArr![indexPath.row] as? FMYWExamModel
            cell?.examModel = item
        }
        return cell!
    }

    
    // MARK: UICollectionViewDelegateFlowLayout delegate  call first  and only once
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < (self.dataSourceArr?.count)!
        {
            let item:FMYWExamModel? = self.dataSourceArr![indexPath.row] as? FMYWExamModel
            
            let cellH = FMYWExamCollectionCell.cellHeightFrom(examModel: item)
            
            return CGSize(width: myScreenW, height: cellH)
        }
        return CGSize.zero
    }



    @objc func reloadTableItems() -> Void {
        print(self.dataSourceArr ?? "")
        self.collectionView?.backgroundColor = colorMainBarBack
        self.collectionView?.reloadData()
    }


    func netGetExamContent() -> Void {
        if self.model == nil {
            self.model = ""
        }
        
//       testType 测试类型，rand：随机测试（随机100个题目），order：顺序测试（所选科目全部题目 1094）
        let param = ["key":apiKey_drivingLicence,
                     "subject":self.subject,
                     "model":self.model,
                     "testType":self.testType]
        self.view.bringSubview(toFront: self.activityIndicator!)
        self.startActivityIndicatorAnimation()

        _ =  FMYHTTPSessionManager(url: URL(string: url_drivingExam), configuration: nil).net("GET", parameters: param as NSDictionary?, success: { [weak self] (dataTask, object) in
            do {
                let responseDict =  try JSONSerialization.jsonObject(with: object as! Data, options:.mutableLeaves)
                let resultItem:NSArray? = (responseDict as! NSDictionary).object(forKey: "result") as? NSArray

                if resultItem != nil {
                    for index in 0...(resultItem?.count)!-1 {
                        let element = resultItem?[index] as! NSDictionary
                        let jokeItem = FMYWExamModel()
                        jokeItem.setValuesForKeys(element as! [String : Any])
                        print(jokeItem)
                        self?.dataSourceArr?.add(jokeItem)
                    }
                    self?.stopActivityIndicatorAnimation()
                    self?.perform(#selector(self?.reloadTableItems), on:  Thread.main, with: self, waitUntilDone: false)
                }

            } catch (let error) {
                self?.stopActivityIndicatorAnimation()
                let dataStr =  String(data: object as! Data, encoding: .utf8)
                print(error,dataStr ?? "")
            }
            
        }, failure:  { [weak self] (dataTask, error) in
            self?.stopActivityIndicatorAnimation()

        })
    }

    // 42~ 68    |    检查循环引用
    
    deinit {
        print("release all useless obj!" + self.classForCoder.description())
    }
    
}
