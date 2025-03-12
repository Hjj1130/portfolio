# portfolio

#main document
- 포트폴리오_정현중.pptx 



#참고자료

[데이터이관]

- 관련파일

  - portfolio/데이터이관/이관작업계획서.xlsx
    - UNIX to linux, 버전 업그레이드를 위한 export/import 이관 방식을 사용

  - portfolio/데이터이관/전환프로그램목록.xlsx
    - 이관작업계획서.xlsx에 있는 프로그램에 대한 간단한 설명자료

  - portfolio/데이터이관/scripts
    - shell script 중 일부 정보 replace 수행. replace 불가한 script는 삭제.


[백업복구&HA구성]

- 관련파일
  - portfolio/백업복구&HA구성/HA테스트결과보고서.pptx
    - 일부 정보 replace 수행. 스크린샷 삭제.

  - portfolio/백업복구&HA구성/백업복구_테스트_작업계획서.xlsx
    - 백업/복구(point-in-time) 테스트 작업계획서 


[자동화]

- 관련파일
  - portfolio/자동화/table_profile.xlsx
    - '01_CONNECTION_INFO' 시트 : SAP HANA 접속정보 등록
    - '02_DATA_TYPE_LIST' 시트 : 각 data type 별 수행할 집계힝목 지정. "O"로 표시된 집계항목만 수행.
    - '03_SQL_LIST' : 집계항목별 실제 수행 SQL 정의
    - '04_RESULT_TABLE' : get_table_info2.py 수행결과 저장. 일부 데이터 replace 수행. replace 미수행 데이터 삭제.

  - portfolio/자동화/get_table_info2.py
    - table_profile.xlsx에 정의된 내용을 기반으로 table/column 정보 수집

  - portfolio/자동화/이관_검증_ASE.xlsm
    - '매트로' 시트
      - source/target 접속정보 등록. 
      - 'DB name 가져오기' : userdb 정보 수집하여 특정 DB에 대한 정보만 선택 가능, 수행하지 않을경우 모든 userdb에 대해서 정보 수집.
      - 각 매크로 수행 : '매크로명_검증' 시트와 '매크로명_검증오류' 시트에 결과값 생성
        - '매크로명_검증' : 모든 데이터에 대해서 비교 검증내용 저장
        - '매크로명_검증오류' : 검증오류 발생한 내용만 발췌하여 저장

  - portfolio/자동화/이관_검증_ASE.xlsm
    - oracle 기준으로 작성된 일일점검 자동화 항목에 대해서 SAP DBMS 점검내용 작성

  - portfolio/자동화/점검 스크립트 예시_sm.sh
    - 일일점검 자동화 관련 스크립트 작성 예

  - portfolio/자동화/타사사례_dbspace_사용률_관제용.sh
    - dbspace 사용률 정보 파일로 작성 예제
