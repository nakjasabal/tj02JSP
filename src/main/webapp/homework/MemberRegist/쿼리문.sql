/******
과제 : 회원가입 페이지 작성하기
*******/

--테이블 생성하기 
create table regist_member (
    id varchar2(30) primary key,
    pass varchar2(30) not null,
    name varchar2(30) not null,
    email varchar2(100) not null,
    mailing varchar2(1) ,
    zipcode varchar2(5) ,
    addr1 varchar2(100) ,
    addr2 varchar2(200) ,
    mobile varchar2(15) not null,
    sms varchar2(1) 
);
--회원 레코드 입력하기 
insert into regist_member values (
    'tjoeun','1234','더조은','tj@naver.com','Y','12345',
    '서울시 종로구','대왕빌딩9층','010-1234-5678','N'
);
commit;

--아이디 중복확인 하기 
select count(*) from regist_member where id='tjoeun';
select count(*) from regist_member where id='aaaaaaaa';

