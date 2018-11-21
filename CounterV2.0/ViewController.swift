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
        var Num = [Double](repeating: 0, count: 999)
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
        var Cou = [String](repeating: "=", count: 999)
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
    func JudgeCountAll(Text:String) -> Bool {
        if(Text == "+"||Text == "-"||Text == "x"||Text == "÷"||Text == "("||Text == ")")
        {
            return true
        }
        return false
    }
    func JudgeCount(Text:String) -> Bool
    {
        if(Text == "+"||Text == "-"||Text == "x"||Text == "÷"){
            return true
        }
        return false
    }
    func CampCount (Text1:String,Text2:String) -> String
    {
        var Text : String = ""
        switch Text2 {
            case "+":
                if(Text1 == "("||Text1 == "=")
                {
                    Text = "<"
                }
                else
                {
                    Text = ">"
                }
                break
            case "-":
                if(Text1 == "("||Text1 == "=")
                {
                    Text = "<"
                }
                else
                {
                    Text = ">"
                }
                break
            case "x":
                if(Text1 == "x"||Text1 == "÷"||Text1 == ")")
                {
                    Text = ">"
                }
                else
                {
                    Text = "<"
                }
                break
            case "÷":
                if(Text1 == "x"||Text1 == "÷"||Text1 == ")")
                {
                    Text = ">"
                }
                else
                {
                    Text = "<"
                }
                break
            case "(":
                Text = "<"
                break
            case ")":
                switch Text1
                {
                case "(" :
                    Text = "="
                    break
                default:
                    Text = ">"
                }
                break
            case "=":
                switch Text1
                {
                case "=":
                    Text = "="
                    break
                default:
                    Text = ">"
                }
                break
            default:
                break
            }
        return Text
    }
    func MainCount(Num1:Double,Cou:String,Num2:Double) -> Double
    {
        var Result : Double = 0
        switch Cou {
        case "+":
            Result = Num1 + Num2
            break
        case "-":
            Result = Num1 - Num2
            break
        case "x":
            Result = Num1 * Num2
            break
        case "÷":
            if(Num2 == 0)
            {
                print("2不能为0")
            }
            else
            {
                Result = Num1 / Num2
            }
        default:
            break
        }
        return Result
    }
    
    @IBOutlet weak var MainScreen: UILabel!
    @IBOutlet weak var ScendScreen: UILabel!
    @IBAction func NumberButton(_ sender: UIButton)
    {
        var sign : String = ""
        var Num1 : Double = 0
        var Num2 : Double = 0
        var result : Double = 0
        if(JudgeCountAll(Text: "\(MainScreen.text!.suffix(1))"))
        {
            switch(CampCount(Text1: CouData.Cou[CouData.Top], Text2:String(MainScreen.text!.suffix(1))))
            {
            case "<":
                CouData.PushCou(inCou: "\(MainScreen.text!.suffix(1))")
                break
            case ">":
                sign = CouData.PopCou()
                Num2 = NumData.PopNum()
                Num1 = NumData.PopNum()
                result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                NumData.PushNum(inNum: result)
                break
            default:
                break
            }
        }
        if(MainScreen.text!.count <= 14*3)
        {
        MainScreentext += sender.currentTitle!
        MainScreen.text = MainScreentext
        Numbertext += sender.currentTitle!
        }
    }
    @IBAction func CountButton(_ sender: UIButton)
    {
        if(Numbertext != "")
        {
            NumData.PushNum(inNum: Double(Numbertext)!)
        }
        if(MainScreen.text!.count <= 14*3)
        {
            if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))))
            {
                MainScreentext.remove(at: MainScreentext.index(before: MainScreentext.endIndex))
            }
            else
            {
                NumData.PushNum(inNum: Double(Numbertext)!)
                Numbertext = ""
            }
            MainScreentext += sender.currentTitle!
            MainScreen.text = MainScreentext
        }
    }
    @IBAction func KuoHaoButton(_ sender: Any) {
        if(MainScreen.text!.count <= 14*3)
        {
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
                print(KuohaoNumber)
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
        print(CampCount(Text1: CouData.Cou[CouData.Top], Text2:String(MainScreen.text!.suffix(1))))
        print(CouData.Top)
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
    
    @IBAction func FinalCount(_ sender: Any) {
        var sign : String = ""
        var num1 : Double = 0
        var num2 : Double = 0
        var result : Double = 0
        if(Numbertext != "")
        {
            NumData.PushNum(inNum: Double(Numbertext)!)
        }
        while(!NumData.Num.isEmpty)
        {
            sign = CouData.PopCou()
            num2 = NumData.PopNum()
            num1 = NumData.PopNum()
            result = MainCount(Num1: num1, Cou: sign, Num2: num2)
            NumData.PushNum(inNum: result)
        }
        ScendScreen.text = String(result)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

