drop table kompmis;
drop table misija;
drop table odrediste;
drop table kompanija;

CREATE TABLE kompanija(
	 Idk integer NOT NULL, --id
	 Nak varchar(30) NOT NULL, --naziv kompanije
	 Bud decimal(15, 2), --budzet kompanije
	 CONSTRAINT kompanija_PK PRIMARY KEY (Idk),
     CONSTRAINT kompanija_CH  UNIQUE (Nak) --unikatan naziv
);


CREATE TABLE odrediste
	(
	 Ido integer  NOT NULL, --id
	 Nao varchar(30), --naziv odredista
	 Uda decimal(15, 2), --udaljenost od zemljine povrsine
	 CONSTRAINT odrediste_PK PRIMARY KEY (Ido),
     CONSTRAINT odrediste_CH CHECK (Uda>=100) -- 100 km je Karmanova linija koja razgranicava zemljinu atmosferu od svemira
);

CREATE TABLE misija(
	 Idm integer NOT NULL, --id
	 Nam varchar(30) NOT NULL, -- naziv misije
     Ido integer  NOT NULL, -- id odredista
     Dpo date NOT NULL, --datum polaska
     Dza date,     --datum zavrsetka
	 CONSTRAINT misija_PK PRIMARY KEY (Idm), 
	 CONSTRAINT misija_FK FOREIGN KEY (Ido) REFERENCES Odrediste (Ido),
     CONSTRAINT misija_CH  UNIQUE (Nam) --unikatan naziv
);


CREATE TABLE kompmis
	(
	 Idk integer NOT NULL, --id kompanije
	 Idm integer NOT NULL, --id misije
	 Inv decimal(15, 2), --investicija kompanije u misiju
	 CONSTRAINT kompmis_PK PRIMARY KEY (Idk, Idm),
	 CONSTRAINT kompmis_idk_FK FOREIGN KEY (Idk) REFERENCES Kompanija(Idk),
	 CONSTRAINT kompmis_idm_FK FOREIGN KEY (Idm) REFERENCES Misija(Idm)
);