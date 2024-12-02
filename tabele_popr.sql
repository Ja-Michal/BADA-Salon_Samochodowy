/*
created: 25.11.2024
modified: 27.11.2024
project: salon samochodowy
model: model logiczny
author: michal bogusz i mateusz kowalczuk
database: oracle 18c
*/


-- create tables section -------------------------------------------------

-- table salony_samochodowe

create table salony_samochodowe(
  id_salonu integer PRIMARY KEY,
  nazwa varchar2(30 ) not null
)
/
-- table pracownicy

create table pracownicy(
  id_pracownika integer PRIMARY KEY,
  imie varchar2(20 ) not null,
  nazwikso varchar2(30 ) not null,
  pesel char(11 ),
  numer_telefonu varchar2(15 ) not null,
  stanowisko varchar2(30 ) not null,
  wynagrodzenie number(10,2) not null,
  id_salonu integer not null,
  id_placowki integer,
  foreign key (id_salonu) references salony_samochodowe(id_salonu),
  foreign key (id_placowki) references placowki(id_placowki)
)
/

-- create indexes for table pracownicy

create index ix_jest_pracownikiem_salonu on pracownicy (id_salonu)
/

create index ix_pracuje_w_placowce on pracownicy (id_placowki)
/


-- table samochody

create table samochody(
  id_samochodu integer PRIMARY KEY,
  numer_rejestracyjny varchar2(8 ) not null,
  data_produkcji date not null,
  przebieg integer not null,
  waznosc_przegladu date not null,
  stan_techniczny varchar2(30 ) not null
        check (-stan_techniczny in ('nowy', 'dobry', 'akceptowalny', 'wymaga serwisu')),
  czy_powypadkowy char(1) not null,
  cena_wynajmu number(10,2),
  cena_sprzedazy number(10,2),
  id_placowki integer,
  id_klienta integer not null,
  id_salonu integer not null,
  id_modelu integer not null,
  foreign key (id_placowki) references placowki(id_placowki),
  foreign key (id_klienta) references klienci(id_klienta),
  foreign key (id_salonu) references salony_samochodowe(id_salonu),
  foreign key (id_modelu) references modele(id_modelu)
)
/

-- create indexes for table samochody

create index ix_placówka_posiada_samochody on samochody (id_placowki)
/

create index ix_samochod_jest_kupiony on samochody (id_klienta)
/

create index ix_salon_posiada_samochody on samochody (id_salonu)
/

create index ix_samochod_jest_danego_modelu on samochody (id_modelu)
/


-- table klienci

create table klienci(
  id_klienta integer PRIMARY KEY,
  imie varchar2(20 ) not null,
  nazwisko varchar2(30 ) not null,
  numer_telefonu varchar2(15 ) not null,
  id_salonu integer not null,
  foreign key (id_salonu) references salony_samochodowe(id_salonu)
)
/

-- create indexes for table klienci

create index ix_jest_klientem_salonu on klienci (id_salonu)
/




-- table serwisy

create table serwisy(
  id_serwisu integer PRIMARY KEY,
  data_rozpoczecia date not null,
  koszt number(10,2) not null,
  opis varchar2(1000 ) not null,
  id_samochodu integer not null,
  id_placowki integer not null,
  id_klienta integer,
  foreign key (id_samochodu) references samochody(id_samochodu),
  foreign key (id_placowki) references placowki(id_placowki),
  foreign key (id_klienta) references klienci(id_klienta)
  
)
/

-- create indexes for table serwisy

create index ix_samochod_jest_serwisowany on serwisy (id_samochodu)
/

create index ix_ma_serwisowany_samochod on serwisy (id_klienta)
/

create index ix_serwis_odbywa_sie_w_placowce on serwisy (id_placowki)
/

-- table placowki

create table placowki(
  id_placowki integer PRIMARY KEY,
  nazwa varchar2(30 ) not null,
  id_salonu integer not null,
  foreign key (id_salonu) references salony_samochodowe(id_salonu)
)
/

