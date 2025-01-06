## **Pokemon 도감 앱 - README**

### **프로젝트 소개**
이 프로젝트는 **MVVM 아키텍처**와 **RxSwift**를 활용하여 포켓몬 도감 앱을 개발한 결과물입니다. `UICollectionView`를 통해 포켓몬 목록을 스크롤하며 탐색할 수 있고, 각 포켓몬의 세부 정보를 확인할 수 있습니다. `pokeapi.co`의 REST API를 사용하여 데이터를 가져오며, **무한 스크롤**, **이미지 로딩**, **디테일 화면 전환** 등 다양한 기능을 구현했습니다.

---

### **기술 스택**
- **iOS Development**
  - Language: Swift
  - Architecture: MVVM
  - UI Framework: UIKit (Code-Based UI)
  - Reactive Programming: RxSwift, RxCocoa
- **Networking**
  - REST API: PokeAPI
  - Networking Layer: URLSession, RxSwift `Single`
- **Image Loading**
  - Library: Kingfisher

---

### **주요 기능**

#### **1️⃣ 포켓몬 목록 보기**
- **설명**: `UICollectionView`를 사용하여 포켓몬 목록을 3열 그리드 형태로 구현.
- **API**: `https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)`
- **특징**: 
  - 무한 스크롤 구현 (`limit` 단위로 데이터 추가 로드)
  - 포켓몬 이미지를 URL로 가져와 `Kingfisher`를 통해 로드.

#### **2️⃣ 포켓몬 상세 정보 보기**
- **설명**: 포켓몬 목록에서 선택된 포켓몬의 상세 정보를 보여줌.
- **API**: `https://pokeapi.co/api/v2/pokemon/\(pokemon_id)/`
- **세부 정보**:
  - 포켓몬 이름
  - 포켓몬 타입
  - 키, 몸무게
- **특징**: 
  - 영어 이름을 한글로 번역 (`PokemonTranslator` 사용).
  - 타입을 한글로 번역 (`PokemonTypeName` 사용).

#### **3️⃣ 무한 스크롤**
- **설명**: 사용자가 컬렉션뷰를 하단으로 스크롤할 때 새로운 데이터를 자동으로 불러옴.
- **구현 방법**:
  - `contentOffset`을 관찰하여 스크롤 이벤트 감지.
  - `isLoading` 플래그로 중복 요청 방지.

---

### **디렉토리 구조**
```
📂 PokemonApp
├── 📂 Models
│   ├── Pokemon.swift
│   ├── PokemonDetail.swift
│   └── PokemonType.swift
├── 📂 ViewModels
│   ├── MainViewModel.swift
│   └── DetailViewModel.swift
├── 📂 Views
│   ├── MainViewController.swift
│   ├── DetailViewController.swift
│   ├── PokemonCollectionViewCell.swift
│   └── CustomColors.swift
├── 📂 Networking
│   └── NetworkManager.swift
└── 📂 Utilities
    ├── PokemonTranslator.swift
    └── Extensions.swift
```

---
### **설치 및 실행 방법**

1. **클론하기**
   ```bash
   git clone https://github.com/your-repository/pokemon-app.git
   cd pokemon-app
   ```

2. **의존성 설치**
   - CocoaPods 사용 시:
     ```bash
     pod install
     ```
   - 의존성:
     - RxSwift
     - RxCocoa
     - Kingfisher

3. **Xcode에서 열기**
   - `PokemonApp.xcworkspace` 파일을 열어 빌드 및 실행.

---

### **문제 해결 (Troubleshooting)**

1. **포켓몬 목록이 로드되지 않음**
   - 네트워크 연결 확인.
   - API 호출이 실패할 경우 디버깅 로그를 확인.

2. **스크롤 시 중복 데이터 발생**
   - `isLoading` 플래그 확인 및 요청 중복 방지 로직 확인.

3. **이미지 로드 실패**
   - `Kingfisher`를 통해 이미지 로드 상태를 확인하고, URL이 올바른지 확인.

---



