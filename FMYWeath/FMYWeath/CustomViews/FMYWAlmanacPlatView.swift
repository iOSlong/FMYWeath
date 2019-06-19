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
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: myFont.font_big01.rawValue)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    var labelYearMonthEN:UILabel =  {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: myFont.font_big01.rawValue)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    var labelWeek:UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: myFont.font_big01.rawValue)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    var labelWeekEN:UILabel =  {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: myFont.font_big01.rawValue)
        label.sizeThatFits(CGSize(width: myScreenW*0.5, height: 20))
        return label
    }()
    
    var labelDay:UILabel =  {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: myFont.font_bigest.rawValue)
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
        let yangli   = self.almanac?.yangli as! String
//        var yinli       :NSString = self.almanac?.yinli
        
        // TODO 日期装换
        let timeInterval = timeInteger(timeStr: yangli, formateStr: .TFy_M_d)
        let day:String = timeShow(time: timeInterval, formateStr: .TFd2, localId: nil)
        let ymVCN:String = timeShow(time: timeInterval, formateStr: .TFy_M_d, localId: .zh_CN)
        let ymVEN:String = timeShow(time: timeInterval, formateStr: .TFM4, localId: .en_US_POSIX)
        let w_EN:String = timeShow(time: timeInterval, formateStr: .TFE4, localId: .en_US_POSIX)
        let w_CN:String = timeShow(time: timeInterval, formateStr: .TFE4, localId: .zh_CN)

        self.labelDay.text = day
        self.labelYearMonth.text  = ymVCN
        self.labelYearMonthEN.text = ymVEN
        self.labelWeek.text = w_CN
        self.labelWeekEN.text  = w_EN
        
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

@objc protocol AlmanacPlatViewDelegate {
    @objc optional
    func almanacPlatEvent(almanacModel:FMYWAlmanacModel?) -> Void
}



class FMYWAlmanacPlatView: UIView , UITableViewDelegate, UITableViewDataSource{
//gregorian calendar
    var delegate:AlmanacPlatViewDelegate? = nil
    var tableView:UITableView?
    var platGreGorianCal:GreGorianCalView = {
        let greGorin = GreGorianCalView(frame:.zero)
        return greGorin
    }()
    
    var almanacSectionHader:UIView = {
        let almanacSection = UIView(frame:.zero)
        almanacSection.backgroundColor = colorMainBack
        return almanacSection
    }()
    
    var labelYinli:UILabel = {
        let label:UILabel = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var btnShiChen:UIButton = {
        let btn:UIButton = UIButton(frame: .zero)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: myFont.font_min02.rawValue)
        btn.setTitleColor(.purple, for: .normal)
        return btn
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
        self.btnShiChen.setTitle("十二时辰 >>", for: .normal)

        self.tableView?.reloadData()
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
        self.tableView?.separatorStyle = .none
        self.tableView?.backgroundColor = .clear
//        self.tableView?.bounces     = false
    
        
        self.platGreGorianCal.width    = (self.tableView?.width)!
        self.platGreGorianCal.height   = 120
//        self.platGreGorianCal.backgroundColor = .red
        
        
        
        self.almanacSectionHader.width  = ((self.tableView?.width)! - 80.0)
        self.almanacSectionHader.height = 40
//        self.almanacSectionHader.backgroundColor    = .yellow
        self.almanacSectionHader.addSubview(self.labelYinli)
        self.almanacSectionHader.addSubview(self.btnShiChen)
        self.labelYinli.frame   = CGRect(x: 0, y: 0, width: (self.tableView?.width)!, height: 30)
        self.labelYinli.centerY = self.almanacSectionHader.height * 0.5
//        self.labelYinli.backgroundColor = .purple
        self.addSubview(self.tableView!)
        self.btnShiChen.size  = CGSize(width: 80, height: 40)
        self.btnShiChen.right = (self.tableView?.width)! - mySpanH
        self.btnShiChen.centerY = self.almanacSectionHader.height * 0.5
        self.btnShiChen.addTarget(self, action: #selector(btnShiChenClick(_:)), for: .touchUpInside)
        
        self.tableView?.tableHeaderView = self.platGreGorianCal
        
        self.tableView?.reloadData()

    }
    
    @objc func btnShiChenClick(_:UIButton) -> Void {
            self.delegate?.almanacPlatEvent?(almanacModel: self.almanacModel)
    }
    
    // TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.almanacSectionHader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.almanacSectionHader.height
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.almanacModel != nil ?  7 : 0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = NSStringFromClass(self.classForCoder)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        cell?.selectionStyle = .none
        cell?.backgroundColor = .clear
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        
        cell?.textLabel?.textColor = .white;
        cell?.detailTextLabel?.textColor = .white;

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
        case 4:
            let item = self.almanacModel?.xiongshen
            cell?.textLabel?.text = "凶神";
            cell?.detailTextLabel?.text = item as! String?
        case 5:
            let item = self.almanacModel?.yi
            cell?.textLabel?.text = "宜";
            cell?.detailTextLabel?.text = item as! String?
        case 6:
            let item = self.almanacModel?.ji
            cell?.textLabel?.text = "忌";
            cell?.detailTextLabel?.text = item as! String?
        default: break
        }
        
        
        return cell!
    }
    
    
}
