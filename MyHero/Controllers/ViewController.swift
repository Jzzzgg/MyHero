//
//  ViewController.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/20/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController, fight {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return equipment.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = equipment[indexPath.row].e_Name
//        return cell
//    }
    
    
    
    var crit_Value : Double = 0.0
    var heath_Value : Int = 100
    var attack_Value : Int = 10
    var strength_Value : Double = 1.0
    var ailge_Value : Double = 1.0
    private var level_Value : Int = 1
    private var gold_Value : Int = 100000
    private var upgrade_chance : Int = 5
    private var time = 30
    private var timer = Timer()
    private var select_Item = Equipment()
    
    private var small_Button = UIButton.init()
    private var heath_Label = UILabel.init()
    private var attack_Label = UILabel.init()
    private var strength_Label = UILabel.init()
    private var ailge_Label = UILabel.init()
    private var crit_Label = UILabel.init()
    private var level_Label = UILabel.init()
    private var chance_Label = UILabel.init()
    private var number_Array: [Int] = []
    private var equipment : [Equipment] = []
    var selected_Equ = UILabel.init()

    
    
    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Info.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)

        // Do any additional setup after loading the view, typically from a nib.
    }
    func setting(){
        
        
        let fullWidth = self.view.frame.size.width
        let fullHeight = self.view.frame.size.height
        let halfWidth = fullWidth/2
//        let halfHeight = fullHeight/2
        let oneOfThridWidth = fullWidth/3
        let oneOfThridHeight = fullHeight/3
        let oneOfFourth = fullWidth/4
        let oneOfFifty = fullWidth/5
        
        load_Items()
        
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
        chance_Label.text = " Chance : \(upgrade_chance)"
        view.addSubview(chance_Label)
        
        
        strength_Label.frame = CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y, width: fullWidth/4, height: 50)
        strength_Label.text = "Strength: "+String(format: "%.1f", strength_Value)
        view.addSubview(strength_Label)
        
        ailge_Label.frame = CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y+fullHeight/9, width: fullWidth/4, height: 50)
        ailge_Label.text = "Agile: "+String(format: "%.1f", ailge_Value)
        view.addSubview(ailge_Label)
        
        crit_Label.frame =  CGRect(x: hero.frame.origin.x+fullWidth/3+10, y: hero.frame.origin.y+fullHeight/9*2, width: fullWidth/4, height: 50)
        crit_Label.text = "Crit : \(crit_Value)"
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
        small_Button.backgroundColor = UIColor.gray
        small_Button.addTarget(self, action: #selector(goToButton), for: .touchUpInside)
        small_Button.tag = 1
        self.view.addSubview(small_Button)
        
        let large_Button = UIButton.init(frame: CGRect(x: fullWidth-oneOfThridWidth, y: self.view.frame.size.height - 50, width: oneOfThridWidth, height: 50))
        large_Button.setTitle("Fight Boss", for: .normal)
        large_Button.setTitleColor(UIColor.black, for: .normal)
        large_Button.backgroundColor = UIColor.gray
        large_Button.addTarget(self, action: #selector(goToButton), for: .touchUpInside)
        large_Button.tag = 2
        self.view.addSubview(large_Button)
        
        let store_Label = UIButton.init(frame: CGRect(x: oneOfThridWidth, y: self.view.frame.height-50, width: oneOfThridWidth, height: 50))
        store_Label.setTitle("Store", for: .normal)
        store_Label.setTitleColor(UIColor.black, for: .normal)
        store_Label.backgroundColor = UIColor.gray
        store_Label.addTarget(self, action: #selector(goToButton), for: .touchUpInside)
        store_Label.tag = 3
        self.view.addSubview(store_Label)
        
        
        selected_Equ = UILabel.init(frame: CGRect(x: 0, y: Ailge_Button.frame.maxY, width: fullWidth, height: 100))
        selected_Equ.text = " Selected Item : \(select_Item.e_Name)"
        selected_Equ.numberOfLines = 0
        view.addSubview(selected_Equ)
//        table.delegate = self
//        table.dataSource = self
//        table.separatorStyle = .none
//        table.rowHeight = 80
//        table.backgroundColor = UIColor.lightGray
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        view.addSubview(table)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(goToButton))
        navigationItem.rightBarButtonItem?.tag = 4
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(reset))
    }
    @objc func addValue(_ sender: UIButton){
        if upgrade_chance > 0{
             upgrade_chance -= 1
        switch (sender.tag) {
        case 4 :  ailge_Value += 0.1; ailge_Label.text = "Agile: "+String(format: "%.1f", ailge_Value)
        chance_Label.text = " Chance : \(upgrade_chance)";save_Items()
        case 1 :  heath_Value += 20; heath_Label.text = "Heath : \(heath_Value)"
        chance_Label.text = " Chance : \(upgrade_chance)";save_Items()
        case 3 :  strength_Value += 0.1; strength_Label.text = "Strength: "+String(format: "%.1f", strength_Value)
        chance_Label.text = " Chance : \(upgrade_chance)";save_Items()
        case 2 :  attack_Value += 2; attack_Label.text = "Attack : \(attack_Value)"
        chance_Label.text = " Chance : \(upgrade_chance)";save_Items()
        default:
            fatalError()
            }
           
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
        case 2 :performSegue(withIdentifier: "goToBoss", sender: self)
        case 3 : performSegue(withIdentifier: "goToStore", sender: self)
        case 4 :
            let pop_Up = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "openBag") as! PopUPViewController
            self.addChild(pop_Up)
            pop_Up.hero_Heath = heath_Value
            pop_Up.hero_Attack = attack_Value
            pop_Up.hero_Strength = strength_Value
            pop_Up.hero_Ailge = ailge_Value
            pop_Up.level_Value = self.level_Value
            pop_Up.chance_Value = upgrade_chance
            pop_Up.hero_Crit = crit_Value
            pop_Up.selected_Item = select_Item
            pop_Up.gold_Value = self.gold_Value
//            pop_Up.numbers = number_Array
            pop_Up.equipment = self.equipment
            pop_Up.view.frame = self.view.frame
            self.view.addSubview(pop_Up.bag)
            pop_Up.didMove(toParent: self)
            load_Items()
        default:
            fatalError()
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBoss"{
            
            let boss_Controller = segue.destination as! FightBossController
            boss_Controller.delegate = self
            boss_Controller.hero_Heath = heath_Value
            boss_Controller.hero_Attack = attack_Value
            boss_Controller.hero_Strength = strength_Value
            boss_Controller.hero_Ailge = ailge_Value
            boss_Controller.hero_Crit = crit_Value
            boss_Controller.selected_Item = select_Item
            boss_Controller.gold_Value = self.gold_Value
            boss_Controller.equipment = self.equipment
            boss_Controller.level_Value = self.level_Value
            boss_Controller.chance_Value = upgrade_chance
            
        }
        if segue.identifier == "goToStore"{
        
            let store_Controller = segue.destination as! StoreController
            store_Controller.hero_Heath = heath_Value
            store_Controller.hero_Attack = attack_Value
            store_Controller.hero_Strength = strength_Value
            store_Controller.hero_Ailge = ailge_Value
            store_Controller.hero_Crit = crit_Value
            store_Controller.equipment = self.equipment
            store_Controller.selected_Item = select_Item
            store_Controller.gold_Value = self.gold_Value
            store_Controller.level_Value = self.level_Value
            store_Controller.chance_Value = upgrade_chance
    }
    }
        
    func run_Timer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update_Timer), userInfo: nil, repeats: true)
        small_Button.setTitle(" Time : \(time)", for: .normal)
        
    }
    @objc func update_Timer()
    {
        time -= 1
        small_Button.setTitle(" Time : \(time)", for: .normal)
        if time > 0{
            small_Button.isEnabled = false
        }else{
            timer.invalidate()
            time = 30
            small_Button.setTitle("Fight Monster", for: .normal)
            small_Button.isEnabled = true
            upgrade_chance += 1
            
            ProgressHUD.showSuccess("Add one chance to upgrade! Chance : \(upgrade_chance)")
            chance_Label.text = " Chance : \(upgrade_chance)"
            save_Items()
            reload_Data()
        }
        
        
    }
    func fighting_Info(_ heath: Int, _ attack: Int, _ strength: Double, _ ailge: Double, _ level: Int,_ random_Number: Int, _ gold: Int,_ equi : [Equipment],_ selected_Item : Equipment ,_ crit: Double ,_ chance : Int) {
        
        heath_Value = heath
        attack_Value = attack
        strength_Value = strength
        ailge_Value = ailge
        level_Value = level
        gold_Value = gold
        crit_Value = crit
        select_Item = selected_Item
        equipment = equi
        upgrade_chance = chance
        if random_Number != 0 {
            number_Array.append(random_Number)
        }
        
        level_Label.text = " Level : \(level_Value)"
        
        
        print("\(heath)")
        
        reload_Data()
        
        
    }
    func save_Items(){
        
        let encoder = PropertyListEncoder()
      
        let new_Item = Info()
        new_Item.agile = ailge_Value
        new_Item.heath = heath_Value
        new_Item.attack = attack_Value
        new_Item.strength = strength_Value
        new_Item.level = level_Value
        new_Item.gold = gold_Value
        new_Item.crit = crit_Value
        new_Item.selected_Item = select_Item
        new_Item.equ = equipment
        new_Item.chance = upgrade_chance
//        new_Item.numbers = number_Array
        
        do{
            let data = try encoder.encode(new_Item)
            
            try data.write(to: filePath!)
            
        }catch{
            print("Error with saving, \(error)")
        }
    }
    func load_Items(){
        
        if let data = try? Data(contentsOf: filePath!){
            let decoder = PropertyListDecoder()
            
            do{
                let new_data : Info = try decoder.decode(Info.self, from: data)
                heath_Value = new_data.heath
                ailge_Value = new_data.agile
                attack_Value = new_data.attack
                strength_Value = new_data.strength
                level_Value = new_data.level
                crit_Value = new_data.crit
                upgrade_chance = new_data.chance
                gold_Value = new_data.gold
                select_Item = new_data.selected_Item
                equipment = new_data.equ
//                number_Array = new_data.numbers
            }catch{
                print("Error \(error)")
            }
        }
    }
    func reload_Data(){
        load_Items()
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
    }
    @objc func reset()  {
        heath_Value = 100
        ailge_Value = 1.0
        attack_Value = 10
        strength_Value = 1.0
        level_Value = 1
        upgrade_chance = 5
        crit_Value = 0.0
        gold_Value = 10000
        select_Item = Equipment()
        equipment = []
        
        save_Items()
        reload_Data()
    }
    
    
}

