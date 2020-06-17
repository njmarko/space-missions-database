--1. dodavanje ogranicenja za tabelu kompanija. Budzet ne sme biti null, i default vrednost je 0
alter table kompanija
modify bud decimal(15, 2) default 0 not null;

--2. uvecanje budzeta kompanija. Prvo budzed uvecaju nasa i spacex pre izbijanja korone, a druge kompanije pokusaju da ih sustignu.
-- Zbog izbijanja korone i finansijskih poteskoca, ostale kompanije moraju da vrate budzet na staru vrednost
update  kompanija 
set bud = bud*1.10 where nak in ('NASA','SpaceX');
savepoint izbijanje_epidemije;
update kompanija
set bud = bud * 1.15 where nak not in ('NASA','SpaceX');
rollback to izbijanje_epidemije; --zbog krize moraju da se vrate budzeti
update  kompanija --spacex dobija poslove udoba krize pa moze da uveca budzet; Kinezi su prebrodili koronu i zele da pariraju Americi
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
select m.nam as "Naziv misije" ,k.nak as "Naziv kompanije",km.inv,o.nao
from kompanija k inner join kompmis km on k.idk =km.idk
inner join misija m on km.idm=m.idm
inner join odrediste o on m.ido=o.ido
order by m.nam asc,km.inv desc;
