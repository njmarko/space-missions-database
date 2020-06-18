--primer ispravnog unosa sa svim ispravnim vrednostima
insert into misija values(150,'Test trigera 1 ispravan', 10,'11-jan-2018','12-jan-2018');

--primer ispravnog unosa sa naizgled neispravnim kljucem. Triger ce ga zameniti sa sledecim kljucem u sekvenci
insert into misija values(-42,'Test trigera 2 dodeljen kljuc', 10,'11-jan-2018','12-jan-2018');

--primer ispravnog unosa gde je datum zavrsetka null i kljuc vec postoji
insert into misija values(10,'Test trigera 3 dzo null', 10,'11-jan-2018',null);

--primer NEISPRAVNOG unosa gde datum pocetka dolazi nakon datuma zavrsetka
insert into misija values(180,'Test trigera 4 greska datumi', 10,'11-jan-2018','5-jan-2018');

--primer NEDOZVOLJENOG azuriranja kljuca
update misija m
set idm=42
where m.idm = 10;

--primer NEISPRAVNOG azuriranja datuma pocetka
update misija m
set dpo='27-JUL-1969'
where m.idm = 10;

--primer ispravnog azuriranja datuma pocetka kada je datum zavrsetka null
update misija m
set dpo='19-JUN-2020'
where m.idm = 20;

--primer ispravnog azuriranja datuma zavrsetka na null
update misija m
set dza=null
where m.idm = 10;

--primer NEISPRAVNOG azuriranja datuma zavrsetka
update misija m
set dza='1-JUL-1945'
where m.idm = 10;

--primer ispravnog azuriranja datuma pocetka i zavrsetka
update misija m
set dpo= '22-JUN-1945',dza='1-JUL-1945'
where m.idm = 10;

--primer NEISPRAVNOG azuriranja datuma pocetka i zavrsetka
update misija m
set dpo= '22-JUN-2020',dza='1-JUL-1945'
where m.idm = 10;


rollback;