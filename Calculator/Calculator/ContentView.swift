//
//  ContentView.swift
//  Calculator
//
//  Created by SKUBI on 15/03/23.
//

import SwiftUI

enum calculatorButtons {
    case zero, one, two, three, four , five, six, seven, eight, nine, dot, doublezero
    case ac, plusMinus, percent
    case divide, multiply, plus, minus, equals
    
    var rawValue: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "x"
        case .divide: return "÷"
        case .equals: return "="
        case .dot: return "."
        case .percent: return "%"
        case .plusMinus: return "<"
        case .doublezero: return "00"
        default:
            return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self{
        case .zero, .one, .two, .three, .four , .five, .six, .seven, .eight, .nine, .dot, .doublezero :
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.systemGray)
        default:
            return Color(.orange)
        }
    }
}

enum Operation {
    case plus, minus, multiply, divide, percent, none
}

struct ContentView: View {
    
    @State var display = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[calculatorButtons]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .doublezero, .dot, .equals]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            //LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            Color(red: 0.1, green: 0.1, blue: 0.1).ignoresSafeArea(.all)
            VStack (spacing: 20) {
                
                HStack{
                    Spacer()
                    Text(display)
                        .foregroundColor(.white)
                        .font(.system(size: 62))
                }
                .padding()
                
                ForEach(buttons, id: \.self) {row in
                    HStack (spacing: 15){
                        ForEach(row, id: \.self) { button in
                            Button {
                                didTapButton(button: button)
                                //self.display = button.rawValue
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundColor(button.backgroundColor)
                                    //.shadow(color: button.backgroundColor, radius: 10, x: 4, y: 4)
                                    
                                    Text(button.rawValue)
                                        .foregroundColor(.white)
                                        .font(.system(size: 35))
                                        .frame(width: 80, height: 80)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    func didTapButton(button: calculatorButtons){
        switch button {
        case .plus, .minus, .multiply, .divide, .equals, .percent:
            if button == .plus {
                self.currentOperation = .plus
                self.runningNumber = Int(display) ?? 0
            }
            else if button == .minus {
                self.currentOperation = .minus
                self.runningNumber = Int(display) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(display) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(display) ?? 0
            }
            else if button == .percent {
                self.currentOperation = .percent
                self.runningNumber = Int(display) ?? 0
            }
            else if button == .equals {
                let runningValue = self.runningNumber
                let currentValue = Int(self.display) ?? 0
                switch self.currentOperation{
                case .plus: self.display = "\(runningValue + currentValue)"
                case .minus: self.display = "\(runningValue - currentValue)"
                case .multiply: self.display = "\(runningValue * currentValue)"
                case .divide: self.display = "\(runningValue / currentValue)"
                case .percent: self.display = "\(runningValue % currentValue)"
                case .none: break
                }
            }
            if button != .equals {
                self.display = "0"
            }
            break
        case .ac:
            self.display = "0"
            break
        case .plusMinus:
            if button == .plusMinus {
                self.display = "\((Int(self.display) ?? 0) / 10)"
            }
            break
        default:
            let number = button.rawValue
            if self.display == "0" {
                self.display = number
            } else {
                self.display = "\(self.display)\(number)"
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
