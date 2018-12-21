//
//  ViewController.swift
//  CounterV2.0
//
//  Created by S20171102171 on 2018/11/15.
//  Copyright © 2018 武英琦. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //—————————————————————————————————————————————————————————   数字栈
    class NumberData{
        var Num = [Double](repeating: 0, count: 30) //栈大小为30
        var Top : Int = -1
        func PushNum(inNum:Double)              // 入栈
        {
            self.Top += 1
            self.Num[self.Top] = inNum
        }
        func PopNum() -> Double                 // 出栈
        {
            var data : Double = 0
            data = self.Num[self.Top]
            self.Top -= 1
            return data
        }
        func reNumberData()                 // 初始化栈
        {
            self.Top = -1
        }
    }
    //—————————————————————————————————————————————————————————   符号栈
    class CountData{
        var Cou = [String](repeating: "=", count: 30)//栈大小为30
        var Top : Int = 0
        func reCountData()  // 初始化栈
        {
            self.Top = 0
        }
        func PopCou() -> String  // 出栈
        {
            var data : String
            data = self.Cou[self.Top]
            self.Top -= 1
            return data
        }
        func PushCou(inCou : String)  // 入栈
        {
            self.Top += 1
            self.Cou[self.Top] = inCou
        }
    }
    //—————————————————————————————————————————————————————————   变量定义
    var NumData = NumberData()                  //实例化 数字栈
    var CouData = CountData()                   // 实例化 符号栈
    var KuohaoNumber : Int = 0                  // 括号统计
    var MainScreentext : String = ""            // 主屏幕
    //—————————————————————————————————————————————————————————   去除小数点后多余零
    func RemoveZero(testNumber:Double)->String{
        var str = "\(testNumber)"                  //数字转字符串
        var str2 = str.components(separatedBy: ".")//字符串拆解成数组
        if(str2[1]=="")                            //如果小数点右边为空
        {
            str2[1] = "0"                          //让小数点右边为零
        }
        if(Int(str2[1]) == 0)
        {
            str = str2[0]           //如果小数点后全部为0则只返回整数部分
        }
        return str//正常返回
    }
    //—————————————————————————————————————————————————————————   判断输入的字符时否为符号
    func JudgeCountAll(Text:String) -> Bool {
        if(Text == "+"||Text == "-"||Text == "x"||Text == "÷"||Text == "("||Text == ")")
        {
            return true
        }
        return false
    }
    //—————————————————————————————————————————————————————————   拆分屏幕中的内容并计算
    func ScreenCount(Text:String) -> Bool
    {
        var sign : String = ""
        var Num1 : Double = 0
        var Num2 : Double = 0
        var result : Double = 0
        var Number : String = ""
        var Temp : String = ""
        for ch in Text.characters // 字符遍历内容
        {
            if(JudgeCountAll(Text: String(ch)) && (Temp != "(" || String(ch) != "-"))
            { // 如果是符号 将储存的数字入栈 然后通过CampCount函数 计算
                if(CouData.Cou[CouData.Top] == "÷" && Number == "0") // 如果除号后为零则不执行操作
                {
                    return false
                }
                if(!Number.isEmpty) //如果数字队列不为空 则让数字入栈
                {
                    NumData.PushNum(inNum: Double(Number)!)
                    Number = ""
                }
                switch(CampCount(Text1: CouData.Cou[CouData.Top], Text2:String(ch)))
                {
                case "<": // 优先级高 入栈
                    CouData.PushCou(inCou: String(ch))
                    break
                case ">": // 优先级低 出栈
                    sign = CouData.PopCou()
                    Num2 = NumData.PopNum()
                    Num1 = NumData.PopNum()
                    result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                    NumData.PushNum(inNum: result)
                    CouData.PushCou(inCou: String(ch))
                    break
                case ")": // 特殊运算 右括号
                    if(CouData.Cou[CouData.Top] != "(")
                    {
                        sign = CouData.PopCou()
                        Num2 = NumData.PopNum()
                        Num1 = NumData.PopNum()
                        result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                        NumData.PushNum(inNum: result)
                    }
                    CouData.PopCou()
                default:
                    break
                }
            }
            else //不是符号 让数字储存
            {
                Number += String(ch)
            }
            Temp = String (ch) // 暂存上一次的字符 用于判断- 是符号还是减号
        }
        if(CouData.Cou[CouData.Top] == "÷" && Number == "0")
        {
            return false
        }
        if(!Number.isEmpty) //遍历完若数字没入栈则入栈
        {
            NumData.PushNum(inNum: Double(Number)!)
            Number = ""
        }
        return true
    }
    //——————————————————————————————————————————————————————   判断是否为基本符号加减乘除
    func JudgeCount(Text:String) -> Bool
    {
        if(Text == "+"||Text == "-"||Text == "x"||Text == "÷"){
            return true
        }
        return false
    }
    //————————————————————————————————————————————————————— 判断栈顶元素和当前符号判断优先级
    func CampCount (Text1:String,Text2:String) -> String
    {//其中 “<” 表示入栈 ">" 表示出栈 返回相应的符号 来表示优先级
        var Text : String = ""
        switch Text2 {
            case "+":
                if(Text1 == "("||Text1 == "=") // 优先级高 入栈
                {
                    Text = "<"
                }
                else //优先级低 出栈
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
                break
            }
        return Text
    }
    //—————————————————————————————————————————————————————————   简单的计算两个数
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
                if(Num2 != 0)
                {
                    Result = Num1 / Num2
                }
            
        default:
            break
        }
        return Result
    }
    //—————————————————————————————————————————————————————————   Laber定义
    @IBOutlet weak var MainScreen: UILabel!
    @IBOutlet weak var ScendScreen: UILabel!
    //—————————————————————————————————————————————————————————   数字按钮
    @IBAction func NumberButton(_ sender: UIButton)
    {
        if(MainScreen.text!.count <= 26) // 限制屏幕输入
        {
            if(String(MainScreen.text!.suffix(1)) == ")") // 若输入数字前是）添加x号
            {
                MainScreentext += "x"
                MainScreen.text = MainScreentext
            }
                MainScreentext += sender.currentTitle!
                MainScreen.text = MainScreentext
        }
    }
    //—————————————————————————————————————————————————————————   符号按钮
    @IBAction func CountButton(_ sender: UIButton)
    {
        if(MainScreen.text!.count <= 26) //限制输入
        {
            if(MainScreen.text! == "0" || String(MainScreen.text!.suffix(1)) == "(")
            { // 若输入符号前 屏幕内容为0
                MainScreentext += "0";
            }
            if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))) || String(MainScreen.text!.suffix(1)) == ".")
                //在输入符号时 末尾为符号 则修改符号为 新符号
            {
                MainScreentext.remove(at:  MainScreentext.index(before:MainScreentext.endIndex))
            }
            MainScreentext += sender.currentTitle!
            MainScreen.text = MainScreentext
            
        }
    }
    //—————————————————————————————————————————————————————————   括号按钮
    @IBAction func KuoHaoButton(_ sender: Any) {
            if(String(MainScreen.text!.suffix(1)) == ".")
            {
                MainScreentext.remove(at: MainScreentext.index(before: MainScreentext.endIndex))
            }//若括号前为 。 则删除小数点
            if(JudgeCount( Text: (String(MainScreen.text!.suffix(1)))) || MainScreen.text == "0" )
            {
                MainScreentext += "("
                KuohaoNumber += 1
            }
            //若前一个字符为符号 或者 屏幕中为0 则直接打印 （
            else //若为数字
            {
                switch String(MainScreen.text!.suffix(1)) {
                    case "(": // 前为（ 则再次打印左括号
                        MainScreentext += "("
                        KuohaoNumber += 1
                        break;
                    case ")": //前为右括号则判断前方括号个数 来打印
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
                    default: //前方为括号 则打印
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
    //—————————————————————————————————————————————————————————   小数点按钮
    @IBAction func PointButton(_ sender: Any) {
        var PointNumber : Int = 1
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
        } // 计算当前小数点数量
        if(String(MainScreen.text!.suffix(1)) == ")") //如果按小数点是前一个为）则删除右括号
        {
            MainScreen.text!.remove(at: MainScreen.text!.index(before: MainScreen.text!.endIndex))
            KuohaoNumber -= 1
            MainScreentext = MainScreen.text!
        }
        if(JudgeCount(Text: (String(MainScreen.text!.suffix(1))))) //如果直接输入小数点 则输入0再点小数点
        {
            MainScreentext += "0"
            MainScreen.text = MainScreentext
        }
        if(PointNumber > 0)
        {
            MainScreentext += "."
            MainScreen.text! = MainScreentext
            PointNumber -= 1
        }
    }
    //—————————————————————————————————————————————————————————   变换符号按钮
    @IBAction func Change(_ sender: Any) {
        var Number : String = ""
        var count : String = ""
        if(MainScreen.text == "0") // 若屏幕中只有0 则屏幕中显示（-
        {
            MainScreentext += "(-"
            KuohaoNumber += 1
            MainScreen.text = MainScreentext
        }
        else if(JudgeCount(Text: (String(MainScreen.text!.suffix(1)))) || String(MainScreen.text!.suffix(1)) == "(" ) // 判断前一个符号时否是符号或者“（”是则直接显示（-
        {
            MainScreentext += "(-"
            KuohaoNumber += 1
            MainScreen.text = MainScreentext
        }
        else if(String(MainScreen.text!.suffix(1)) == ")") //判断前一个是否为“）” 若是则打印x（-
        {
            MainScreentext += "x(-"
            KuohaoNumber += 1
        }
        else
        {
            for i in MainScreen.text!.characters.reversed() //遍历屏幕内容 取最后一串数字
            {
                if(String(i) == "-" || !JudgeCountAll(Text: String(i)))
                {
                    count += String(i)
                    MainScreen.text!.remove(at: MainScreen.text!.index(before: MainScreen.text!.endIndex))
                }
                else
                {
                    break
                }
            }
            for i in count.characters.reversed() // 将上方便利结果 整合成完整数字
            {
                    Number += String(i)
            }
            Number = RemoveZero(testNumber: (Double(Number)! * -1)) //让数字乘-1
            MainScreentext = MainScreen.text! // 将处理后到数字打印回屏幕上
            if(String(MainScreen.text!.suffix(1)) != "(" || String(MainScreen.text!.suffix(2)) != "(")//如果前一个字符或者前两个字符不为（ 则多显示一个（
            {
                MainScreentext += "("
            }
            KuohaoNumber += 1
            MainScreentext += Number
            MainScreen.text = MainScreentext
            }
        }
    //—————————————————————————————————————————————————————————   回删按钮
    @IBAction func DeleteNumber(_ sender: Any) {
        if(MainScreen.text!.count == 1) //如果回格最后一个数字 重置为0
        {
            MainScreen.text = "0"
            MainScreentext = ""
        }
        if(MainScreen.text != "0"){ //若值为0 无法回格
            MainScreen.text!.remove(at: MainScreen.text!.index(before: MainScreen.text!.endIndex)) //删除最后一位
            MainScreentext = MainScreen.text!
        }
    }
    //—————————————————————————————————————————————————————————   AC清空按钮
    @IBAction func ACButton(_ sender: Any) {//初始化所有内容
        KuohaoNumber = 0
        MainScreentext = ""
        MainScreen.text = "0"
        ScendScreen.text = ""
        NumData.reNumberData()
        CouData.reCountData()
    }
    //—————————————————————————————————————————————————————————   等号按钮
    @IBAction func FinalCount(_ sender: Any) {
        var sign : String = ""
        var Num1 : Double = 0
        var Num2 : Double = 0
        var kuoNumber : Int = 0
        var result : Double = 0
        while(JudgeCountAll(Text: (String(MainScreen.text!.suffix(1)))) || String(MainScreen.text!.suffix(1)) == ".") //若最后一个为符号或者小数点则删除尾位
        {
            MainScreentext.remove(at:  MainScreentext.index(before:MainScreentext.endIndex))
            MainScreen.text = MainScreentext
        }
        for i in MainScreen.text!.characters // 遍历判断括号数量是不是足够
        {
            if(String(i) == "(")
            {
                kuoNumber += 1
            }
            if(String(i) == ")")
            {
                kuoNumber -= 1
            }
        }
        while(kuoNumber > 0) // 若括号对数不匹配则补全对数
        {
            MainScreentext += ")"
            MainScreen.text = MainScreentext
            kuoNumber -= 1
        }
        if(ScreenCount(Text: MainScreen.text!)) //拆分屏幕内容 并计算入栈
        {
            while(CouData.Top != 0) // 如果拆分屏幕完成后 数字栈中仍有数据 则一直运算到数字栈为1
            {
                sign = CouData.PopCou()
                Num2 = NumData.PopNum()
                Num1 = NumData.PopNum()
                result = MainCount(Num1: Num1, Cou: sign, Num2: Num2)
                NumData.PushNum(inNum: result);
            }
            ScendScreen.text = RemoveZero(testNumber: NumData.Num[NumData.Top]) //在屏幕 中现实结果
        }
        else
        {
            ScendScreen.text = "" //计算除0时候（出错时） 将结果屏幕显示为空
        }
        NumData.reNumberData() // 计算结束 初始化两个堆栈
        CouData.reCountData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
