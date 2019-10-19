# CLIK

* CLIK은 클라우드 플랫폼 내 교육용 인스턴스 그룹 간, 채점용 서버와 클라이언트 스크립트를 제공합니다.

* **커널 레벨에서 동작하는 소프트웨어** 과제물같이, 실행 가능하지만, **제출 및 채점이 어려운** 과제물을 채점할 수 있습니다.


## 사용법

```
 Usage : ./clikSetAndStart.sh [options] Assignment_name  

 Options:
	-t  Examinate Total grading and capture the result 
  	-b  Background judge and use parrallel computing (faster operation).
	-h  Help(usage)

```
### 사용예시

**(서버 - 교수자)**

1. Openstack의 수업용 인스턴스 그룹의 서버인스턴스에서 clone
2. grading_clik.sh 에서 학생용 클라이언트의 IP주소 범위를 지정 (기본 - 192.168.0.2 ~ 192.168.0.255)
3. config.ini파일에 과제의 이름과 채점스크립트 경로를 등록
4. CLIK 디렉토리에서 다음 구문을 수행합니다.


* 클라이언트에게 과제 채점 요청 스크립트를 전달합니다. 
```
./clikSetAndStart.sh Assignment_name
```

* 채점용 서버를 구동시킵니다 
```
./clikSetAndStart.sh -s
```
* 클라이언트 인스턴스를 대상으로 채점을 수행하고 결과를 수집합니다.
```
./clikSetAndStart.sh -t 
```
4. CLIK/data 폴더에서 인스턴스 이름별로 정리된 데이터를 확인합니다.
.


**(클라이언트 - 학생)**

1. 홈 디렉터리에 제출한 과제물을 위치시킵니다.
2. 홈 디렉터리에서 서버에 채점을 요청합니다.
```
./request.sh
```



### Refactor,Update.. TODO : 업데이트 예정 - (Sep 26~  2019)

- [x] CLIK시스템 세팅파일 작성 및 시스템 연동하기.  (sep 26 2019)
- [x] 서버 종료스크립트 (sep 27 2019)
- [x] 채점모듈 리팩토링 (oct 17 2017)
- [x] 네트워크 탐색 및 채점 병렬수행 & 동기화문제 해결 (oct 20 2019)
- [ ] 사용법,문제 추가 방법등을 README에 정리.  
- [ ] 실행 시 관계 흐름도
- [ ] 서버코드 리팩토링
- [ ]  테스트케이스 추가 자동화
