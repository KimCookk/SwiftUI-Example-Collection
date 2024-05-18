//
//  HomeView.swift
//  PomodoroTimer
//
//  Created by 김태성 on 5/15/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var pomodoroModel: PomodorModel
    
    var body: some View {
        VStack {
            Text("Pomodoro Timer")
                .font(.title2.bold())
            
            GeometryReader { proxy in
                VStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.03))
                            .padding(-40)
                        
                        Circle()
                            .trim(from: 0, to: pomodoroModel.progress)
                            .stroke(.white.opacity(0.03), lineWidth: 80)
                        
                        // MARK: Shadow
                        Circle()
                            .stroke(Color("Purple"),
                                    lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-2)
                        
                        Circle()
                            .fill(Color("BG"))
                        
                        Circle()
                            .trim(from: 0, to: pomodoroModel.progress)
                            .stroke(Color("Purple").opacity(0.7),
                                    lineWidth: 10)
                        
                        // MARK: Knob
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color("Purple"))
                                .frame(width: 30, height: 30)
                                .overlay(content: {
                                    Circle()
                                        .fill(.white)
                                        .padding(5)
                                })
                                .frame(width: size.width,
                                       height: size.height,
                                       alignment: .center)
                            // MARK: Since View is Rotated Thats Why Using X
                                .offset(x: size.height/4)
                                .rotationEffect(.init(degrees: pomodoroModel.progress * 3))
                        }
                        
                        Text(pomodoroModel.timerStringValue)
                            .font(.system(size: 45, weight: .light))
                            .rotationEffect(.init(degrees: -90))
                    }
                    .padding(60)
                    .frame(width: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: pomodoroModel.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Button {
                        if pomodoroModel.isStarted {
                            
                        } else {
                            pomodoroModel.addNewTimer = true
                        }
                    } label: {
                        Image(systemName: !pomodoroModel.isStarted ? "timer" : "pause")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .background {
                                Circle()
                                    .fill(Color("Purple"))
                            }
                            .shadow(color: Color("Purple"), radius: 8, x: 0, y: 0)
                    }

                }
                .onTapGesture(perform: {
                    pomodoroModel.progress = 0.5
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
        .overlay(content: {
            ZStack {
                Color.black
                    .opacity(pomodoroModel.addNewTimer ? 0.25 : 0)
                    .onTapGesture {
                        pomodoroModel.addNewTimer = false
                    }
                
                NewTimeView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: pomodoroModel.addNewTimer ? 0 : 400)
            }
        })
        .preferredColorScheme(.dark)
    }
    
    // MARK: New Time Button Sheet
    @ViewBuilder
    func NewTimeView() -> some View {
        VStack(spacing: 15) {
            Text("Add New Timer")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.top, 10)
            
            HStack(spacing: 15) {
                Text("\(pomodoroModel.hour) hr")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background() {
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                Text("\(pomodoroModel.hour) min")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background() {
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                Text("\(pomodoroModel.hour) sec")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background() {
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
            }
            .padding(.top, 20)
            
            Button {
                
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background{
                        Capsule()
                            .fill(Color("Purple"))
                    }
            }
            .disabled(pomodoroModel.second == 0)
            .opacity(pomodoroModel.second == 0 ? 0.5 : 1)
            .padding(.top)

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("BG"))
                .ignoresSafeArea()
        }
    }
    
    // MARK: Reusable Context Menu Options
    func ContextMenuOptions(maxValue: Int, hint: String, onClick: @escaping (Int)->()) {
        ForEach(0...maxValue, id: \.self) { value in
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PomodorModel())
}
