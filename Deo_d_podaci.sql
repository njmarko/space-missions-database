--Prvo napravim sekvence za kljuceve tabela
drop sequence SEQ_Idk;
drop sequence SEQ_Idm;
drop sequence SEQ_Ido;
create sequence SEQ_Idk
    increment by 10
    start with 10
    nocycle
    cache 10;
create sequence SEQ_Idm
    increment by 10
    start with 10
    nocycle
    cache 10;
create sequence SEQ_Ido
    increment by 10
    start with 10
    nocycle
    cache 10;
    

--dodavanje podataka o kompanijama (idk,nak,bud)
insert into kompanija values (SEQ_Idk.nextval, 'SpaceX',      36000000000.00);
insert into kompanija values (SEQ_Idk.nextval, 'Blue Origin', 25000000000.00);
insert into kompanija values (SEQ_Idk.nextval, 'Boeing',      30000000000.00);
insert into kompanija values (SEQ_Idk.nextval, 'NASA',        50000000000.00);
insert into kompanija values (SEQ_Idk.nextval, 'Roscosmos',   11000000000.00); --Rusija
insert into kompanija values (SEQ_Idk.nextval, 'JAXA',        10000000000.00); --Japan
insert into kompanija values (SEQ_Idk.nextval, 'ESA',         6000000000.00); --Evropa
insert into kompanija values (SEQ_Idk.nextval, 'CNSA',        13000000000.00); --Kina
insert into kompanija values (SEQ_Idk.nextval, 'ISRO',        9000000000.00); --Indija
insert into kompanija values (SEQ_Idk.nextval, 'SERBSPACE',  100000000.00);
insert into kompanija values (SEQ_Idk.nextval, 'CSA',        10000000000.00); --Kanada

--dodavanje podataka o odredistima (ido,nao,uda)
insert into odrediste values (SEQ_Ido.nextval, 'Merkur',   77000000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Venera',   38000000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Mesec',    384000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Mars',     38600000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Dejmos',   38577000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Fobos',    38591000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Fobos',    38591000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Cerera',   239000000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Jupiter',  588000000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Evropa',   587330000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Io',      587580000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Ganimed', 586928000.00);
insert into odrediste values (SEQ_Ido.nextval, 'Kalisto', 586117300.00);
insert into odrediste values (SEQ_Ido.nextval, 'ISS',     408.00);

--dodavanje podataka o misijama (idm, nam,ido,dpo,dza)
insert into misija values (SEQ_Idm.nextval, 'Apolo 11',30,'16-jul-1969','24-jul-1969');
insert into misija values (SEQ_Idm.nextval, 'Crew Dragon Demo 2',130,'30-may-2020',NULL);
insert into misija values (SEQ_Idm.nextval, 'Artemis',30,'12-jun-2024',NULL);
insert into misija values (SEQ_Idm.nextval, 'Change 3',30,'02-dec-2013','14-dec-2013');
insert into misija values (SEQ_Idm.nextval, 'Change 4',30,'07-dec-2018','03-jan-2018');
insert into misija values (SEQ_Idm.nextval, 'Change 8',30,'07-dec-2027',NULL);
insert into misija values (SEQ_Idm.nextval, 'dearMoon',30,'11-oct-2023',NULL);
insert into misija values (SEQ_Idm.nextval, 'Luna 2',30,'12-sep-1959','14-sep-1959');
insert into misija values (SEQ_Idm.nextval, 'Mariner 4',40,'28-nov-1964','21-dec-1967');
insert into misija values (SEQ_Idm.nextval, 'Mars 3',40,'28-may-1971','2-dec-1971');
insert into misija values (SEQ_Idm.nextval, 'Opportunity',40,'08-jul-2003','13-feb-2019');
insert into misija values (SEQ_Idm.nextval, 'Venera 8',20,'27-mar-1972','22-jul-1972');
insert into misija values (SEQ_Idm.nextval, 'Europa Clipper',90,'13-mar-2024',NULL);
insert into misija values (SEQ_Idm.nextval, 'ISS programme',130,'13-mar-2024',NULL);

--dodavanje podataka o kompanijama koje ucestvuju u misijama (Idk,Idm,Inv)
insert into kompmis values (40, 10,25400000000);
insert into kompmis values (10, 20,40000000);
insert into kompmis values (40, 20,160000000);
insert into kompmis values (10, 30,1000000000);
insert into kompmis values (40, 30,35000000000);
insert into kompmis values (80, 40,180000000);
insert into kompmis values (80, 50,172000000);
insert into kompmis values (80, 60,200000000);
insert into kompmis values (10, 70,90000000);
insert into kompmis values (50, 80,150000000);
insert into kompmis values (40, 90,83200000);
insert into kompmis values (50, 100,120000000);
insert into kompmis values (40, 110,1000000000);
insert into kompmis values (50, 120,110000000);
insert into kompmis values (40, 130,1130000000);
insert into kompmis values (40, 140,58700000000);
insert into kompmis values (50, 140,12000000000);
insert into kompmis values (70, 140,5000000000);
insert into kompmis values (60, 140,5000000000);
insert into kompmis values (110, 140,2000000000);

commit;