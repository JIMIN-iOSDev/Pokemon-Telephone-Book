# 📱포켓몬 연락처 앱

## 📚 목차
1. 프로젝트 소개 (#프로젝트소개)
2. 주요 기능
3. 개발 기간
4. 기술 스택
5. API 명세서
6. Trouble Shooting
7. 추가하면 좋을 기능


## 프로젝트 소개
포켓몬 API를 통해 이미지를 불러오고 UserDeafaults를 사용해 앱이 종료되어도 저장했던 이미지, 이름, 전화번호가 남아있는 포켓몬 연락처 앱을 만들었습니다


## 주요기능
1. 랜덤한 포켓몬 캐릭터 이미지 저장
2. 이름 또는 별명 저장
3. 전화번호 저장


## 개발 기간
- 2024.12.06(금) ~ 2024.12.12(목)


## 기술 스택
### 언어
- Swift

### 프레임워크
- UIKit

### 기타
- SnapKit, Alamofire, UserDefaults


## API 명세서
- GET 메서드 사용
- URL : https://pokeapi.co/api/v2/pokemon/{1~1000사이의랜덤숫자입력}
- JSON Response 형태 :
  {
  "id": 25,
  "name": "pikachu",
  "height": 4,
  "weight": 60,
  "sprites": {
    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
  }
}


## Trouble Shooting
- 네비게이션 기능을 사용할 때 배경 색을 지정해주지 않아 다음 화면에 이전 화면의 글씨들이 잠깐 겹쳤다가 사라짐
  -> 적용 화면 viewDidLoad()에 'self.view.backgroundColor = .white' 코드 추가함
- View Lifecycle을 고려하지 않아 적용 버튼을 누르고 돌아갔을 때 방금 저장한 데이터가 뜨지 않음
  -> viewDidLoad()에 작성했던 코드를 viewWillAppear()에 작성함
- 데이터를 저장하고 메인 화면으로 돌아가면 이전에 저장했던 데이터들이 보이지 않음
  -> 적용 화면 viewDidLoad()에 'phoneNumberData.loadContacts()'를 추가함


## 추가하면 좋을 기능
- textView에 입력 가능한 값 제한 두기
- 입력 저장 조건을 만족하지 못해서 적용 버튼이 안눌릴 때 안내 alert창 띄워주기
- 메인화면으로 돌아왔을 때 이름 순으로 정렬되게 하기
- 이미 저장된 데이터를 눌렀을 때 다시 편집할 수 있는 페이지로 연결되고 업데이트 가능하기
- 포켓몬 이미지가 큰 경우에도 원 밖을 벗어나지 않도록 하기
  
