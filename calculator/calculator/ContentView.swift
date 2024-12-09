//
//  ContentView.swift
//  calculator
//
//
//  ContentView.swift
//  calculator
//
//  Created by 반성준 on 11/12/24.
//  적당히 잘 봐주세요 ^^

import SwiftUI

struct ContentView: View {
    @State private var displayText: String = "0"  // 초기 디스플레이 텍스트
    @State private var expression: String = ""    // 계산할 수식
    @State private var isResultDisplayed: Bool = false  // 결과가 표시된 상태인지 추적

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
        isResultDisplayed = false
    }

    // 수식을 계산하여 결과 표시
    private func calculateResult() {
        // 잘못된 수식을 정리 (마지막 연산자 제거)
        let sanitizedExpression = sanitizeExpression(expression)
        
        // 수식이 비어있으면 무시
        if sanitizedExpression.isEmpty {
            return
        }
        
        // 0으로 나누는 경우 처리
        if sanitizedExpression.contains("/0") {
            displayText = "Error"
            resetCalculator()
            return
        }

        // 계산 결과 표시
        if let result = evaluateExpression(sanitizedExpression) {
            displayText = "\(result)"
            expression = "\(result)"
            isResultDisplayed = true
        } else {
            displayText = "Error"
        }
    }

    // 디스플레이 및 수식 업데이트
    private func updateDisplayAndExpression(with title: String) {
        // 결과가 표시된 상태에서 새로운 숫자를 입력하면 수식 초기화
        if isResultDisplayed {
            if isOperator(title.first) {
                expression = displayText
            } else {
                expression = ""
                displayText = "0"
            }
            isResultDisplayed = false
        }
        
        // 입력값이 숫자인 경우
        if isNumber(title) {
            if displayText == "0" || isResultDisplayed {
                displayText = title
            } else {
                displayText += title
            }
            expression += title
        }
        // 입력값이 연산자인 경우
        else if isOperator(title.first) {
            // 수식이 비어있거나 끝이 연산자인 경우, 마지막 연산자를 교체
            if expression.isEmpty || isOperator(expression.last) {
                expression = String(expression.dropLast()) + title
                displayText = expression
            } else {
                expression += title
                displayText += title
            }
        }
    }

    // 수식을 계산하는 메서드
    private func evaluateExpression(_ expression: String) -> Int? {
        let formattedExpression = expression
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "/", with: "/")
            .replacingOccurrences(of: "÷", with: "/")
        
        let nsExpression = NSExpression(format: formattedExpression)
        
        if let result = nsExpression.expressionValue(with: nil, context: nil) as? Int {
            return result
        }
        return nil
    }

    // 잘못된 수식을 정리 (마지막 연산자가 있으면 제거)
    private func sanitizeExpression(_ expression: String) -> String {
        var sanitizedExpression = expression
        while let lastChar = sanitizedExpression.last, isOperator(lastChar) {
            sanitizedExpression.removeLast()
        }
        return sanitizedExpression
    }

    // 연산자인지 확인
    private func isOperator(_ char: Character?) -> Bool {
        guard let char = char else { return false }
        return "+-×/÷".contains(char)
    }
    
    // 숫자인지 확인
    private func isNumber(_ title: String) -> Bool {
        return Int(title) != nil
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
