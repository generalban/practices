//
//  ContentView.swift
//  calculator
//
//  Created by 반성준 on 11/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var displayText: String = "0"  // 초기 디스플레이 텍스트
    @State private var expression: String = ""    // 계산할 수식

    var body: some View {
        VStack {
            // 계산기 화면 상단의 디스플레이
            DisplayView(displayText: displayText)
            
            Spacer()
            
            // 버튼 그리드
            VStack(spacing: 10) {
                makeButtonRow(["7", "8", "9", "+"])  // 첫 번째 행
                makeButtonRow(["4", "5", "6", "-"])  // 두 번째 행
                makeButtonRow(["1", "2", "3", "×"])  // 세 번째 행
                makeButtonRow(["AC", "0", "=", "/"]) // 네 번째 행
            }
            .frame(maxWidth: 350)
            .padding(.bottom, 30)
        }
        .background(Color.black.ignoresSafeArea())
    }
    
    // 버튼 행을 만드는 함수
    private func makeButtonRow(_ titles: [String]) -> some View {
        HStack(spacing: 10) {
            ForEach(titles, id: \.self) { title in
                CalculatorButton(title: title) {
                    handleButtonTap(title)
                }
            }
        }
    }

    // 버튼 클릭 시 로직 처리
    private func handleButtonTap(_ title: String) {
        switch title {
        case "AC":
            resetCalculator()
        case "=":
            calculateResult()
        default:
            updateDisplayAndExpression(with: title)
        }
    }

    // 계산기를 초기 상태로 재설정
    private func resetCalculator() {
        displayText = "0"
        expression = ""
    }

    // 수식을 계산하여 결과 표시
    private func calculateResult() {
        if let result = evaluateExpression(expression) {
            displayText = "\(result)"
            expression = "\(result)"
        }
    }

    // 디스플레이 및 수식 업데이트
    private func updateDisplayAndExpression(with title: String) {
        if displayText == "0" {
            displayText = title
        } else {
            displayText += title
        }
        expression += title
        
        // 수식이 "0"으로 시작하지 않도록 수정
        if displayText.hasPrefix("0") && displayText.count > 1 {
            displayText = String(displayText.dropFirst())
        }
    }

    // 수식을 계산하는 메서드
    private func evaluateExpression(_ expression: String) -> Int? {
        let formattedExpression = expression
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
        
        let nsExpression = NSExpression(format: formattedExpression)
        
        if let result = nsExpression.expressionValue(with: nil, context: nil) as? Int {
            return result
        }
        return nil
    }
}

// 계산기 디스플레이 뷰
struct DisplayView: View {
    var displayText: String
    
    var body: some View {
        Text(displayText)
            .font(.system(size: 60, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 30)
            .padding(.top, 200)
            .background(Color.black)
            .frame(height: 100)
    }
}

// 버튼 스타일 및 액션 정의
struct CalculatorButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 30, weight: .bold))
                .frame(width: 80, height: 80)
                .background(buttonColor(for: title))
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }

    // 버튼별 색상 정의
    private func buttonColor(for title: String) -> Color {
        switch title {
        case "/", "×", "-", "+", "=":
            return .orange
        case "AC":
            return .gray
        default:
            return Color(red: 58 / 255, green: 58 / 255, blue: 58 / 255)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
