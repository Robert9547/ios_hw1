//
//  ContentView.swift
//  HW1
//
//  Created by 賴冠宏 on 2022/3/13.
//

import SwiftUI
import UIKit
import Metal
struct ContentView: View {
    @State private var chesscolor = "whitechess"
    @State private var site = Array(repeating: 0, count: 42)
    @State private var who = 0 //輪到誰
    @State private var a = 42
    @State private var b = 43
    @State private var c = 44
    @State private var d = 45
    @State private var e = 46
    @State private var f = 47
    @State private var g = 48
    @State private var endGame = 0 //判斷遊戲是否結束
    
    var body: some View {
        VStack{
            ZStack{
                Image("bg")
                    .resizable()
                    .frame(width: 380, height: 380)
                HStack{
                    let columns = Array(repeating: GridItem(), count: 6)
                    LazyVGrid(columns: columns){
                        ForEach(0..<site.count){ item in
                            Image("\(changeColor(colorNum: site[item]))")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(100)
                                .onTapGesture {
                                    var num = 0 //記錄當前棋子位置
                                    
                                    if endGame == 1{
                                        resetGame()
                                        endGame = 0
                                    }
                                    
                                    if site[item] == 0{
                                        num = underBottom(siteNum: item)
                                        site[num] = getColor(who: who)
                                        who += 1
                                        print(whoWin(nowChess: item))
                                    }

                                    if whoWin(nowChess: num)==777{
                                        endGame = 1
                                        //彈出視窗
                                        let controller = UIAlertController(title: "遊戲結束", message: "將開啟新一輪對戰", preferredStyle: .alert)
                                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                        controller.addAction(okAction)
                                        UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
                                        //讓遊戲結束當下的now玩家為獲勝玩家
                                        who -= 1
                                    }
                                    print(item)
                                }
                        }
                    }
                }
                Text("Now :")
                    .font(.title)
                    .padding()
                    .offset(x: -35, y: -250)
                Image("\(changeColor(colorNum: getColor(who: who)))")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .offset(x: 35, y: -250)
                  
            }
            //reset chess
            Button{
                for i in 0..<42{
                    site[i] = 0
                }
                a = 42
                b = 43
                c = 44
                d = 45
                e = 46
                f = 47
                g = 48
                who = 0
            }label:{
                Text("reset")
                    .font(.title)
            }.offset(x: 150, y:-430)
        }
    }
    //傳入陣列內的值給函式判斷該為什麼顏色並回傳
    func changeColor(colorNum: Int) -> String{
        if colorNum == 0{
            return "whitechess"
        }
        else if colorNum == 1{
            return "yellowchess"
        }
        else if colorNum == 2{
            return "redchess"
        }
        else if colorNum == 3{
            return "bingo"
        }
        return "whitechess"
    }
    //得知是輪到誰下要變什麼顏色
    func getColor(who: Int) -> Int{
        if who%2 == 0{
            return 1
        }
        else{
            return 2
        }
    }
    //從最下開始放
    func underBottom(siteNum: Int) -> Int{
        if siteNum%6 == 0{
            //0 6 12 18 24 30 36
            a -= 6
            return a
        }
        else if siteNum%6 == 1{
            //1 7 13 19 25 31 37
            b -= 6
            return b
        }
        else if siteNum%6 == 2{
            //2 8 14 20 26 32 38
            c -= 6
            return c
        }
        else if siteNum%6 == 3{
            //3 9 15 21 27 33 39
            d -= 6
            return d
        }
        else if siteNum%6 == 4{
            //4 10 16 22 28 34 40
            e -= 6
            return e
        }
        else if siteNum%6 == 5{
            //5 11 17 22 28 34 41
            f -= 6
            return f
        }
        return -1
    }
    //輸贏判斷
    func whoWin(nowChess: Int) -> Int{
        var x = 0
        //zu
        if nowChess <= 23{
            for i in 1..<4{
                if site[nowChess] == site[nowChess + (6*i)]{
                    if site[nowChess + (6*i)] != 0{
                        x += 1
                    }
                }
            }
            
        }
        if x == 3{
            site[nowChess] = 3
            for i in 1..<4{
                site[nowChess + (6*i)] = 3
            }
            return 777
        }
        //han
        
        //shay
        
        return -1
    }
    //reset game
    func resetGame(){
        for i in 0..<42{
            site[i] = 0
        }
        a = 42
        b = 43
        c = 44
        d = 45
        e = 46
        f = 47
        g = 48
        who = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

