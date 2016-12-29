//
//  FMYWAlmanacPlatView.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/28.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit


class GreGorianCalView: UIView {
    var labelYearMonth:UILabel = {
       let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    var labelYearMonthEN:UILabel =  {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    var labelWeek:UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    var labelWeekEN:UILabel =  {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    var labelDay:UILabel =  {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    
    
    
    var almanac:FMYWAlmanacModel? {
        didSet{
            if almanac != nil {
                self.refreshUIItems()
            }
        }
    }
    
    
    func refreshUIItems() -> Void {
        let yangli   = self.almanac?.yangli as! NSString
//        var yinli       :NSString = self.almanac?.yinli
        
        // TODO 日期装换
        self.labelDay.text = yangli.components(separatedBy: "-").last
        self.labelYearMonth.text  = yangli as String
        self.labelYearMonthEN.text = yangli as String
        self.labelWeek.text = yangli as String
        self.labelWeekEN.text  = yangli as String
        
        self.labelDay.sizeToFit()
        self.labelWeek.sizeToFit()
        self.labelWeekEN.sizeToFit()
        self.labelYearMonth.sizeToFit()
        self.labelYearMonthEN.sizeToFit()
        
        self.labelDay.center = CGPoint(x: self.width * 0.5, y: self.height * 0.5)
        self.labelWeek.centerX          = self.width * 0.75
        self.labelWeekEN.centerX        = self.width * 0.75
        self.labelYearMonth.centerX     = self.width * 0.25
        self.labelYearMonthEN.centerX   = self.width * 0.25
        
        
        self.labelWeek.centerY          = self.height * 0.28
        self.labelWeekEN.centerY        = self.height * 0.75
        self.labelYearMonth.centerY     = self.height * 0.28
        self.labelYearMonthEN.centerY   = self.height * 0.75
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.labelDay)
        self.addSubview(self.labelWeek)
        self.addSubview(self.labelWeekEN)
        self.addSubview(self.labelYearMonth)
        self.addSubview(self.labelYearMonthEN)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class FMYWAlmanacPlatView: UIView , UITableViewDelegate, UITableViewDataSource{
//gregorian calendar
    var tableView:UITableView?
    var platGreGorianCal:GreGorianCalView = {
        let greGorin = GreGorianCalView(frame:.zero)
        return greGorin
    }()
    
    var almanacSectionHader:UIView = {
        let almanacSection = UIView(frame:.zero)
        return almanacSection
    }()
    var labelYinli:UILabel = {
        let label:UILabel = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    
    private var _almanacModel:FMYWAlmanacModel?
    var almanacModel:FMYWAlmanacModel? {
        get {
            return _almanacModel
        }
        set (newValue){
            _almanacModel = newValue
            if _almanacModel != nil {
                self.loadDataFrom(almanac: _almanacModel!)
            }
        }
    }
    
    
    func loadDataFrom(almanac:FMYWAlmanacModel) -> Void {
        self.platGreGorianCal.almanac = almanac
        self.labelYinli.text = almanac.yinli as? String
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUIItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUIItems() {
        
        self.tableView = UITableView.init(frame: self.bounds, style: .plain)
        self.tableView?.dataSource  = self
        self.tableView?.delegate    = self
//        self.tableView?.bounces     = false
    
        
        self.platGreGorianCal.width    = (self.tableView?.width)!
        self.platGreGorianCal.height   = 120
        self.platGreGorianCal.backgroundColor = .red
        
        
        
        self.almanacSectionHader.width  = (self.tableView?.width)!
        self.almanacSectionHader.height = 80
        self.almanacSectionHader.backgroundColor    = .yellow
        self.almanacSectionHader.addSubview(self.labelYinli)
        self.labelYinli.frame   = CGRect(x: 0, y: 0, width: (self.tableView?.width)!, height: 30)
        self.labelYinli.centerY = self.almanacSectionHader.height * 0.4
        self.addSubview(self.tableView!)
        
        self.tableView?.tableHeaderView = self.platGreGorianCal
        
        self.tableView?.reloadData()

    }
    
    
    // TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.almanacSectionHader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.almanacModel != nil ?  4 : 0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = NSStringFromClass(self.classForCoder)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        cell?.selectionStyle = .none
        switch indexPath.row {
        case 0:
            let item = self.almanacModel?.wuxing
            cell?.textLabel?.text = "五行:";
            cell?.detailTextLabel?.text = item as! String?
        case 1:
            let item = self.almanacModel?.chongsha
            cell?.textLabel?.text = "冲煞:";
            cell?.detailTextLabel?.text = item as! String?
        case 2:
            let item = self.almanacModel?.baiji
            cell?.textLabel?.text = "拜祭";
            cell?.detailTextLabel?.text = item as! String?
        case 3:
            let item = self.almanacModel?.jishen
            cell?.textLabel?.text = "祭神";
            cell?.detailTextLabel?.text = item as! String?
        default: break
        }
        
        
        return cell!
    }
    
    
}
