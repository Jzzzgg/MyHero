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
    var level_Value : Int = 1
    var chance_Value : Int = 0
    private var boss_Heath : Double = 0
    private var boss_Attack : Double = 0
    private var boss_Damage = 0.0
    private var hero_Damage = 0.0
    
    private var boss_bar = UIProgressView.init()
    private var hero_bar = UIProgressView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boss_Image_function()
        setting()
        progress_Start()
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
        
        boss_bar = UIProgressView.init(frame: CGRect(x: halfWidth-oneOfThridWidth/2, y: oneOfFiftyHeight*2 + 10, width: oneOfThridWidth, height: 20))
        boss_bar.setProgress(0.0, animated: true)
        hero_Damage = Double(hero_Attack) * hero_Ailge
        view.addSubview(boss_bar)
        
        hero_bar = UIProgressView.init(frame: CGRect(x: halfWidth-oneOfThridWidth/2, y: oneOfFiftyHeight*4 + 10, width: oneOfThridWidth, height: 20))
        hero_bar.setProgress(0.0, animated: true)
        boss_Damage = boss_Attack
        view.addSubview(hero_bar)
        
        
        perform(#selector(progress_Update), with: nil, afterDelay: 1.0)
    }
    
    func boss_Image_function(){
        
        let random_num = Int.random(in: 0...100)
        if random_num > 85{
            boss_image.image = UIImage(named: "boss1.png")
            boss_Heath = Double(50+(level_Value * 120 ))
            boss_Attack = ((0.4 * Double(level_Value))*10)+10
        }else{
            boss_image.image = UIImage(named: "boss.png")
            boss_Heath = Double(50+(level_Value * 90 ))
            boss_Attack = ((0.2 * Double(level_Value))*10)+10
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
    func progress_Start(){
        
        
        
        
        
    }
    @objc func progress_Update(){
        
        
        let total_Heath = (Double(hero_Heath) * hero_Strength)
        let total_Attack = (Double(hero_Attack) * hero_Ailge)
//        let hero_Heath_Value =  total_Heath / boss_Attack
//        let boss_Heath_Value = boss_Heath / total_Attack
        boss_Damage = boss_Damage + boss_Attack
        hero_Damage = hero_Damage + total_Attack
        
        boss_bar.progress = Float((hero_Damage) / boss_Heath)
        hero_bar.progress = Float(boss_Damage/total_Heath)
        
        if (boss_Damage < total_Heath) && (hero_Damage < boss_Heath){
            
            perform(#selector(progress_Update), with: nil, afterDelay: 1)
        }
        else if boss_Damage >= total_Heath{
            ProgressHUD.showError("You lose!")
            delegate?.fighting_Info( hero_Heath
                           , hero_Attack,  hero_Strength, hero_Ailge, level_Value, boss_Heath,  boss_Attack,chance_Value)

        }
        else if boss_Heath <= hero_Damage{

            ProgressHUD.showSuccess("You win!")
            delegate?.fighting_Info( hero_Heath
                           , hero_Attack,  hero_Strength, hero_Ailge, level_Value, boss_Heath, boss_Attack,4)
        }

        
        
        
        
        
        
//        if boss_Heath_Value > hero_Heath_Value{
//            ProgressHUD.showError("You lose!")
//
//            delegate?.fighting_Info( hero_Heath
//                , hero_Attack,  hero_Strength, hero_Ailge, level_Value, Double(50+(level_Value * 90 )),  ((0.2 * Double(level_Value))*10),chance_Value)
//
//        }else if hero_Heath_Value > boss_Heath_Value{
//
//            ProgressHUD.showSuccess("You win!")
//
//            delegate?.fighting_Info( hero_Heath
//                , hero_Attack,  hero_Strength, hero_Ailge, level_Value, Double(50+(level_Value * 90 )),  ((0.4 * Double(level_Value)+1)*10),4)
//        }
        
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
