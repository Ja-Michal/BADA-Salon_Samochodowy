/*
created: 25.11.2024
modified: 27.11.2024
project: salon samochodowy
model: model logiczny
author: michał bogusz i mateusz kowalczuk
database: oracle 18c
*/


-- create tables section -------------------------------------------------

-- table salony_samochodowe

create table salony_samochodowe(
  id_salonu integer not null,
  nazwa varchar2(30 ) not null
)
/

-- add keys for table salony_samochodowe

alter table salony_samochodowe add constraint unique_identifier1 primary key (id_salonu)
/

-- table pracownicy

create table pracownicy(
  id_pracownika integer not null,
  imie varchar2(20 ) not null,
  nazwikso varchar2(30 ) not null,
  pesel char(11 ),
  numer_telefonu varchar2(15 ) not null,
  stanowisko varchar2(30 ) not null,
  wynagrodzenie number(10,2) not null,
  id_salonu integer not null,
  id_placowki integer
)
/

-- create indexes for table pracownicy

create index ix_jest pracownikiem salonu on pracownicy (id_salonu)
/

create index ix_pracuje w placowce on pracownicy (id_placowki)
/

-- add keys for table pracownicy

alter table pracownicy add constraint unique_identifier2 primary key (id_pracownika)
/

-- table samochody

create table samochody(
  id_samochodu integer not null,
  numer_rejestracyjny varchar2(8 ) not null,
  data_produkcji date not null,
  przebieg integer not null,
  waznosc_przegladu date not null,
  stan_techniczny varchar2(30 ) not null
        check (--stan_techniczny in ('nowy', 'dobry', 'akceptowalny', 'wymaga serwisu')),
  czy_powypadkowy char(1 ) not null,
  cena_wynajmu number(10,2),
  cena_sprzedaży number(10,2),
  id_placowki integer,
  id_klienta integer not null,
  id_salonu integer not null,
  id_modelu integer not null
)
/

-- create indexes for table samochody

create index ix_placówka posiada samochody on samochody (id_placowki)
/

create index ix_samochod jest kupiony on samochody (id_klienta)
/

create index ix_salon posiada samochody on samochody (id_salonu)
/

create index ix_samochod jest dango modelu on samochody (id_modelu)
/

-- add keys for table samochody

alter table samochody add constraint unique_identifier5 primary key (id_samochodu)
/

-- table klienci

create table klienci(
  id_klienta integer not null,
  imie varchar2(20 ) not null,
  nazwisko varchar2(30 ) not null,
  numer_telefonu varchar2(15 ) not null,
  id_salonu integer not null
)
/

-- create indexes for table klienci

create index ix_jest klientem salonu on klienci (id_salonu)
/

-- add keys for table klienci

alter table klienci add constraint unique_identifier9 primary key (id_klienta)
/

-- table serwisy

create table serwisy(
  id_serwisu integer not null,
  data_rozpoczecia date not null,
  koszt number(10,2) not null,
  opis varchar2(1000 ) not null,
  id_samochodu integer not null,
  id_placowki integer not null,
  id_klienta integer
)
/

-- create indexes for table serwisy

create index ix_samochod jest serwisowany on serwisy (id_samochodu)
/

create index ix_ma serwisowany samochod on serwisy (id_klienta)
/

create index ix_serwis odbywa sie w placowce on serwisy (id_placowki)
/

-- add keys for table serwisy

alter table serwisy add constraint unique_identifier10 primary key (id_serwisu)
/

-- table placowki

create table placowki(
  id_placowki integer not null,
  nazwa varchar2(30 ) not null,
  id_salonu integer not null
)
/

-- create indexes for table placowki

create index ix_posiada_placowke on placowki (id_salonu)
/

-- add keys for table placowki

alter table placowki add constraint unique_identifier11 primary key (id_placowki)
/

-- table punkty_handlowe

create table punkty_handlowe(
  czy_wynajem char(1 ) not null,
  czy_sprzedaz char(1 ) not null,
  czy_uzywane char(1 ) not null,
  id_placowki integer not null
)
/

