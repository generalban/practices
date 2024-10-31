import UIKit

// 1. AbstractOperation 프로토콜 정의
protocol AbstractOperation {
    func operate(_ a: Double, _ b: Double) -> Double?
}

// 2. 각 연산 클래스가 AbstractOperation 프로토콜을 채택
class AddOperation: AbstractOperation {
    func operate(_ a: Double, _ b: Double) -> Double? {
        return a + b
    }
}

class SubtractOperation: AbstractOperation {
    func operate(_ a: Double, _ b: Double) -> Double? {
        return a - b
    }
}

class MultiplyOperation: AbstractOperation {
    func operate(_ a: Double, _ b: Double) -> Double? {
        return a * b
    }
}

class DivideOperation: AbstractOperation {
    func operate(_ a: Double, _ b: Double) -> Double? {
        guard b != 0 else {
            print("Error: Division by zero") // 0으로 나눌 때 예외 처리
            return nil
        }
        return a / b
    }
}

// 3. Calculator 클래스는 이제 AbstractOperation 타입을 사용하여 연산을 수행합니다.
class Calculator {
    // String 키에 따라 각 연산을 처리할 수 있도록 딕셔너리를 구성
    private var operations: [String: AbstractOperation] = [
        "+": AddOperation(),
        "-": SubtractOperation(),
        "*": MultiplyOperation(),
        "/": DivideOperation()
    ]
    
    // 연산을 수행하는 calculate 메서드
    func calculate(operator: String, firstNumber a: Double, secondNumber b: Double) -> Double? {
        // 연산이 정의되어 있는지 확인하고, 없는 경우 오류 메시지 반환
        guard let operation = operations[`operator`] else {
            print("Unsupported operation")
            return nil
        }
        return operation.operate(a, b) // 연산 실행
    }
}

// 테스트 코드
let calculator = Calculator()
print("Add: \(calculator.calculate(operator: "+", firstNumber: 10, secondNumber: 20) ?? 0)")     // 30.0
print("Subtract: \(calculator.calculate(operator: "-", firstNumber: 10, secondNumber: 5) ?? 0)")  // 5.0
print("Multiply: \(calculator.calculate(operator: "*", firstNumber: 10, secondNumber: 2) ?? 0)")  // 20.0
print("Divide: \(calculator.calculate(operator: "/", firstNumber: 10, secondNumber: 2) ?? 0)")    // 5.0
print("Divide by zero: \(calculator.calculate(operator: "/", firstNumber: 10, secondNumber: 0) ?? 0)") // 오류 메시지 및 0 반환
