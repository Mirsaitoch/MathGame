//
//  ContentView.swift
//  MathGame
//
//  Created by Мирсаит Сабирзянов on 10.11.2023.
//

import SwiftUI

struct Question: Hashable{
    var number: Int
    var text: String
    var answer: Int
}

struct ContentView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
    }
    
    @State private var variablesOfCount = [5, 10, 20]
    @State private var countOfQuestions = 5
    @State private var maxValue = 5
    @State var questions = [Question]()
    @State var ans = ""
    @State var questionDisplayIndex = 0
    @State var alertIsShowed = false
    @State var incorrectAlertIsShowed = false

    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Form(){
                        Section("Select the number of questions"){
                            Picker("Select the number of questions", selection: $countOfQuestions){
                                ForEach(variablesOfCount, id: \.self) {
                                    Text(String($0)).foregroundStyle(.orange)
                                }
                            }
                            .pickerStyle(.segmented)
                            .colorMultiply(.orange)
                        }
                        Section("To what number do you learn to multiply"){
                            Picker("Select the number of questions", selection: $maxValue){
                                ForEach(2..<13) {
                                    Text(String($0)).foregroundStyle(.orange)
                                }
                            }
                            .pickerStyle(.segmented)
                            .colorMultiply(.orange)
                        }
                        Section{
                            if(questions.count > 0){
                                VStack{
                                    HStack{
                                        if questionDisplayIndex <= countOfQuestions{
                                            Image(systemName: "\(questions[questionDisplayIndex].number).circle")
                                            Text(questions[questionDisplayIndex].text)
                                        }
                                    }
                                    TextField("Enter your answer", text: $ans)
                                        .foregroundStyle(.orange)
                                        .keyboardType(.numberPad)
                                    if ans.count > 0 {
                                        Button(){
                                            if checkResult(ans: ans, correctAns: String(questions[questionDisplayIndex].answer)){
                                                print(questionDisplayIndex, countOfQuestions-1)
                                                questionDisplayIndex += 1
                                                if questionDisplayIndex >= countOfQuestions{
                                                    questionDisplayIndex = 0
                                                    questions = []
                                                    alertIsShowed = true
                                                }
                                                ans = ""
                                            }
                                            else{
                                                incorrectAlertIsShowed = true
                                                ans = ""
                                            }
                                        }label: {
                                            Text("check it!")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("MathGame")
                .alert("Well done", isPresented: $alertIsShowed){
                    Button("New game"){
                        questions = []
                        questionDisplayIndex = 0
                        questions = generateQuestions(countOfQuestions: countOfQuestions, maxValue: maxValue)}
                    Button("Settings"){
                        questions = []
                        questionDisplayIndex = 0
                    }

                }
                .alert("Incorrect answer", isPresented: $incorrectAlertIsShowed){
                    Button("New game"){
                        questions = []
                        questionDisplayIndex = 0
                        questions = generateQuestions(countOfQuestions: countOfQuestions, maxValue: maxValue)}
                    Button("ok"){
                        
                    }

                }
                .toolbar{
                    Button("Let's go"){
                        questions = generateQuestions(countOfQuestions: countOfQuestions,  maxValue: maxValue)
                    }
                }
            }
        }
    }
        
        func checkResult(ans: String, correctAns: String)-> Bool{
            ans == correctAns
        }
        
        func generateQuestions(countOfQuestions: Int,  maxValue: Int) -> [Question]{
            var questions = [Question]()
            for i in 0..<countOfQuestions{
                let firstNumber = Int.random(in: 1...maxValue+2)
                let secondNumber = Int.random(in: 1...maxValue+2)
                let text = "\(firstNumber) * \(secondNumber)"
                questions.append(Question(number: i + 1, text: text, answer: firstNumber * secondNumber))
            }
            
            return questions
        }
        
    }

    
    
    
    #Preview {
        ContentView()
    }
