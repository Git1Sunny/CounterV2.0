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
        var Num = [Double](repeating: 0, count: 20)
        var Top : Int = 0
        func PushNum(inNum:Double)
        {
            self.Top += 1
            self.Num[self.Top] = inNum

        }
        func PopNum() -> Double
        {
            var data : Double = 0
            data = self.Num[self.Top]
            self.Top -= 1
            return data
        }
        func reNumberData()
        {
            self.Top = -1
        }
    }
    class CountData{
        var Cou = [String](repeating: "o", count: 20)
        var Top : Int = 0
        func reCountData()
        {
            self.Top = -1
        }
        func PopCou() -> String
        {
            var data : String
            data = self.Cou[self.Top]
            self.Top -= 1
            return data
        }
        func PushCou(inCou : String)
        {
            self.Top += 1
            self.Cou[self.Top] = inCou
        }
    }
    var NumData = NumberData()
    var CouData = CountData()
    var KuohaoNumber : Int = 0
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
    
    @IBOutlet weak var MainScreen: UILabel!
    @IBOutlet weak var ScendScreen: UILabel!
    @IBAction func NumberButton(_ sender: UIButton)
    {
        if(MainScreen.text!.count>=9)
        {
            MainScreentext += "\n"
        }
        MainScreentext += sender.currentTitle!
        MainScreen.text = MainScreentext
        Numbertext += sender.currentTitle!
        print(Numbertext)
    }
    @IBAction func CountButton(_ sender: UIButton)
    {
        if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))))
        {
            MainScreentext.remove(at: MainScreentext.index(before: MainScreentext.endIndex))
        }
        MainScreentext += sender.currentTitle!
        MainScreen.text = MainScreentext
        NumData.PushNum(inNum: Double(Numbertext)!)
        Numbertext = ""
    }
    @IBAction func KuoHaoButton(_ sender: Any) {
        if(String(MainScreen.text!.suffix(1)) == ".")
        {
            MainScreentext.remove(at: MainScreentext.index(before: MainScreentext.endIndex))
        }
        if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))))
        {
            MainScreentext += "("
        }
        else
        {
            switch String(MainScreen.text!.suffix(1)) {
            case "(":
                MainScreentext += "("
                KuohaoNumber += 1
                break;
            case ")":
                if(KuohaoNumber == 0)
                {
                    MainScreentext += "x("
                    KuohaoNumber += 1
                }
                else
                {
                    MainScreentext += ")"
                    KuohaoNumber -= 1
                }
                break
            default:
                if(KuohaoNumber == 0)
                {
                    MainScreentext += "x("
                    KuohaoNumber += 1
                }
                else
                {
                    MainScreentext += ")"
                    KuohaoNumber -= 1
                }
            }
        }
        MainScreen.text = MainScreentext
    }
    @IBAction func PointButton(_ sender: Any) {
        if(!Numbertext.contains("."))
        {
            Numbertext += "."
            MainScreentext += "."
            MainScreen.text! = MainScreentext
        }
    }
    @IBAction func Change(_ sender: Any) {
    }
    @IBAction func DeleteNumber(_ sender: Any) {
    }
    @IBAction func ACButton(_ sender: Any) {
        KuohaoNumber = 0
        MainScreentext = ""
        MainScreen.text = "0"
        Counttext = ""
        Numbertext = ""
        ScendScreen.text = ""
        NumData.reNumberData()
        CouData.reCountData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

