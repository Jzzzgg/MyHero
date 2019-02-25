//
//  ViewController.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/20/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {
    
    private var heath_Value : Int = 100
    private var attack_Value : Int = 10
    private var strength_Value : Double = 1.0
    private var ailge_Value : Double = 1.0
    private var level_Value : Int = 1
    private var upgrade_chance : Int = 5
    private var time = 60
    private var timer = Timer()
    
    private var small_Button = UIButton.init()
    private var heath_Label = UILabel.init()
    private var attack_Label = UILabel.init()
    private var strength_Label = UILabel.init()
    private var ailge_Label = UILabel.init()
    private var crit_Label = UILabel.init()
    private var level_Label = UILabel.init()
    private var chance_Label = UILabel.init()
    
    
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
        
        level_Label.frame = CGRect(x: (halfWidth)-50, y: (hero.frame.origin.y)-50, width: 100, height: 50)
        level_Label.text = "Level : \(level_Value)"
        view.addSubview(level_Label)
        
        heath_Label.frame = CGRect(x: 10, y: hero.frame.origin.y, width: fullWidth/4, height: 50)
        heath_Label.text = "Heath : \(heath_Value)"
        view.addSubview(heath_Label)
        
        attack_Label.frame = CGRect(x: 10, y: hero.frame.origin.y+fullHeight/9, width: fullWidth/4, height: 50)
        attack_Label.text = "Attack : \(attack_Value)"
        view.addSubview(attack_Label)
        
        
        chance_Label.frame = CGRect(x: 10, y: hero.frame.origin.y+fullHeight/9*2, width: oneOfFourth, height: 50)
        chance_Label.text = "Chance : \(upgrade_chance)"
        view.addSubview(chance_Label)
        
        
        strength_Label.frame = CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y, width: fullWidth/4, height: 50)
        strength_Label.text = "Strength : \(strength_Value)"
        view.addSubview(strength_Label)
        
        ailge_Label.frame = CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y+fullHeight/9, width: fullWidth/4, height: 50)
        ailge_Label.text = "Alige : \(ailge_Value)"
        view.addSubview(ailge_Label)
        
        crit_Label.frame =  CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y+fullHeight/9*2, width: fullWidth/4, height: 50)
        crit_Label.text = "Crit : 0.0"
        view.addSubview(crit_Label)
        
        let heath_Button = UIButton(frame: CGRect(x: oneOfFifty/5, y: crit_Label.frame.origin.y+50, width: oneOfFifty, height: 50))
        heath_Button.setTitle("Heath", for: .normal)
        heath_Button.setTitleColor(UIColor.black, for: .normal)
        heath_Button.backgroundColor = UIColor.brown
        heath_Button.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        heath_Button.tag = 1
        view.addSubview(heath_Button)
        
        let attack_Button = UIButton(frame: CGRect(x: heath_Button.frame.origin.x+(oneOfFifty)+oneOfFifty/5, y: crit_Label.frame.origin.y+50, width: oneOfFifty, height: 50))
        attack_Button.setTitle("Attack", for: .normal)
        attack_Button.setTitleColor(UIColor.black, for: .normal)
        attack_Button.backgroundColor = UIColor.brown
        attack_Button.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        attack_Button.tag = 2
        view.addSubview(attack_Button)
        
        let strength_Button = UIButton(frame: CGRect(x: attack_Button.frame.origin.x+(oneOfFifty)+oneOfFifty/5, y: crit_Label.frame.origin.y+50, width: oneOfFifty, height: 50))
        strength_Button.setTitle("Strength", for: .normal)
        strength_Button.setTitleColor(UIColor.black, for: .normal)
        strength_Button.backgroundColor = UIColor.brown
        strength_Button.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        strength_Button.tag = 3
        view.addSubview(strength_Button)
        
        let Ailge_Button = UIButton(frame: CGRect(x: strength_Button.frame.origin.x+(oneOfFifty)+oneOfFifty/5, y: crit_Label.frame.origin.y+50, width: oneOfFifty, height: 50))
        Ailge_Button.setTitle("Alige", for: .normal)
        Ailge_Button.setTitleColor(UIColor.black, for: .normal)
        Ailge_Button.backgroundColor = UIColor.brown
        Ailge_Button.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        Ailge_Button.tag = 4
        view.addSubview(Ailge_Button)
        
        small_Button = UIButton.init(frame: CGRect(x: 0, y: self.view.frame.size.height - 50, width: oneOfThridWidth, height: 50))
        small_Button.setTitle("Fight Monster", for: .normal)
        small_Button.setTitleColor(UIColor.black, for: .normal)
        small_Button.backgroundColor = UIColor.lightGray
        small_Button.addTarget(self, action: #selector(goToButton), for: .touchUpInside)
        small_Button.tag = 1
        self.view.addSubview(small_Button)
        
        let large_Button = UIButton.init(frame: CGRect(x: fullWidth-oneOfThridWidth, y: self.view.frame.size.height - 50, width: oneOfThridWidth, height: 50))
        large_Button.setTitle("Fight Boss", for: .normal)
        large_Button.setTitleColor(UIColor.black, for: .normal)
        large_Button.backgroundColor = UIColor.lightGray
        large_Button.addTarget(self, action: #selector(goToButton), for: .touchUpInside)
        large_Button.tag = 2
        self.view.addSubview(large_Button)
        
        let store_Label = UIButton.init(frame: CGRect(x: oneOfThridWidth, y: self.view.frame.height-50, width: oneOfThridWidth, height: 50))
        store_Label.setTitle("Store", for: .normal)
        store_Label.setTitleColor(UIColor.black, for: .normal)
        store_Label.backgroundColor = UIColor.lightGray
        store_Label.addTarget(self, action: #selector(goToButton), for: .touchUpInside)
        store_Label.tag = 3
        self.view.addSubview(store_Label)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(goToButton))
        navigationItem.rightBarButtonItem?.tag = 4
        
    }
    @objc func addValue(_ sender: UIButton){
        if upgrade_chance > 0{
        switch (sender.tag) {
        case 4 :  ailge_Value += 0.1; ailge_Label.text = "Ailge: "+String(format: "%.1f", ailge_Value)
        case 1 :  heath_Value += 10; heath_Label.text = "Heath : \(heath_Value)"
        case 3 :  strength_Value += 0.1; strength_Label.text = "Strength: "+String(format: "%.1f", strength_Value)
        case 2 :  attack_Value += 1; attack_Label.text = "Attack : \(attack_Value)"
        default:
            fatalError()
            }
            upgrade_chance -= 1
        }else{
            
            let alert = UIAlertController(title: "Reminder", message: "You don't have any chance to upgrade", preferredStyle: .alert)
            let close = UIAlertAction(title: "Close", style: .cancel)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
            
        }
    }
    @objc func goToButton(_ sender: UIButton){
        
        switch (sender.tag){
        case 1 :
            run_Timer()
        case 2 :
            performSegue(withIdentifier: "goToBoss", sender: self)
            let boss_Controller = FightBossController()
            boss_Controller.setValue(heath_Value, attack_Value, strength_Value, ailge_Value, level_Value, upgrade_chance)
        case 3 : performSegue(withIdentifier: "goToStore", sender: self)
        case 4 : fatalError()
        default:
            fatalError()
        }
        
        
    }
    func run_Timer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update_Timer), userInfo: nil, repeats: true)
        
    }
    @objc func update_Timer()
    {
        time -= 1
        small_Button.setTitle(" Time : \(time)", for: .normal)
        if time > 0{
            small_Button.isEnabled = false
        }else{
            timer.invalidate()
            time = 60
            small_Button.setTitle("Fight Monster", for: .normal)
            small_Button.isEnabled = true
            upgrade_chance += 1
            
            ProgressHUD.showSuccess("Add one chance to upgrade! Chance : \(upgrade_chance)")

        }
    }
     func fighting_Info(_ heath: Int, _ attack: Int, _ strength: Double, _ ailge: Double, _ level: Int, _ bossHeath : Double, _ bossAttack : Double,_ chance : Int) {
        
        heath_Value = heath
        attack_Value = attack
        strength_Value = strength
        ailge_Value = ailge
        level_Value = level
        upgrade_chance = chance
        
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
        
        
    }
    
    
    
}

