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
        var Num = [Double](repeating: 0, count: 29)
        var Top : Int = -1
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
        var Cou = [String](repeating: "=", count: 29)
        var Top : Int = 0
        func reCountData()
        {
            self.Top = 0
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
    var PointNumber : Int = 1
    var MainScreentext : String = ""
    var Numbertext : String = ""
    var Counttext : String = ""
    func JudgeCountAll(Text:String) -> Bool {
        if(Text == "+"||Text == "-"||Text == "x"||Text == "÷"||Text == "("||Text == ")"||Text == "=")
        {
            return true
        }
        return false
    }
    func CutScreen(Text:String)
    {
        var sign : String = ""
        var Num1 : Double = 0
        var Num2 : Double = 0
        var result : Double = 0
        var Number : String = ""
        for ch in Text.characters
        {
            if(JudgeCountAll(Text: String(ch)))
            {
             
                if(!Number.isEmpty)
                {
                    NumData.PushNum(inNum: Double(Number)!)
                    Number = ""
                }
                switch(CampCount(Text1: CouData.Cou[CouData.Top], Text2:String(ch)))
                {
                case "<":
                    CouData.PushCou(inCou: String(ch))
                    break
                case ">":
                    sign = CouData.PopCou()
                    Num2 = NumData.PopNum()
                    Num1 = NumData.PopNum()
                    result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                    NumData.PushNum(inNum: result)
                    CouData.PushCou(inCou: String(ch))
                    break
                case ")":
                    sign = CouData.PopCou()
                    Num2 = NumData.PopNum()
                    Num1 = NumData.PopNum()
                    result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                    NumData.PushNum(inNum: result)
                    CouData.PopCou()
                default:
                    print("Number Button Error")
                    break
                }
            }
            else
            {
                Number += String(ch)
            }
        }
        if(!Number.isEmpty)
        {
            NumData.PushNum(inNum: Double(Number)!)
            Number = ""
        }
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
                Text = ")"
                break
            case "=":
                        Text = ">"
                break
            default:
                print("Error --2")
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
        if(MainScreen.text!.count <= 14*3)
        {
            MainScreentext += sender.currentTitle!
            MainScreen.text = MainScreentext
            Numbertext += sender.currentTitle!
        }
    }
    @IBAction func CountButton(_ sender: UIButton)
    {
        if(MainScreen.text!.count <= 14*3)
        {
            if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))))
            {
                MainScreentext.remove(at:  MainScreentext.index(before:MainScreentext.endIndex))
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

            if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))) || MainScreen.text == "0" )
            {
                MainScreentext += "("
                KuohaoNumber += 1
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
    }
    @IBAction func PointButton(_ sender: Any) {
        PointNumber = 1
        for i in MainScreen.text!.characters
        {
            if(JudgeCountAll(Text: String(i)))
            {
                PointNumber += 1
            }
            if(String(i) == ".")
            {
                PointNumber -= 1
            }
        }
        print(PointNumber)
        if(PointNumber > 0)
        {
            MainScreentext += "."
            MainScreen.text! = MainScreentext
            PointNumber -= 1
        }
    }
    @IBAction func Change(_ sender: Any) {}
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
        var Num1 : Double = 0
        var Num2 : Double = 0
        var result : Double = 0
        while(KuohaoNumber != 0)
        {
            MainScreen.text! += ")"
            KuohaoNumber -= 1
        }
        CutScreen(Text: MainScreen.text!)
        while(CouData.Top != 0)
        {
            sign = CouData.PopCou()
            Num2 = NumData.PopNum()
            Num1 = NumData.PopNum()
            result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
            NumData.PushNum(inNum: result);
        }
        ScendScreen.text = String(NumData.Num[NumData.Top])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
//测试小数点。实现其他操作。

