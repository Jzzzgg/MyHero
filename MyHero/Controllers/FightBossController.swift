//
//  FightBossController.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/23/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import UIKit
import ProgressHUD

protocol fight{
    
    func fighting_Info(_ heath : Int,_ attack : Int,_ strength : Double,_ agile : Double,
                      _ level : Int, _ bossHeath : Double, _ bossAttack : Double , _ chance : Int)
}

class FightBossController: UIViewController {

    
    private var boss_image = UIImageView.init()
    var delegate : fight?
    var hero_Heath : Int = 0
    var hero_Attack : Int = 0
    var hero_Strength : Double = 0.0
    var hero_Ailge : Double = 0.0
    var level_Value : Int = 0
    var chance_Value : Int = 0
    var num : Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        boss_Image_function()
        fighting_Process()
        // Do any additional setup after loading the view.
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
        let oneOfFiftyHeight = fullHeight/5
        
        let background = UIImageView.init(frame: CGRect(x: 0, y: 0, width: fullWidth, height: fullHeight))
        background.image = UIImage(named: "travel.png")
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        
        let hero = UIImageView.init(frame: CGRect(x: halfWidth-oneOfThridWidth/2, y: oneOfFiftyHeight*3, width: oneOfThridWidth, height: oneOfFiftyHeight))
        hero.image = UIImage.init(named: "person.png")
        hero.contentMode = .scaleAspectFit
        view.addSubview(hero)
        
        boss_image.frame = CGRect(x: halfWidth-oneOfThridWidth/2, y: oneOfFiftyHeight, width: oneOfThridWidth, height: oneOfFiftyHeight)
        boss_image.contentMode = .scaleAspectFit
        view.addSubview(boss_image)
    }
    
    func boss_Image_function(){
        
        let random_num = Int.random(in: 0...100)
        if random_num > 85{
            boss_image.image = UIImage(named: "boss1.png")
        }else{
            boss_image.image = UIImage(named: "boss.png")
        }
    }
    func setValue(_ heath: Int, _ attack: Int, _ strength: Double, _ ailge: Double, _ level: Int, _ chance: Int ){
        
        hero_Heath = heath
        hero_Attack = attack
        hero_Strength = strength
        hero_Ailge = ailge
        level_Value = level
        chance_Value = chance
    }
    func fighting_Process(){
        
        let total_Heath = (Double(hero_Heath) * hero_Strength)
        let total_Attack = (Double(hero_Attack) * hero_Ailge)
        let boss_Heath = Double(50+(level_Value * 90 ))
        let boss_Attack = ((0.2 * Double(level_Value)+1)*10)
        let hero_Heath_Value =  total_Heath / boss_Attack
        let boss_Heath_Value = boss_Heath / total_Attack
        
        if boss_Heath_Value > hero_Heath_Value{
            ProgressHUD.showError("You lose!")
            
            delegate?.fighting_Info( hero_Heath
                , hero_Attack,  hero_Strength, hero_Ailge, level_Value, Double(40+((level_Value) * 110 )),  ((0.4 * Double(level_Value))*10),chance_Value)
            
        }else if hero_Heath_Value > boss_Heath_Value{
            
            ProgressHUD.showSuccess("You win!")
            
            delegate?.fighting_Info( hero_Heath
                , hero_Attack,  hero_Strength, hero_Ailge, level_Value, Double(40+((level_Value+1) * 110 )),  ((0.4 * Double(level_Value)+1)*10),4)
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
