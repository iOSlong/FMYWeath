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


    var collectionView:UICollectionView? = nil
    var dataSourceArr:NSMutableArray? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.rootInfo != nil) {
            print(self.rootInfo ?? "empty rootInfo")
            self.subject = self.rootInfo?.object(forKey: "subject") as! String?
            self.model  = self.rootInfo?.object(forKey: "model") as! String?
        }


        self.configureCollectionView()

        self.netGetExamContent()
        self.startActivityIndicatorAnimation()
    }

    func configureCollectionView() -> Void {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: myScreenW, height: myScreenW * 0.6)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        

        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: myScreenW, height: self.view.height - myNavBarH), collectionViewLayout: layout)
        self.collectionView?.backgroundColor = .clear
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
            let item:FMYWExamModel = self.dataSourceArr![indexPath.row] as! FMYWExamModel
            cell?.examModel = item
        }
        return cell!
    }

    // MARK: UICollectionViewDelegateFlowLayout delegate  call first
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: myScreenW, height: CGFloat(arc4random()%100 + 100) + myScreenW * 0.38)
    }



    func reloadTableItems() -> Void {
        print(self.dataSourceArr ?? "")
        self.collectionView?.reloadData()
    }


    func netGetExamContent() -> Void {
        if self.model == nil {
            self.model = ""
        }
        let param = ["key":apiKey_drivingLicence,
                     "subject":self.subject,
                     "model":self.model]
        _ =  FMYHTTPSessionManager(url: URL(string: url_drivingExam), configuration: nil).net("GET", parameters: param as NSDictionary?, success: { [unowned self](dataTask, object) in
            self.stopActivityIndicatorAnimation()

            do {
                let responseDict =  try JSONSerialization.jsonObject(with: object as! Data, options:.mutableLeaves)
                let resultItem:NSArray? = (responseDict as! NSDictionary).object(forKey: "result") as? NSArray

                if resultItem != nil {
                    for index in 0...(resultItem?.count)!-1 {
                        let element = resultItem?[index] as! NSDictionary
                        let jokeItem = FMYWExamModel()
                        jokeItem.setValuesForKeys(element as! [String : Any])
                        print(jokeItem)
                        self.dataSourceArr?.add(jokeItem)
                    }
                    self.perform(#selector(self.reloadTableItems), on:  Thread.main, with: self, waitUntilDone: false)
                }

            } catch (let error) {
                let dataStr =  String(data: object as! Data, encoding: .utf8)
                print(error,dataStr ?? "")
            }
            
        }, failure:  { (dataTask, error) in
            self.stopActivityIndicatorAnimation()

        })
    }

}