-- create indexes for table placowki

create index ix_posiada_placowke on placowki (id_salonu)
/

-- table punkty_handlowe

create table punkty_handlowe(
  czy_wynajem char(1 ) not null,
  czy_sprzedaz char(1 ) not null,
  czy_uzywane char(1 ) not null,
  id_placowki integer PRIMARY KEY,
  foreign key (id_placowki) references placowki(id_placowki)
)
/


-- table warsztaty

create table warsztaty(
  liczba_stanowisk integer not null,
  czy_wymiana_opon char(1 ) not null,
  id_placowki integer PRIMARY KEY,
  foreign key (id_placowki) references placowki(id_placowki)
)
/


-- table przydzialy_serwisowe

create table przydzialy_serwisowe(
  id_pracownika integer not null,
  id_serwisu integer not null,
  primary key(id_pracownika, id_serwisu),
  foreign key (id_pracownika) references pracownicy(id_pracownika),
  foreign key (id_serwisu) references serwisy(id_serwisu)
)
/

-- table klienci_placowki

create table klienci_placowki(
  id_placowki integer not null,
  id_klienta integer not null,
  primary key(id_placowki, id_klienta),
  foreign key (id_placowki) references placowki(id_placowki),
  foreign key (id_klienta) references klienci(id_klienta)
)
/

-- table transakcje

create table transakcje(
  id_samochodu integer not null,
  id_klienta integer not null,
  typ_transakcji varchar2(8 ) not null
        check (typ_transakcji in ('wynajem','kupno')),
  data_transakcji date not null,
  data_konca_wynajmu date, 
  primary key(id_samochodu, id_klienta),
  foreign key (id_samochodu) references samochody(id_samochodu),
  foreign key (id_klienta) references klienci(id_klienta)
 
)
/

-- table adresy

create table adresy(
  id_adresu integer PRIMARY KEY,
  miasto varchar2(30 ) not null,
  ulica varchar2(30 ) not null,
  numer_budynku varchar2(5 ) not null,
  numer_lokalu varchar2(5 ),
  kod_pocztowy char(6 ) not null,
  id_salonu integer not null,
  id_placowki integer,
  id_klienta integer,
  id_pracownika integer,
  foreign key (id_salonu) references salony_samochodowe(id_salonu),
  foreign key (id_placowki) references placowki(id_placowki),
  foreign key (id_klienta) references klienci(id_klienta),
  foreign key (id_pracownika) references pracownicy(id_pracownika)
)
/

-- create indexes for table adresy

create index ix_salon_przypisany_do_adresu on adresy (id_salonu)
/

create index ix_placowka_przypisana_do_adresu on adresy (id_placowki)
/

create index ix_klient_przypisany_do_adresu on adresy (id_klienta)
/

create index ix_pracownik_przypisany_do_adresu on adresy (id_pracownika)
/


-- table menadzerowie

create table menadzerowie(
  id_salonu integer not null,
  id_pracownika integer not null,
  primary key(id_salonu, id_pracownika),
  foreign key (id_salonu) references salony_samochodowe(id_salonu),
  foreign key (id_pracownika) references pracownicy(id_pracownika)
)
/

-- table kierownicy

create table kierownicy(
  id_placowki integer not null,
  id_pracownika integer not null,
  primary key (id_placowki, id_pracownika),
  foreign key (id_placowki) references placowki(id_placowki),
  foreign key (id_pracownika) references pracownicy(id_pracownika)
)
/


-- table modele

create table modele(
  id_modelu integer PRIMARY KEY,
  nazwa_modelu varchar2(10 ) not null,
  id_marki integer,
  id_salonu integer not null,
  foreign key (id_marki) references marki(id_marki),
  foreign key (id_salonu) references salony_samochodowe(id_salonu)
)
/