-- add keys for table punkty_handlowe

alter table punkty_handlowe add constraint unique_identifier12 primary key (id_placowki)
/

-- table warsztaty

create table warsztaty(
  liczba_stanowisk integer not null,
  czy_wymiana_opon char(1 ) not null,
  id_placowki integer not null
)
/

-- add keys for table warsztaty

alter table warsztaty add constraint unique_identifier14 primary key (id_placowki)
/

-- table przydzialy_serwisowe

create table przydzialy_serwisowe(
  id_pracownika integer not null,
  id_serwisu integer not null
)
/

-- table klienci_placowki

create table klienci_placowki(
  id_placowki integer not null,
  id_klienta integer not null
)
/

-- table transakcje

create table transakcje(
  id_samochodu integer not null,
  id_klienta integer not null,
  typ_transakcji varchar2(8 ) not null
        check (typ_transakcji in ('wynajem','kupno')),
  data_transakcji date not null,
  data_konca_wynajmu date
)
/

-- table adresy

create table adresy(
  id_adresu integer not null,
  miasto varchar2(30 ) not null,
  ulica varchar2(30 ) not null,
  numer_budynku varchar2(5 ) not null,
  numer_lokalu varchar2(5 ),
  kod_pocztowy char(6 ) not null,
  id_salonu integer not null,
  id_placowki integer,
  id_klienta integer,
  id_pracownika integer
)
/

-- create indexes for table adresy

create index ix_relationship1 on adresy (id_salonu)
/

create index ix_relationship2 on adresy (id_placowki)
/

create index ix_relationship3 on adresy (id_klienta)
/

create index ix_relationship4 on adresy (id_pracownika)
/

-- add keys for table adresy

alter table adresy add constraint pk_adresy primary key (id_adresu)
/

-- table menadzerowie

create table menadzerowie(
  id_salonu integer not null,
  id_pracownika integer not null
)
/

-- add keys for table menadzerowie

alter table menadzerowie add constraint pk_menadzerowie primary key (id_salonu,id_pracownika)
/

-- table kierownicy

create table kierownicy(
  id_placowki integer not null,
  id_pracownika integer not null
)
/

-- add keys for table kierownicy

alter table kierownicy add constraint pk_kierownicy primary key (id_pracownika,id_placowki)
/

-- table modele

create table modele(
  id_modelu integer not null,
  nazwa_modelu varchar2(10 ) not null,
  id_marki integer,
  id_salonu integer not null
)
/

-- create indexes for table modele

create index ix_relationship10 on modele (id_marki)
/

create index ix_model jest obslugiwany przez salon on modele (id_salonu)
/

-- add keys for table modele

alter table modele add constraint pk_modele primary key (id_modelu)
/

-- table marki

create table marki(
  id_marki integer not null,
  nazwa_marki varchar2(10 ) not null,
  id_salonu integer not null
)
/

-- create indexes for table marki

create index ix_relationship15 on marki (id_salonu)
/

-- add keys for table marki

alter table marki add constraint pk_marki primary key (id_marki)
/

-- table serwisowane marki

create table serwisowane marki(
  id_placowki integer not null,
  id_marki integer not null
)
/

-- add keys for table serwisowane marki

alter table serwisowane marki add constraint pk_serwisowane marki primary key (id_placowki,id_marki)
/


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



alter table serwisowane marki add constraint warsztat_serwisuje_marki foreign key (id_placowki) references warsztaty (id_placowki)
/



alter table serwisowane marki add constraint marka_jest_serwisowana_przez_warsztat foreign key (id_marki) references marki (id_marki)
/



alter table modele add constraint model_jest_obslugiwany_przez_salon foreign key (id_salonu) references salony_samochodowe (id_salonu)
/



alter table marki add constraint marki_obslugiwane_przez_salon foreign key (id_salonu) references salony_samochodowe (id_salonu)
/





