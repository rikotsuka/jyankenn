import SwiftUI
 
 struct ContentView: View {
     // ゲームロジック
     let HANDS = ["グー", "チョキ", "パー"]
     let RESULT_MESSAGES = ["勝ち", "負け", "あいこ"]
     
     @State var userHand = ""
     @State var result = ""
     
     var body: some View {
         VStack {
             Text("じゃんけんしましょう！")
             
             Text("じゃんけん")
                 .padding()
                 .font(.largeTitle)
   //VStackは、縦方向のビューを配置するためのコンテナビュー。ビューの中には、ゲームのタイトルを表示するTextビューなどが含まれている。
            
             HStack {
                 Button(action: {
                     startGame("グー")
                 }, label: {
                     Image("b_gu")
                         .resizable()
                         .frame(width: 110,height: 60)
                         .scaledToFit()
                 })
                 Button(action: {
                     startGame("チョキ")
                 }, label: {
                     Image("b_choki")
                         .resizable()
                         .frame(width: 110,height: 60)
                         .scaledToFit()
                 })
                 Button(action: {
                     startGame("パー")
                 }, label: {
                     Image("b_pa")
                         .resizable()
                         .frame(width: 110,height: 60)
                         .scaledToFit()
                 })
             }
        //手の選択ボタンは、Buttonビューを使用して実装。各ボタンには、手の種類を引数として渡すstartGame関数が割り当てられている。「label」は、SwiftUIでボタンに表示されるテキストやイメージを指定するためのプロパティ。上記のコードでは、、Imageをボタンのラベルとして使用している。
             .padding()
             
             Text(result)
                 .font(.title)
         }
     }
     
     // ゲーム開始
     func startGame(_ userHand: String) {
         self.userHand = userHand
         self.result = "ぽん！"
         
         var workItem: DispatchWorkItem?
         
         workItem = DispatchWorkItem { [self] in
             let computerHand = HANDS.randomElement()!
             let gameResult = playGame(userHand, computerHand)
             self.result = gameResult
             workItem = nil
         }
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem!)
     }
     //self.userHandは、ユーザーが選んだ手を表す文字列であり、self.resultは、じゃんけんの結果を表す文字列。次に、DispatchWorkItemを作成し、それをworkItem変数に代入します。DispatchWorkItemは、非同期に実行される作業を表すオブジェクト。ここでは、じゃんけんの結果を計算するために使用される。DispatchWorkItemには、クロージャが含まれる。このクロージャは、ランダムに選択されたコンピュータの手とユーザーの手を比較し、じゃんけんの勝敗を判定する関数playGameを呼び出す。そして、self.resultに結果を代入。最後に、DispatchQueue.main.asyncAfterを使用して、1秒後にworkItemを非同期に実行する。
     
     
     // ゲームの勝敗を計算する
     func playGame(_ userHand: String, _ computerHand: String) -> String {
         let userIndex = HANDS.firstIndex(of: userHand)!
         let computerIndex = HANDS.firstIndex(of: computerHand)!
         var resultIndex: Int

         if userIndex == computerIndex {
             resultIndex = 2
         } else if userIndex == (computerIndex + 1) % 3 {
             resultIndex = 1
         } else {
             resultIndex = 0
         }
         
         let resultMessage = RESULT_MESSAGES[resultIndex]
         return "コンピューターは\(computerHand)、\(resultMessage)です。"
     }
     
     
     struct ContentView_Previews: PreviewProvider {
         static var previews: some View {
             ContentView()
         }
     }
 }