-- create indexes for table modele

create index ix_marka_modelu on modele (id_marki)
/

create index ix_model_jest_obslugiwany_przez_salon on modele (id_salonu)
/

-- table marki

create table marki(
  id_marki integer PRIMARY KEY,
  nazwa_marki varchar2(10 ) not null,
  id_salonu integer not null,
  foreign key (id_salonu) references salony_samochodowe(id_salonu)
)
/

-- create indexes for table marki

create index ix_salon_oblugujacy_marke on marki (id_salonu)
/

-- table serwisowane marki

create table serwisowane_marki(
  id_placowki integer not null,
  id_marki integer not null,
  primary key(id_placowki, id_marki),
  foreign key (id_placowki) references placowki(id_placowki),
  foreign key (id_marki) references marki(id_marki)
)
/


/*
-- create foreign keys (relationships) section ------------------------------------------------- 

alter table pracownicy add constraint jest_pracownikiem_salonu foreign key (id_salonu) references salony_samochodowe (id_salonu)
/



alter table pracownicy add constraint pracuje_w_placowce foreign key (id_placowki) references placowki (id_placowki)
/



alter table samochody add constraint placowka_posiada_samochody foreign key (id_placowki) references placowki (id_placowki)
/



alter table placowki add constraint salon_posiada_placowke foreign key (id_salonu) references salony_samochodowe (id_salonu)
/



alter table serwisy add constraint samochod_jest_serwisowany foreign key (id_samochodu) references samochody (id_samochodu)
/



alter table serwisy add constraint serwis_odbywa_sie_w_placowce foreign key (id_placowki) references placowki (id_placowki)
/



alter table klienci add constraint jest_klientem_salonu foreign key (id_salonu) references salony_samochodowe (id_salonu)
/



alter table samochody add constraint klient_posiada_samochod foreign key (id_klienta) references klienci (id_klienta)
/



alter table samochody add constraint salon_posiada_samochody foreign key (id_salonu) references salony_samochodowe (id_salonu)
/



alter table serwisy add constraint ma_serwisowany_samochod foreign key (id_klienta) references klienci (id_klienta)
/



alter table adresy add constraint salon_ma_adres foreign key (id_salonu) references salony_samochodowe (id_salonu)
/



alter table adresy add constraint placowka_ma_adres foreign key (id_placowki) references placowki (id_placowki)
/



alter table adresy add constraint klient_ma_adres foreign key (id_klienta) references klienci (id_klienta)
/



alter table adresy add constraint pracownik_ma_adres foreign key (id_pracownika) references pracownicy (id_pracownika)
/



alter table menadzerowie add constraint salon_ma_menadzera foreign key (id_salonu) references salony_samochodowe (id_salonu)
/



alter table menadzerowie add constraint pracownik_jest_menadzerem foreign key (id_pracownika) references pracownicy (id_pracownika)
/



alter table kierownicy add constraint placowka_ma_kierownika foreign key (id_placowki) references placowki (id_placowki)
/



alter table kierownicy add constraint pracownik_jest_kierownikem foreign key (id_pracownika) references pracownicy (id_pracownika)
/



alter table modele add constraint model_jest_danej_marki foreign key (id_marki) references marki (id_marki)
/



alter table samochody add constraint samochod_jest_dango_modelu foreign key (id_modelu) references modele (id_modelu)
/



alter table serwisowane_marki add constraint warsztat_serwisuje_marki foreign key (id_placowki) references warsztaty (id_placowki)
/



alter table serwisowane_marki add constraint marka_jest_serwisowana_przez_warsztat foreign key (id_marki) references marki (id_marki)
/



alter table modele add constraint model_jest_obslugiwany_przez_salon foreign key (id_salonu) references salony_samochodowe (id_salonu)
/



alter table marki add constraint marki_obslugiwane_przez_salon foreign key (id_salonu) references salony_samochodowe (id_salonu)
/




*/