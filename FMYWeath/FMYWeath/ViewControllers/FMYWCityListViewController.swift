//
//  FMYWCityListViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/20.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWCityListViewController: FMYWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = colorMainBack
        
        
        let mybtn = FMYButton.fmyButtonWith(frame: CGRect.init(x: 100, y: 100, width: 40, height: 40), imgNormal: "market_unselected_button", imgSelected: "market_selected_button", target: self, action: #selector(fmybuttonClick(btn :)), circleLayer: false)
        
//        mybtn.backgroundColor = UIColor.yellow
        
        self.view.addSubview(mybtn)
        
        
        
        let checkItemView = FMYWCheckItemView.init(frame: CGRect.init(x: 100, y: 200, width: 200, height: 50))
        checkItemView.itemTitle = "会感知、相应和学习的流程与决策";
        self.view.addSubview(checkItemView)
        
        checkItemView.fmycheckItem { [unowned self] (checkState) in
            print(checkState)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func fmybuttonClick(btn : UIButton) {
        btn.isSelected = !btn.isSelected
        
        print("click")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
