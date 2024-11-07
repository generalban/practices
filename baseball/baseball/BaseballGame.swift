import Foundation

class BaseballGame {
    private var recordManager = RecordManager() // 게임 기록을 관리하는 인스턴스
    
    func start() {
        var isRunning = true
        
        while isRunning {
            print("""
            환영합니다! 원하시는 번호를 입력해주세요
            1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
            """)
            
            guard let input = readLine(), let choice = Int(input) else {
                print("올바른 숫자를 입력해주세요!")
                continue
            }
            
            switch choice {
            case 1:
                playGame()
            case 2:
                recordManager.showRecords()
            case 3:
                print("< 숫자 야구 게임을 종료합니다 >")
                isRunning = false
            default:
                print("올바른 숫자를 입력해주세요!")
            }
        }
    }
    
    private func playGame() {
        let answer = makeAnswer() // 정답을 생성
        var attempts = 0
        
        print("< 게임을 시작합니다! >")
        
        while true {
            print("세 자리 숫자를 입력하세요:")
            
            if let input = readLine() {
                let guess = Array(input).compactMap { $0.wholeNumberValue }
                
                // 유효성 검사: 세 자리 숫자, 중복 없는지 확인
                if guess.count != 3 || Set(guess).count != 3 || guess.contains(0) {
                    print("올바르지 않은 입력값입니다")
                    continue
                }
                
                attempts += 1
                let (strikes, balls) = compareGuess(answer, guess)
                
                if strikes == 3 {
                    print("정답입니다!")
                    print("시도 횟수: \(attempts)")
                    recordManager.add(trialCount: attempts)
                    break
                } else {
                    print("\(strikes)스트라이크 \(balls)볼")
                }
            } else {
                print("올바르지 않은 입력값입니다")
            }
        }
    }
    
    private func makeAnswer() -> [Int] {
        var numbers = Array(1...9)
        numbers.shuffle()
        return Array(numbers.prefix(3))
    }
    
    
    
    private func compareGuess(_ answer: [Int], _ guess: [Int]) -> (Int, Int) {
        var strikes = 0
        var balls = 0
        
        for i in 0..<3 {
            if answer[i] == guess[i] {
                strikes += 1
            } else if answer.contains(guess[i]) {
                balls += 1
            }
        }
        return (strikes, balls)
    }
}

class RecordManager {
    private var records: [Int] = []
    
    func add(trialCount: Int) {
        records.append(trialCount)
    }
    
    func showRecords() {
        print("< 게임 기록 보기 >")
        if records.isEmpty {
            print("아직 기록이 없습니다.")
        } else {
            for (index, record) in records.enumerated() {
                print("\(index + 1)번째 게임: 시도 횟수 - \(record)")
            }
        }
    }
}

