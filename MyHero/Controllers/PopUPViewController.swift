//
//  PopUPViewController.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/25/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import UIKit
import SwipeCellKit



class PopUPViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate ,SwipeTableViewCellDelegate{
    
    var selected_Item = Equipment()
    var hero_Heath : Int = 0
    var hero_Attack : Int = 0
    var hero_Crit : Double = 0.0
    var hero_Strength : Double = 0.0
    var hero_Ailge : Double = 0.0
    var level_Value : Int = 1
    var chance_Value : Int = 0
    var equipment : [Equipment] = []
    var gold_Value : Int = 0
    var new_Equ = Equipment()
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Sell") { action, indexPath in
            // handle action by updating model with deletion
            
            
            
            if self.equipment[indexPath.row].e_Number > 9500{
                self.gold_Value += 40
                self.gold_Lable.text = " Gold : \(self.gold_Value)"
            }else if 9500 > self.equipment[indexPath.row].e_Number && self.equipment[indexPath.row].e_Number > 7000{
                self.gold_Value += 30
                self.gold_Lable.text = " Gold : \(self.gold_Value)"
            }
            else if 7000 > self.equipment[indexPath.row].e_Number && self.equipment[indexPath.row].e_Number > 4000{
                self.gold_Value += 20
                self.gold_Lable.text = " Gold : \(self.gold_Value)"
            }else{
                self.gold_Value += 10
                self.gold_Lable.text = " Gold : \(self.gold_Value)"
            }
            self.equipment.remove(at: indexPath.row)
            self.save_Items()
        }
        let addAction = SwipeAction(style: .destructive, title: "Add") { action, indexPath in
            
            let x = ViewController()
           
                self.hero_Heath -= self.selected_Item.e_Heath
                self.hero_Ailge -= self.selected_Item.e_Agile
                self.hero_Attack -= self.selected_Item.e_Attack
                self.hero_Strength -= self.selected_Item.e_Strength
                self.hero_Crit  -= self.selected_Item.e_Crit
                self.selected_Item = self.equipment[indexPath.row]
                
                self.hero_Heath += self.selected_Item.e_Heath
                self.hero_Ailge += self.selected_Item.e_Agile
                self.hero_Attack += self.selected_Item.e_Attack
                self.hero_Strength += self.selected_Item.e_Strength
                self.hero_Crit  += self.selected_Item.e_Crit
                
            
            self.table.reloadData()
            self.save_Items()
            self.load_Numbers()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction,addAction]
    }
    
    var bag = UIView.init()
    var numbers : [Int] = []
    
    private var table: UITableView!
    private var gold_Lable = UILabel.init()

    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Info.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    func setting(){
        load_Numbers()
        
        
        let fullWidth = self.view.frame.size.width
        let fullHeight = self.view.frame.size.height
        let halfWidth = fullWidth/2
        let halfHeight = fullHeight/2
        let oneOfThridWidth = fullWidth/3
        let oneOfThridHeight = fullHeight/3
//        let oneOfFourth = fullWidth/4
//        let oneOfFourthHeight = fullHeight/4
//        let oneOfFifty = fullWidth/5
//        let oneOfFiftyHeight = fullHeight/5
        
        
        
        bag = UIView.init(frame: CGRect(x: halfWidth-oneOfThridWidth, y: halfHeight-oneOfThridHeight, width: oneOfThridWidth*2, height: oneOfThridHeight*2))
        bag.backgroundColor = UIColor.brown
        view.addSubview(bag)
        
        let close = UIButton.init(frame: CGRect(x: 10, y: 10, width: fullHeight/12, height: fullWidth/11))
        close.backgroundColor = UIColor.gray
        close.addTarget(self, action: #selector(close_Function), for: .touchUpInside)
        close.setTitle("Close", for: .normal)
        bag.addSubview(close)
        
        table = UITableView.init(frame: CGRect(x: 0, y: 15+fullWidth/11, width: bag.frame.size.width
            , height: bag.frame.size.height - (15+fullWidth/11) ))
        table.separatorStyle = .none
        table.rowHeight = 80
        table.register(SwipeTableViewCell.self, forCellReuseIdentifier: "MyCell")
        bag.addSubview(table)
        
        gold_Lable.frame = CGRect(x: bag.frame.size.width-160, y: 10, width: 150, height: 30)
        gold_Lable.text = " Gold : \(gold_Value)"
        bag.addSubview(gold_Lable)
    }
    
    @objc func close_Function()
    {
        self.bag.removeFromSuperview()
     
    }
    func load_Numbers(){
       
        if let data = try? Data(contentsOf: filePath!){
            let decoder = PropertyListDecoder()
            
            do{
                let new_data : Info = try decoder.decode(Info.self, from: data)
//                numbers = new_data.numbers
                gold_Value = new_data.gold
                selected_Item = new_data.selected_Item
                equipment = new_data.equ
                
            }catch{
                print("Error \(error)")
            }

        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! SwipeTableViewCell
       
        cell.delegate = self
        
        cell.textLabel?.text = equipment[indexPath.row].e_Name
        
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipment.count
    }
    func save_Items(){
        
        let encoder = PropertyListEncoder()
        
        let new_Item = Info()
        
        new_Item.agile = hero_Ailge
        new_Item.heath = hero_Heath
        new_Item.attack = hero_Attack
        new_Item.strength = hero_Strength
        new_Item.level = level_Value
        new_Item.chance = chance_Value
        new_Item.crit = hero_Crit
        new_Item.selected_Item = selected_Item
        new_Item.gold = gold_Value
        new_Item.equ = equipment
//        new_Item.numbers = numbers
        
        do{
            let data = try encoder.encode(new_Item)
            
            try data.write(to: filePath!)
            
        }catch{
            print("Error with saving, \(error)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
