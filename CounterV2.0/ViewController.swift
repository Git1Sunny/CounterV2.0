//
//  ViewController.swift
//  CounterV2.0
//
//  Created by S20171102171 on 2018/11/15.
//  Copyright © 2018 武英琦. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    class NumberData{
        var Num = [Int]()
        var Top : Int = 0
    }
    class CountData{
        var Cou = [Character]()
        var Top : Int = 0
    }
    var MainScreentext : String = ""
    var Numbertext : String = ""
    var Counttext : String = ""
    func JudgeCount(Text:String) -> Bool
    {
        if(Text == "+"||Text == "-"||Text == "x"||Text == "÷"){
            return true
        }
        return false
    }
    func reNumberData(data : NumberData)
    {
        data.Top = -1
    }
    func reCountData(data : CountData)
    {
        data.Top = -1
    }
    
    @IBOutlet weak var MainScreen: UILabel!
    @IBOutlet weak var ScendScreen: UILabel!
    @IBAction func NumberButton(_ sender: UIButton)
    {
        MainScreentext += sender.currentTitle!
        MainScreen.text = MainScreentext
        Numbertext += sender.currentTitle!
    }
    @IBAction func CountButton(_ sender: UIButton)
    {
        if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))))
        {
            MainScreentext.remove(at: MainScreentext.index(before: MainScreentext.endIndex))
        }
        MainScreentext += sender.currentTitle!
        MainScreen.text = MainScreentext
    }
    @IBAction func KuoHaoButton(_ sender: Any) {
    }
    @IBAction func PointButton(_ sender: Any) {
    }
    @IBAction func Change(_ sender: Any) {
    }
    @IBAction func DeleteNumber(_ sender: Any) {
    }
    @IBAction func ACButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

