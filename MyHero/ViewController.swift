//
//  ViewController.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/20/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setting(){
        
        let fullWidth = self.view.frame.size.width
        let fullHeight = self.view.frame.size.height
        let halfWidth = fullWidth/2
        let halfHeight = fullHeight/2
        let oneOfThridWidth = fullWidth/3
        let oneOfThridHeight = fullHeight/3
        
        
        let background = UIImageView.init(frame: CGRect(x: 0, y: 0, width: fullWidth, height: fullHeight))
        background.image = UIImage(named: "travel.png")
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        
        let hero = UIImageView.init(frame: CGRect(x: (halfWidth)-fullWidth/6, y: (oneOfThridHeight)-fullHeight/6, width: fullWidth/3, height: fullHeight/3))
        hero.image = UIImage(named: "person.png")
        hero.contentMode = .scaleAspectFit
        view.addSubview(hero)
        
        let level_Label = UILabel.init(frame: CGRect(x: (halfWidth)-50, y: (hero.frame.origin.y)-50, width: 100, height: 50))
        level_Label.text = "Level : 1"
        view.addSubview(level_Label)
        
        let heath_Label = UILabel.init(frame: CGRect(x: 10, y: hero.frame.origin.y, width: fullWidth/4, height: 50))
        heath_Label.text = "Heath : 100"
        view.addSubview(heath_Label)
        
        let Attack_Label = UILabel.init(frame: CGRect(x: 10, y: hero.frame.origin.y+fullHeight/9, width: fullWidth/4, height: 50))
        Attack_Label.text = "Attack : 10"
        view.addSubview(Attack_Label)
        
        let strength_Label = UILabel.init(frame: CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y, width: fullWidth/4, height: 50))
        strength_Label.text = "Strength : 1.0"
        view.addSubview(strength_Label)
        
        let alige_Label = UILabel.init(frame: CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y+fullHeight/9, width: fullWidth/4, height: 50))
        alige_Label.text = "Alige : 1.0"
        view.addSubview(alige_Label)
        
        let crit_Label = UILabel.init(frame: CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y+fullHeight/9*2, width: fullWidth/4, height: 50))
        crit_Label.text = "Crit : 0.0"
        view.addSubview(crit_Label)
        
        
    }

}

