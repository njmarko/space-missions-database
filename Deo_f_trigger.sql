/*triger tipa ROW-LEVEL koji name?e neko smisleno, netrivijalno ograni?enje nad
podacima u relacionoj bazi podataka.*/

--triger koji se kativira prilikom dodavanja nove misije ili prilikom azuriranja
--polja idm,dpo,dza. Ovaj trigger ne dozvoljava da datum pocetka dodje nakon datuma zavrsetka
--Trigger takodje dodeljuje vrednost kljuca pomocu sekvence i ne dozvoljava izmenu kljuca
create or replace trigger tr_misija_INSUPD_idm
before insert or update of idm,dpo,dza
on misija
for each row
begin
    if inserting then
        --uvek se dodeljuje sledeci kljuc u sekvenci nezavisno od toga sta je korisnik uneo
        select SEQ_Idm.nextval into :new.idm from sys.dual; -- dual tabela je dummy tabela
        if(:new.dpo > :new.dza) then
            RAISE_APPLICATION_ERROR(-20000, 'Nije uneta misija zato sto je datum pocetka misije nakon datuma zavrsetka misije.');
        end if;
    elsif updating ('idm') then
        RAISE_APPLICATION_ERROR(-20000, 'Nije dozvoljeno azuriranje kljuca misije.');
    elsif updating ('dza') and updating ('dpo') then
        if(:new.dpo > :new.dza) then
            RAISE_APPLICATION_ERROR(-20000, 'Nisu azurirani datumi zato sto novi datum pocetka misije dolazi nakon novo datuma zavrsetka misije.');       
        end if;    
    elsif updating ('dpo') then
        if(:new.dpo > :old.dza) then
            RAISE_APPLICATION_ERROR(-20000, 'Nije azuriran datum pocetka misije zato sto dolazi posle datuma zavrsetka misije.'); 
        end if;
    elsif updating ('dza') then
        if(:old.dpo > :new.dza) then
            RAISE_APPLICATION_ERROR(-20000, 'Nije azuriran datum zavrsetka misije zato sto dolazi pre datuma pocetka misije.');       
        end if;
    end if;
    if updating ('idm') then
        RAISE_APPLICATION_ERROR(-20000, 'Nije dozvoljeno azuriranje kljuca misije.');
    end if;
end tr_misija_INSUPD_idm;

