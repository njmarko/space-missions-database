--dodavanje podataka o kompanijama (idk,nak,bud)
insert into kompanija values (10, 'SpaceX',      36000000000.00);
insert into kompanija values (20, 'Blue Origin', 25000000000.00);
insert into kompanija values (30, 'Boeing',      30000000000.00);
insert into kompanija values (40, 'NASA',        50000000000.00);
insert into kompanija values (50, 'Roscosmos',   11000000000.00); --Rusija
insert into kompanija values (60, 'JAXA',        10000000000.00); --Japan
insert into kompanija values (70, 'ESA',         6000000000.00); --Evropa
insert into kompanija values (80, 'CNSA',        13000000000.00); --Kina
insert into kompanija values (90, 'ISRO',        9000000000.00); --Indija
insert into kompanija values (100, 'SERBSPACE',  100000000.00);
insert into kompanija values (110, 'CSA',        10000000000.00); --Kanada

--dodavanje podataka o odredistima (ido,nao,uda)
insert into odrediste values (10, 'Merkur',   77000000.00);
insert into odrediste values (20, 'Venera',   38000000.00);
insert into odrediste values (30, 'Mesec',    384000.00);
insert into odrediste values (40, 'Mars',     38600000.00);
insert into odrediste values (50, 'Dejmos',   38577000.00);
insert into odrediste values (50, 'Fobos',    38591000.00);
insert into odrediste values (60, 'Fobos',    38591000.00);
insert into odrediste values (70, 'Cerera',   239000000.00);
insert into odrediste values (80, 'Jupiter',  588000000.00);
insert into odrediste values (90, 'Evropa',   587330000.00);
insert into odrediste values (100, 'Io',      587580000.00);
insert into odrediste values (110, 'Ganimed', 586928000.00);
insert into odrediste values (120, 'Kalisto', 586117300.00);
insert into odrediste values (130, 'ISS',     408.00);

--dodavanje podataka o misijama (idm, nam,ido,dpo,dza)
insert into misija values (10, 'Apolo 11',30,'16-jul-1969','24-jul-1969');
insert into misija values (20, 'Crew Dragon Demo 2',130,'30-may-2020',NULL);
insert into misija values (30, 'Artemis',30,'12-jun-2024',NULL);
insert into misija values (40, 'Change 3',30,'02-dec-2013','14-dec-2013');
insert into misija values (50, 'Change 4',30,'07-dec-2018','03-jan-2018');
insert into misija values (60, 'Change 8',30,'07-dec-2027',NULL);
insert into misija values (70, 'dearMoon',30,'11-oct-2023',NULL);
insert into misija values (80, 'Luna 2',30,'12-sep-1959','14-sep-1959');
insert into misija values (90, 'Mariner 4',40,'28-nov-1964','21-dec-1967');
insert into misija values (100, 'Mars 3',40,'28-may-1971','2-dec-1971');
insert into misija values (110, 'Opportunity',40,'08-jul-2003','13-feb-2019');
insert into misija values (120, 'Venera 8',20,'27-mar-1972','22-jul-1972');
insert into misija values (130, 'Europa Clipper',90,'13-mar-2024',NULL);
insert into misija values (140, 'ISS programme',130,'13-mar-2024',NULL);

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
