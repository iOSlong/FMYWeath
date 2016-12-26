//
//  FMYWJokeDetailViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/25.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWJokeDetailViewController: FMYWViewController {

    var jokeItem:FMYWJokeModel? = nil
    var textViewJoke:UITextView? = nil


    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureJokeContent()
        // Do any additional setup after loading the view.
    }

    func configureJokeContent() {
        self.textViewJoke = UITextView(frame: CGRect(x: mySpanLeft, y: mySpanUp, width: myScreenW - 2 * mySpanLeft, height: self.view.height - myTabBarH))
        self.textViewJoke?.font = UIFont.systemFont(ofSize: 20)
        self.textViewJoke?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.textViewJoke?.textAlignment = .center
        self.view.addSubview(self.textViewJoke!)


        let jokeContent = self.jokeItem?.content as! String
        self.textViewJoke?.text = jokeContent
        self.textViewJoke?.sizeToFit()

        self.textViewJoke?.height = (self.textViewJoke?.height)! >= self.view.height - myTabBarH ? self.view.height - myTabBarH : (self.textViewJoke?.height)!
        
    }
}
