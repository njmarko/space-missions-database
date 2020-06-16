CREATE TABLE kompanija(
	 Idk integer NOT NULL,
	 Nak varchar(30) NOT NULL,
	 Bud decimal(13, 2),
	 CONSTRAINT kompanija_PK PRIMARY KEY (Idk),
	 CONSTRAINT radnik_FK FOREIGN KEY (Sef) REFERENCES Radnik (Mbr),
     	 CONSTRAINT radnik_CH  UNIQUE (Nap)
);


CREATE TABLE odrediste
	(
	 Ido integer  NOT NULL,
	 Nao varchar(30),
	 Uda decimal(14, 2),
	 CONSTRAINT odrediste_PK PRIMARY KEY (Ido),
     CONSTRAINT odrediste_CH CHECK (Uda>=100) -- 100 km je Karmanova linija koja razgranicava zemljinu atmosferu od svemira
);

CREATE TABLE misija(
	 Idm integer NOT NULL,
	 Nam varchar(30) NOT NULL,
     Ido integer  NOT NULL,
     Dpo date NOT NULL,
     Dza date,     
	 CONSTRAINT misija_PK PRIMARY KEY (Idm),
	 CONSTRAINT misija_FK FOREIGN KEY (Ido) REFERENCES Odrediste (Ido),
     CONSTRAINT radnik_CH  UNIQUE (Nam)
);


CREATE TABLE radproj
	(
	 Spr integer NOT NULL,
	 Mbr integer NOT NULL,
	 Brc integer NOT NULL,
	 CONSTRAINT radproj_PK PRIMARY KEY (Spr, Mbr),
	 CONSTRAINT radproj_rad_FK FOREIGN KEY (Mbr) REFERENCES radnik(Mbr),
	 CONSTRAINT radproj_prj_FK FOREIGN KEY (Spr) REFERENCES projekat(Spr)
);