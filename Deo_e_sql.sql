--1. primer izmene definicije odabrane tabele. Budzet ne sme biti null, i default vrednost je 0
alter table kompanija
modify bud decimal(15, 2) default 0 not null;
--uvecan broj karaktera na 50 kod naziva misije
alter table misija
modify nam varchar(50) NOT NULL;

--2. uvecanje budzeta kompanija. Prvo budzed uvecaju nasa i spacex pre izbijanja korone, a druge kompanije pokusaju da ih sustignu.
-- Zbog izbijanja korone i finansijskih poteskoca, ostale kompanije moraju da vrate budzet na staru vrednost
update  kompanija 
set bud = bud*1.10 where nak in ('NASA','SpaceX');
savepoint izbijanje_epidemije;
update kompanija
set bud = bud * 1.15 where nak not in ('NASA','SpaceX');
rollback to izbijanje_epidemije; --zbog krize moraju da se vrate budzeti
update  kompanija --spacex dobija poslove u doba krize pa moze da uveca budzet; Kinezi su prebrodili koronu i zele da pariraju Americi
set bud = bud*1.15 where nak in ('SpaceX','CNSA'); 
commit;


--3. primer prostog upita gde se traze kompanije koje sadrze rec space u nazivu (case insensitive), koje se zavrsavaju na rec 
--cosmos ili koje imaju slovo S na drugom mestu u umenu
--i sortirane su po rastucem leksikografskom poretku
select idk as "Id kompanije",nak as "Naziv kompanije",to_char(bud/1000000000,'L9999990.99') as "Budzet u milijardama dolara" 
from kompanija where lower(nak) like '%space%' or lower(nak) like '%cosmos' or lower(nak) like '_s%'
order by nak asc;

--4. primer ugnjezdenog upita sa skupovnim operacijama
--koje kompanije su ucestvovale u svemirskoj trci u periodu od 1955 do 1975 godine
select idk as "Id kompanije",nak as "Naziv kompanije",to_char(bud/1000000000,'L9999990.99')as "Budzet u milijardama dolara"  from kompanija 
where idk in (select idk from kompmis where idm 
in (select idm from misija where dpo >= '01-jan-1955'
intersect select idm from misija where dza <= '31-dec-1975' ));

--kompanije koje su investirale u pojedinacne misije ne vise od milijardu dolara,
--ili koje uopste nisu investirale u svemirske misije do sada
select idk as "Id kompanije",nak as "Naziv kompanije",to_char(bud/1000000000,'L9999990.99')as "Budzet u milijardama dolara"  
from kompanija 
where idk in (select unique idk from kompmis where inv <=1000000000)
minus
select idk as "Id kompanije",nak as "Naziv kompanije",to_char(bud/1000000000,'L9999990.99')as "Budzet u milijardama dolara"  
from kompanija 
where idk in (select unique idk from kompmis where inv >1000000000)
union
select idk as "Id kompanije",nak as "Naziv kompanije",to_char(bud/1000000000,'L9999990.99')as "Budzet u milijardama dolara"  
from kompanija where idk not in (select unique idk from kompmis);


--5. Primer visestrukog unutrasnjeg spajanja tabela
--prikazuju se relevantni podaci o kompanijama koje ucestvuju u misijama
--prikaz je sortiran po nazivu misije i visini investicije kompanije u datu misiju
select m.nam as "Naziv misije" ,k.nak as "Naziv kompanije",km.inv as "Investicija",o.nao as "Odrediste"
from kompanija k inner join kompmis km on k.idk =km.idk
inner join misija m on km.idm=m.idm
inner join odrediste o on m.ido=o.ido
order by m.nam asc,km.inv desc;


--6. primer grupisanja podataka uz koriš?enje agregacionih funkcija i filtriranja dobijenih grupa
--grupisanje misija i racunanje sume svih investicija 
--kod kojih je ukupna ulozena suma novca veca od prosecne ulozene sume novca u misije
select km.idm as "Id misije",m.nam as "Naziv misije",sum(inv) as "Ukupno investirano" from kompmis km
join misija m on m.idm = km.idm
group by km.idm,m.nam
having sum(inv)>=(select avg(sum(inv)) from kompmis group by idm)
order by sum(inv);

--pronalazenje misije u koju je investiralo najvise kompanija
select km.idm as "Id misije",m.nam as "Naziv misije",count(inv) as "Broj investicija" from kompmis km
join misija m on m.idm = km.idm
group by km.idm,m.nam
having count(inv)>=(select max(count(inv)) from kompmis group by idm);

--7. primer upotrebe SQL klauzule WITH i spajanja tabela
-- Za svaku kompaniju angazovanu na projektu, odrediti broj ostalih kompanija angazovanih na projektu
with misija_info as(
select km.idm,m.nam as naziv_misije,count(km.idk) as komp_broj
from kompmis km inner join misija m on km.idm=m.idm
group by km.idm,m.nam)
select k.idk as "Id kompanije",k.nak as "Naziv kompanije",km.idm as "Id misije",
mi.naziv_misije as "Naziv misije",mi.komp_broj - 1 "Broj ostalih kompanija"
from kompanija k,kompmis km,misija_info mi
where k.idk=km.idk and km.idm=mi.idm
order by k.idk,km.idm;

--8. primer kreiranja pogleda uz koriš?enje spoljašnjeg spajanja tabela
-- Pogled koji prikazuje informacije o odredistu, kao i broj misija za to odrediste
create or replace view odrediste_br_misija(Ido,Nao,Uda,br_misija,ukupno_km) as
select o.ido,o.nao,o.uda,count(m.ido),o.uda*count(m.ido)
from odrediste o left outer join misija m on o.ido=m.ido
group by o.ido,o.nao,o.uda;

--primer upotreba pogleda za racunanje ukupne kilometraze na svim misijama
select sum(obm.ukupno_km) as "Ukupno predjeno km" from odrediste_br_misija obm;




