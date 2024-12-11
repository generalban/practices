# **PokemonContacts**

> 랜덤 포켓몬 이미지를 사용하여 연락처 프로필을 설정할 수 있는 iOS 앱  
> Core Data를 활용해 데이터를 영구 저장하며, UIKit으로 설계된 직관적이고 간단한 학습 프로젝트입니다.

---

## **📌 프로젝트 개요**

**PokemonContacts**는 iOS의 Core Data를 활용하여 연락처 정보를 저장하고 관리하는 앱입니다.  
랜덤 포켓몬 이미지를 [PokeAPI](https://pokeapi.co/)에서 불러와 프로필 이미지로 사용할 수 있습니다.  
UIKit을 활용한 UI와 함께 연락처 추가, 수정, 삭제 기능을 제공합니다.

---

## **✨ 주요 기능**

1. **연락처 추가 및 수정**  
   - 사용자는 이름, 전화번호, 프로필 이미지를 입력하여 연락처를 저장할 수 있습니다.  
   - 저장된 연락처를 수정하거나 삭제할 수 있습니다.

2. **랜덤 포켓몬 이미지 생성**  
   - 버튼 클릭 시 [PokeAPI](https://pokeapi.co/)에서 랜덤 포켓몬 이미지를 불러옵니다.  

3. **Core Data로 데이터 영구 저장**  
   - 앱 종료 후에도 저장된 연락처를 유지합니다.  

4. **연락처 목록 표시**  
   - 테이블 뷰에 이름순으로 정렬된 연락처 목록을 보여줍니다.

---

## **🔧 기술 스택**

### **프레임워크 및 라이브러리**
- **UIKit**: UI 구성  
- **Core Data**: 데이터 영구 저장  
- **URLSession**: 네트워크 요청 처리  

### **개발 환경**
- Xcode 15.1  
- iOS 17.0+  
- Swift 5.8+  

### **API**
- **[PokeAPI](https://pokeapi.co/)**: 랜덤 포켓몬 이미지 데이터 제공  

---

## **📂 프로젝트 구조**

```plaintext
PokemonContacts/
├── AppDelegate.swift          # Core Data 초기화 및 앱 설정
├── MainViewController.swift   # 연락처 목록 화면
├── PhoneBookViewController.swift # 연락처 추가/수정 화면
├── ContactTableViewCell.swift # 테이블 뷰 셀 UI
├── DataManager.swift          # Core Data 작업 관리
├── PokemonAPIManager.swift    # 랜덤 포켓몬 이미지 API 연결
├── Contact+CoreDataClass.swift # Core Data 모델 정의
├── Contact+CoreDataProperties.swift # Core Data 속성 정의
├── Assets.xcassets            # 앱 리소스 (아이콘, 이미지 등)
├── PokemonContacts.xcdatamodeld # Core Data 데이터 모델


