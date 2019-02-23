//
//  ViewController.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/20/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var heath_Value : Int = 100
    private var attack_Value : Int = 10
    private var strength_Value : Double = 1.0
    private var ailge_Value : Double = 1.0
    
    private var heath_Label = UILabel.init()
    private var attack_Label = UILabel.init()
    private var strength_Label = UILabel.init()
    private var ailge_Label = UILabel.init()
    private var crit_Label = UILabel.init()
    
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
        let oneOfFourth = fullWidth/4
        let oneOfFifty = fullWidth/5
        
        
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
        
        heath_Label.frame = CGRect(x: 10, y: hero.frame.origin.y, width: fullWidth/4, height: 50)
        heath_Label.text = "Heath : \(heath_Value)"
        view.addSubview(heath_Label)
        
        attack_Label.frame = CGRect(x: 10, y: hero.frame.origin.y+fullHeight/9, width: fullWidth/4, height: 50)
        attack_Label.text = "Attack : \(attack_Value)"
        view.addSubview(attack_Label)
        
        strength_Label.frame = CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y, width: fullWidth/4, height: 50)
        strength_Label.text = "Strength : \(strength_Value)"
        view.addSubview(strength_Label)
        
        ailge_Label.frame = CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y+fullHeight/9, width: fullWidth/4, height: 50)
        ailge_Label.text = "Alige : \(ailge_Value)"
        view.addSubview(ailge_Label)
        
        crit_Label.frame =  CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y+fullHeight/9*2, width: fullWidth/4, height: 50)
        crit_Label.text = "Crit : 0.0"
        view.addSubview(crit_Label)
        
        let heath_Button = UIButton(frame: CGRect(x: 0, y: crit_Label.frame.origin.y+50, width: oneOfFifty, height: 50))
        heath_Button.setTitle("Heath", for: .normal)
        heath_Button.setTitleColor(UIColor.black, for: .normal)
        heath_Button.backgroundColor = UIColor.lightGray
        heath_Button.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        heath_Button.tag = 1
        view.addSubview(heath_Button)
        
        let attack_Button = UIButton(frame: CGRect(x: oneOfFourth, y: crit_Label.frame.origin.y+50, width: oneOfFifty, height: 50))
        attack_Button.setTitle("Attack", for: .normal)
        attack_Button.setTitleColor(UIColor.black, for: .normal)
        attack_Button.backgroundColor = UIColor.lightGray
        attack_Button.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        attack_Button.tag = 2
        view.addSubview(attack_Button)
        
        let strength_Button = UIButton(frame: CGRect(x: 2*oneOfFourth, y: crit_Label.frame.origin.y+50, width: oneOfFifty, height: 50))
        strength_Button.setTitle("Strength", for: .normal)
        strength_Button.setTitleColor(UIColor.black, for: .normal)
        strength_Button.backgroundColor = UIColor.lightGray
        strength_Button.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        strength_Button.tag = 3
        view.addSubview(strength_Button)
        
        let Ailge_Button = UIButton(frame: CGRect(x: 3*oneOfFourth, y: crit_Label.frame.origin.y+50, width: oneOfFifty, height: 50))
        Ailge_Button.setTitle("Alige", for: .normal)
        Ailge_Button.setTitleColor(UIColor.black, for: .normal)
        Ailge_Button.backgroundColor = UIColor.lightGray
        Ailge_Button.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        Ailge_Button.tag = 4
        view.addSubview(Ailge_Button)
    }
    @objc func addValue(_ sender: UIButton){
        switch (sender.tag) {
        case 4 :  ailge_Value += 0.1; ailge_Label.text = "Ailge: "+String(format: "%.1f", ailge_Value)
        case 1 :  heath_Value += 10; heath_Label.text = "Heath : \(heath_Value)"
        case 3 :  strength_Value += 0.1; strength_Label.text = "Strength: "+String(format: "%.1f", strength_Value)
        case 2 :  attack_Value += 1; attack_Label.text = "Attack : \(attack_Value)"
        default:
            fatalError()
        }
        
    }
}

