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
    class StdinData{
        var Stdin = [String](repeating: "=", count: 29)
        var Top : Int = 0
        var End : Int = 0
        var Count : Int = 0
        func reStdinData()
        {
            self.Top = 0
            self.End = 0
        }
        func PopStd() -> String
        {
            var data : String
            data = self.Stdin[self.Top]
            self.Top = (self.Top+1)%29
            Count -= 1
            return data
        }
        func PushStd(inStd : String)
        {
            self.Stdin[self.End] = inStd
            self.End = (self.End+1)%29
            Count += 1
        }
    }
    var NumData = NumberData()
    var CouData = CountData()
    var StdData = StdinData()
    var KuohaoNumber : Int = 0
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
        var Number : String = ""
        for ch in Text.characters
        {
            if(JudgeCountAll(Text: String(ch)))
            {
                if(!Number.isEmpty)
                {
                    StdData.PushStd(inStd: Number)
                    Number = ""
                }
                StdData.PushStd(inStd: String(ch))
            }
            else
            {
                Number += String(ch)
            }
        }
        if(!Number.isEmpty)
        {
            StdData.PushStd(inStd: Number)
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
    func FinalCount()
    {
        var sign : String = ""
        var Num1 : Double = 0
        var Num2 : Double = 0
        var result : Double = 0
        var ch : String = ""
        while  StdData.Count != 0 {
            ch = StdData.PopStd()
            if(!JudgeCountAll(Text: ch))
            {
                NumData.PushNum(inNum: Double(ch)!)
            }
            else
            {
                 switch(CampCount(Text1: CouData.Cou[CouData.Top], Text2:ch))
                 {
                 case "<":
                    CouData.PushCou(inCou: ch)
                    break
                 case ">":
                    sign = CouData.PopCou()
                    Num2 = NumData.PopNum()
                    Num1 = NumData.PopNum()
                    result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                    NumData.PushNum(inNum: result)
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
        }
        //  循环运算 全部数据 可以改上面的循环
    }
    @IBOutlet weak var MainScreen: UILabel!
    @IBOutlet weak var ScendScreen: UILabel!
    @IBAction func NumberButton(_ sender: UIButton)
    {
       /* var sign : String = ""
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
                if(CouData.Cou[CouData.Top] == "(")
                {
                    CouData.Top -= 1
                }
                result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                NumData.PushNum(inNum: result)
                if(String(MainScreen.text!.suffix(1)) != ")" )
                {
                    CouData.PushCou(inCou: "\(MainScreen.text!.suffix(1))")
                }
                break
            default:
                print("Number Button Error")
                break
            }
        }*/
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
            /*if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))))
            {
                MainScreentext.remove(at: MainScreentext.index(before: MainScreentext.endIndex))
            }
            else
            {
                if(Numbertext != "")
                {
                    NumData.PushNum(inNum: Double(Numbertext)!)
                }
                Numbertext = ""
            }*/
            MainScreentext += sender.currentTitle!
            MainScreen.text = MainScreentext
        }
    }
    @IBAction func KuoHaoButton(_ sender: Any) {
       /* var sign : String = ""
        var Num1 : Double = 0
        var Num2 : Double = 0
        var result : Double = 0*/
        if(MainScreen.text!.count <= 14*3)
        {
            if(String(MainScreen.text!.suffix(1)) == ".")
            {
                MainScreentext.remove(at: MainScreentext.index(before: MainScreentext.endIndex))
            }

            if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))))
            {
                CouData.PushCou(inCou: String(MainScreen.text!.suffix(1)))
                MainScreentext += "("
                KuohaoNumber += 1
            }
            else
            {
                switch String(MainScreen.text!.suffix(1)) {
                    case "(":
                        MainScreentext += "("
                        CouData.PushCou(inCou: String(MainScreen.text!.suffix(1)))
                        KuohaoNumber += 1
                        break;
                    case ")":
                        if(KuohaoNumber == 0)
                        {
                            MainScreentext += "x("
                            CouData.PushCou(inCou: "x")
                            CouData.PushCou(inCou: String(MainScreen.text!.suffix(1)))
                            KuohaoNumber += 1
                        }
                        else
                        {
                            MainScreentext += ")"
                            CouData.PushCou(inCou: String(MainScreen.text!.suffix(1)))
                            KuohaoNumber -= 1
                        }
                        break
                    default:
                        if(KuohaoNumber == 0)
                        {
                            MainScreentext += "x("
                           /* CouData.PushCou(inCou: "x")
                            if(Numbertext != "")
                            {
                                NumData.PushNum(inNum: Double(Numbertext)!)
                            }
                            Numbertext = ""*/
                            KuohaoNumber += 1
                        }
                        else
                        {
                            MainScreentext += ")"
                           /* if(Numbertext != "")
                            {
                                NumData.PushNum(inNum: Double(Numbertext)!)
                            }
                            sign = CouData.PopCou()
                            Num2 = NumData.PopNum()
                            Num1 = NumData.PopNum()
                            result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                            NumData.PushNum(inNum: result);
                            CouData.PopCou()
                            Numbertext = ""*/
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
        CutScreen(Text: MainScreen.text!)
        FinalCount()
        print(NumData.Num[NumData.Top])
    }
    @IBAction func DeleteNumber(_ sender: Any) {
        StdData.PushStd(inStd: "1")
        StdData.PushStd(inStd: "2")
        StdData.PushStd(inStd: "3")
        print(StdData.PopStd())
        print(StdData.PopStd())
        print(StdData.PopStd())
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
        StdData.reStdinData()
    }
    
    @IBAction func FinalCount(_ sender: Any) {
        var sign : String = ""
        var Num1 : Double = 0
        var Num2 : Double = 0
        var result : Double = 0
        if(Numbertext != "")
        {
            NumData.PushNum(inNum: Double(Numbertext)!)
        }
        if(KuohaoNumber != 0)
        {
            while (KuohaoNumber != 0 )
            {
                sign = CouData.PopCou()
                Num2 = NumData.PopNum()
                Num1 = NumData.PopNum()
                result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                NumData.PushNum(inNum: result)
                CouData.PopCou()
                MainScreentext += ")"
                MainScreen.text = MainScreentext
                KuohaoNumber -= 1
            }
        }
        while(NumData.Top>0)
        {
            sign = CouData.PopCou()
            Num2 = NumData.PopNum()
            Num1 = NumData.PopNum()
            result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
            NumData.PushNum(inNum: result)
        }
        ScendScreen.text = String(NumData.Num[0])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
// 大改 ： 实现拆分屏幕 ！！！

