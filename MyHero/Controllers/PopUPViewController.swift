//
//  PopUPViewController.swift
//  MyHero
//
//  Created by Zhuguang Jiang on 2/25/19.
//  Copyright © 2019 Zhuguang Jiang. All rights reserved.
//

import UIKit


class PopUPViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
   
    var bag = UIView.init()
    var numbers : [Int] = []
    
    private var table: UITableView!
    
    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Info.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
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
        let oneOfFourth = fullWidth/4
        let oneOfFourthHeight = fullHeight/4
        let oneOfFifty = fullWidth/5
        let oneOfFiftyHeight = fullHeight/5
        
        
        
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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        table.dataSource = self
        table.delegate = self
        bag.addSubview(table)
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
                numbers = new_data.numbers
                
            }catch{
                print("Error \(error)")
            }

        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        if numbers[indexPath.row] > 9500{
            
            let random_items = Int.random(in: 3...5)
            if random_items == 3{
                
            }
            
            cell.textLabel?.text = "Purpose Item: "
        }
        
        

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    func Item_Value( _ row : Int){
        
        
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
