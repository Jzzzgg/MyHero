//
//  StoreController.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/23/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import UIKit
import ProgressHUD

class StoreController: UIViewController {

    var hero_Heath : Int = 0
    var hero_Attack : Int = 0
    var hero_Strength : Double = 0.0
    var hero_Ailge : Double = 0.0
    var level_Value : Int = 1
    var chance_Value : Int = 0
    var gold_Value : Int = 0
    var equipment : [Equipment] = []
    var array: [Int] = []
    var new_Equ = Equipment()
    
    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Info.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        
        // Do any additional setup after loading the view.
    }
    func setting(){
        load_Items()
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        let background = UIImageView.init(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.size.width, height: self.view.frame.size.height-barHeight))
        background.image = UIImage.init(named: "travel.png")
        background.contentMode = .scaleAspectFill
        self.view.addSubview(background)
        
        let picture1 = UIButton.init(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.size.width, height: self.view.frame.size.height-barHeight))
        picture1.setImage(UIImage(named: "box.png"), for: .normal)
        picture1.contentMode = .scaleAspectFit
        picture1.addTarget(self, action: #selector(buy), for: .touchUpInside)
        view.addSubview(picture1)
        
        
    }
    @objc func buy(){
        if gold_Value >= 200{
            get_Item()
            equipment.append(new_Equ)
            gold_Value -= 200
            save_Item()
        }else {
            ProgressHUD.showError("Not enough gold !")
        }
        
    }
    func get_Item(){
        
        var output = ""
        let random_Number = Int.random(in: 1...10001)
        
        new_Equ.e_Number = random_Number
        
        if random_Number > 9500{
            var purpose = "Purpose Item: "
            
            for _ in 0...3{
                let random_items = Int.random(in: 0...5)
                switch random_items{
                case 1 : let random = Int.random(in: 10...101) ; purpose.append(" Heath+\(random)")
                new_Equ.e_Heath = random
                case 2 : let random = Int.random(in: 1...11) ; purpose.append(" Attack+\(random)")
                new_Equ.e_Attack = random
                case 3 : let random = Double.random(in: 1...6) ; purpose.append(" Agile+\((String(format: "%.1f",random)))")
                new_Equ.e_Agile = random
                case 4 : let random = Double.random(in: 1...6) ; purpose.append(" Strength+\((String(format: "%.1f",random)))")
                new_Equ.e_Strength = random
                default:
                    let random = Double.random(in: 1...8) ; purpose.append(" Crit+\((String(format: "%.2f",random)))")
                    new_Equ.e_Crit = random
                }
            }
            new_Equ.e_Name = purpose
            output = purpose
            ProgressHUD.showSuccess(purpose)
            
        }else if 9500 > random_Number && random_Number > 7000{
            var blue = "Blue Item: "
            for _ in 0...2{
                let random_items = Int.random(in: 0...5)
                switch random_items{
                case 1 : let random = Int.random(in: 10...91) ; blue.append(" Heath+\(random)")
                new_Equ.e_Heath = random
                case 2 : let random = Int.random(in: 1...10) ; blue.append(" Attack+\(random)")
                new_Equ.e_Attack = random
                case 3 : let random = Double.random(in: 1...5) ; blue.append(" Agile+\(String(format: "%.1f",random))")
                new_Equ.e_Agile = random
                case 4 : let random = Double.random(in: 1...5) ; blue.append(" Strength+\(String(format: "%.1f",random))")
                new_Equ.e_Strength = random
                default:
                    let random = Double.random(in: 1...7) ; blue.append(" Crit+\((String(format: "%.2f",random)))")
                    new_Equ.e_Crit = random
                }
            }
            new_Equ.e_Name = blue
            output = blue
            ProgressHUD.showSuccess(blue)

        }
        else if 7000 > random_Number && random_Number > 4000{
            var green = "Green Item: "
            for _ in 0...1{
                let random_items = Int.random(in: 0...5)
                switch random_items{
                case 1 : let random = Int.random(in: 10...81) ; green.append(" Heath+\(random)")
                new_Equ.e_Heath = random
                case 2 : let random = Int.random(in: 1...9) ; green.append(" Attack+\(random)")
                new_Equ.e_Attack = random
                case 3 : let random = Double.random(in: 1...4) ; green.append(" Agile+\(String(format: "%.1f",random))")
                new_Equ.e_Agile = random
                case 4 : let random = Double.random(in: 1...4) ; green.append(" Strength+\(String(format: "%.1f",random))")
                new_Equ.e_Strength = random
                default:
                    let random = Double.random(in: 1...6) ; green.append(" Crit+\((String(format: "%.2f",random)))")
                    new_Equ.e_Crit = random
                }
            }
            new_Equ.e_Name = green
            output = green
            ProgressHUD.showSuccess(green)

        }else{
            var white = "White Item: "
            
            let random_items = Int.random(in: 0...5)
            switch random_items{
            case 1 : let random = Int.random(in: 10...71) ; white.append(" Heath+\(random)")
            new_Equ.e_Heath = random
            case 2 : let random = Int.random(in: 1...8) ; white.append(" Attack+\(random)")
            new_Equ.e_Attack = random
            case 3 : let random = Double.random(in: 1...3) ; white.append(" Agile+\(String(format: "%.1f",random))")
            new_Equ.e_Agile = random
            case 4 : let random = Double.random(in: 1...3) ; white.append(" Strength+\(String(format: "%.1f",random))")
            new_Equ.e_Strength = random
            default:
                let random = Double.random(in: 1...5) ; white.append(" Crit+\((String(format: "%.2f",random)))")
                new_Equ.e_Crit = random
            }
            new_Equ.e_Name = white
            output = white
            ProgressHUD.showSuccess(white)

            
        }
        
        
    }

    func load_Items(){
        
        if let data = try? Data(contentsOf: filePath!){
            let decoder = PropertyListDecoder()
            
            do{
                let new_data : Info = try decoder.decode(Info.self, from: data)
                hero_Heath = new_data.heath
                hero_Ailge = new_data.agile
                hero_Attack = new_data.attack
                hero_Strength = new_data.strength
                level_Value = new_data.level
                chance_Value = new_data.chance
                gold_Value = new_data.gold
                equipment = new_data.equ
//                array = new_data.numbers
            }catch{
                print("Error \(error)")
            }
        }
    }
    func save_Item(){
        
        let encoder = PropertyListEncoder()
        let new_Item = Info()
        new_Item.heath = hero_Heath
        new_Item.attack = hero_Attack
        new_Item.agile = hero_Ailge
        new_Item.strength = hero_Strength
        new_Item.level = level_Value+1
        new_Item.chance = chance_Value
        new_Item.gold = gold_Value
        new_Item.equ = equipment
//        new_Item.numbers = array
        
        
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
