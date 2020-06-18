/*Napisati složeni PL/SQL izveštaj zasnovan na podacima u relacionoj bazi podataka koji
podrazumeva koriš?enje promenljivih tipa BIND, parametrizovanih kursora, indeksnih
tabela, slogova i ispisa na ekran.*/

--prikaz detaljne statistike u vezi svih misija
--koristi se parametrizovan krusor za dobavljanje svih podataka o misijama koji se onda tip sloga
--ti slogovi se skladiste u tabeli
--koriste se i pomocne promenljive za razlicite statistike
--koristi se i pogled iz Dela_e_sql prilikom racunanja sve_misije_km
accept dp_input prompt 'Unesite pocetni datum(DD.MM.YYYY): ';
accept dz_input prompt 'Unesite zavrsni datum(DD.MM.YYYY): ';
declare
    type MISIJE_INFO is record(
        v_idm misija.idm%type,
        v_nam misija.nam%type,
        v_dpo misija.dpo%type,
        v_dza misija.dza%type,
        v_nao odrediste.nao%type,
        v_tinv kompmis.inv%type,
        v_km odrediste.uda%type
    );
    m_info MISIJE_INFO;
    
    cursor c_misije(
        d_po misija.dpo%type,d_za misija.dza%type
    )is
    select m.idm,m.nam,m.dpo,m.dza,o.nao,
    (select sum(inv) from kompmis km where m.idm=km.idm group by km.idm),o.uda
    from misija m inner join odrediste o on m.ido=o.ido
    where m.dpo >= d_po and m.dza <= d_za or m.dza is null group by m.idm, m.nam, m.dpo, m.dza, o.nao, o.uda;
       
    type T_Misije is TABLE of MISIJE_INFO index by binary_integer;
    tabela_misije T_Misije;
    
    v_count integer :=0; --broj rezultata  
    i integer :=0;
    ukupno_invesiticja decimal(16, 2):=0;
    ukupno_km decimal(16, 2):=0;
    sve_misije_km odrediste_br_misija.ukupno_km%type := 1;
begin
    open c_misije(to_date('&dp_input','DD.MM.YYYY'),to_date('&dz_input','DD.MM.YYYY'));
    loop 
        fetch c_misije into m_info;
        exit when (c_misije%notfound);
        tabela_misije(v_count) := m_info;
        v_count := v_count + 1;  
        ukupno_invesiticja := ukupno_invesiticja + m_info.v_tinv;
        ukupno_km := ukupno_km + m_info.v_km;
    end loop;
    
    if v_count = 0 then
        dbms_output.put_line('U periodu od ' || '&dp_input' || ' do ' || '&dz_input' || ' nije bilo misija!');
    else
        select sum(obm.ukupno_km) into sve_misije_km from odrediste_br_misija obm; --koriscenje pogleda iz prethodnog dela e sql
        dbms_output.put_line('Podaci o misijama za period od ' || '&dp_input' || ' do ' || '&dz_input');
        dbms_output.put_line('U Misije je u ovom periodu ukupno investirano $'|| ukupno_invesiticja);
        dbms_output.put_line('U ovom periodu misije ce preci '|| ukupno_km || 'km'); 
        dbms_output.put_line('  sto predstavlja '|| round(ukupno_km/sve_misije_km*100,2) || '% '); 
        dbms_output.put_line('  u odnosu na broj kilometara koliko ce sve misije covecanstva preci u svemiru i koji iznosi '
                            ||sve_misije_km || 'km.'); 
        i:=tabela_misije.first;
        while i <= tabela_misije.last loop
            m_info := tabela_misije(i);
            dbms_output.put_line('');
            dbms_output.put_line('Naziv misije: ' || m_info.v_nam);
            dbms_output.put_line('Odrediste: '|| m_info.v_nao);
            dbms_output.put_line('Datum pocetka misije: '|| to_char(m_info.v_dpo));
            if m_info.v_dza is null then
                dbms_output.put_line('Datum zavrsetka misije: '|| 'Misija nije zavrsena');
            else
                dbms_output.put_line('Datum zavrsetka misije: '|| to_char(m_info.v_dza));
            end if;
            dbms_output.put_line('Ukupna investicija u misiju: '|| m_info.v_tinv);         
            dbms_output.put_line('Udaljenost: '|| m_info.v_km || 'km');   
            dbms_output.put_line('Kompanije koje ucestvuju u misiji:'); 
            for komp in (select k.nak,km.inv from kompanija k inner join kompmis km on k.idk=km.idk where km.idm = m_info.v_idm) loop
                dbms_output.put_line('      ' || komp.nak || ' sa investicijom: $' || komp.inv);             
            end loop;
            i:=tabela_misije.next(i);
        end loop;
    end if;
end;