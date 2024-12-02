-- Usuwanie danych, jesli juz istnieja
delete from przydzialy_serwisowe;
delete from transakcje;
delete from serwisowane_marki;
delete from marki;
delete from modele;
delete from warsztaty;
delete from punkty_handlowe;
delete from adresy;
delete from serwisy;
delete from samochody;
delete from klienci;
delete from pracownicy;
delete from placowki;
delete from salony_samochodowe;
delete from KLIENCI_PLACOWKI;
delete from STANOWISKA;
delete from WYNAGRODZENIA;

-- Inserting sample data into the database

-- Table: adresy
insert into adresy (miasto, ulica, numer_budynku, kod_pocztowy) values
('Warszawa', 'Nowowiejska', '15', '00-665');
insert into adresy (miasto, ulica, numer_budynku, numer_lokalu, kod_pocztowy) values
('Warszawa', 'plac Defilad', '1', '2716' ,'00-901');
insert into adresy (miasto, ulica, numer_budynku, kod_pocztowy) values
('Warszawa', 'Krajewskiego', '1A', '01-532');
insert into adresy (miasto, ulica, numer_budynku, kod_pocztowy) values
('Studzianki Pancerne', 'Studzianki Pancerne', '14', '26-903');
insert into adresy (miasto, ulica, numer_budynku, numer_lokalu, kod_pocztowy) values
('Zielonka', '1 Maja', '1', '12B', '05-220');
insert into adresy (miasto, ulica, numer_budynku, kod_pocztowy) values
('Warszawa', 'Krakowskie Przedmiescie', '46/48', '00-071');
insert into adresy (miasto, ulica, numer_budynku, numer_lokalu, kod_pocztowy) values
('Siedlce', 'Jozefa Pilsudskiego', '47', '8', '08-110');
insert into adresy (miasto, ulica, numer_budynku, numer_lokalu, kod_pocztowy) values
('Warszawa', 'Sylwestra Kaliskiego', '2', '65', '01-485');
insert into adresy (miasto, ulica, numer_budynku, kod_pocztowy) values
('Sulejowek', 'Jozefa Pilsudskiego', '29', '05-070');

-- Table: salony_samochodowe
insert into salony_samochodowe (nazwa_salonu, id_adresu) values
('AutoPolska', 1);

-- Table: placowki
insert into placowki (nazwa, id_salonu, id_adresu) values
('AutoSprzedaz', 1, 1);
insert into placowki (nazwa, id_salonu, id_adresu) values
('AutoSerwis', 1, 2);

-- Table: marki
insert into marki (nazwa_marki, id_salonu) values
('FSO', 1);
insert into marki (nazwa_marki, id_salonu) values
('IFA', 1);

-- Table: modele
insert into modele (nazwa_modelu, id_marki, id_salonu) values
('Warszawa', 1, 1);
insert into modele (nazwa_modelu, id_marki, id_salonu) values
('Wartburg', 2, 1);


-- Table: klienci
insert into klienci (imie, nazwisko, numer_telefonu, id_adresu) values
('Katarzyna', 'Wisniewska', '503456789', 9);
insert into klienci (imie, nazwisko, numer_telefonu, id_adresu) values
('Wojciech', 'Siwicki', '230706890', 6);
insert into klienci (imie, nazwisko, numer_telefonu, id_adresu) values
('Andrzej', 'Nowotko', '123098456', 8);

-- Table: punkty_handlowe
insert into punkty_handlowe (id_placowki, czy_wynajem, czy_sprzedaz, czy_uzywane) values
(1,'Y','Y','Y');

-- Table: warsztaty:
insert into warsztaty (id_placowki, liczba_stanowisk, czy_wymiana_opon) values
(2,8,'Y');

--Table: Klienci_placowki
insert into klienci_placowki (id_klienta,id_placowki) values
(1,1);
insert into klienci_placowki (id_klienta,id_placowki) values
(3,1);
insert into klienci_placowki (id_klienta,id_placowki) values
(2,1);

-- Table: samochody
insert into samochody (numer_rejestracyjny, data_produkcji, przebieg, waznosc_przegladu, stan_techniczny, czy_powypadkowy, cena_wynajmu, id_placowki, id_modelu) values
('WX12345', to_date('1965-06-15', 'YYYY-MM-DD'), 150000, to_date('2025-06-15', 'YYYY-MM-DD'), 'dobry', 'N', 120.50, 1, 1);
insert into samochody (numer_rejestracyjny, data_produkcji, przebieg, waznosc_przegladu, stan_techniczny, czy_powypadkowy, cena_sprzedazy, id_placowki, id_modelu) values
('UB3456', to_date('1981-12-13', 'YYYY-MM-DD'), 300000, to_date('2024-05-10', 'YYYY-MM-DD'), 'akceptowalny', 'Y', 80000, 1, 2);
insert into samochody (numer_rejestracyjny, data_produkcji, przebieg, waznosc_przegladu, stan_techniczny, czy_powypadkowy, id_klienta, id_modelu) values
('HB1111', to_date('1966-12-24', 'YYYY-MM-DD'), 1000, to_date('2028-12-10', 'YYYY-MM-DD'), 'dobry', 'N', 2, 1);

--Table: transakcje
insert into transakcje (id_samochodu, id_klienta, typ_transakcji, data_transakcji) values
(3,2,'Kupno',to_date('2005-12-24', 'YYYY-MM-DD'));
insert into transakcje (id_samochodu, id_klienta, typ_transakcji, data_transakcji, data_konca_wynajmu) values
(1,3,'Wynajem',to_date('2005-6-24', 'YYYY-MM-DD'),to_date('2010-6-24', 'YYYY-MM-DD'));

-- Table: stanowiska
insert into stanowiska (nazwa_stanowiska, opis) values
('Sprzedawca', 'Odpowiedzialny za sprzedaz pojazdów');
insert into stanowiska (nazwa_stanowiska, opis) values
('Mechanik', 'Przeprowadza serwisy pojazdów');
insert into stanowiska (nazwa_stanowiska, opis) values
('Kierownik', 'Zarzadza przedsiebiorstwem');
insert into stanowiska (nazwa_stanowiska, opis) values
('Kierownik warsztatu', 'zarzadza serwisami');

-- Table: pracownicy
insert into pracownicy (imie, nazwisko, pesel, numer_telefonu, id_salonu, id_stanowiska, id_adresu) values
('Jan', 'Kowalski', '89012345678', '501234567', 1, 3, 3);
insert into pracownicy (imie, nazwisko, pesel, numer_telefonu, id_placowki, id_stanowiska, id_adresu) values
('Anna', 'Nowak', '92040578901', '502345678', 1,1, 5);
insert into pracownicy (imie, nazwisko, pesel, numer_telefonu, id_placowki, id_stanowiska, id_adresu) values
('Jan', 'Bogdan', '88888888888', '888888888', 2,4, 4);
insert into pracownicy (imie, nazwisko, pesel, numer_telefonu, id_placowki, id_stanowiska, id_adresu) values
('Gustaw', 'Husak', '92041118912', '423867421', 2,2, 9);


-- Table: serwisy
insert into serwisy (data_rozpoczecia, koszt, opis, id_samochodu, id_placowki) values
(to_date('2024-11-25', 'YYYY-MM-DD'), 500.00, 'Wymiana klocków hamulcowych', 1, 2);
insert into serwisy (data_rozpoczecia, koszt, opis, id_samochodu, id_placowki) values
(to_date('2024-12-01', 'YYYY-MM-DD'), 800.00, 'Przeglad techniczny', 2, 2);

-- Table: Przydzialy_serwisowe
insert into przydzialy_serwisowe (id_pracownika, id_serwisu) values
(4,1);
insert into przydzialy_serwisowe (id_pracownika, id_serwisu) values
(4,2);

--Table: serwisowane_marki
insert into serwisowane_marki (id_placowki, id_marki) values
(2,1);
insert into serwisowane_marki (id_placowki, id_marki) values
(2,2);

-- Table: wynagrodzenia
insert into wynagrodzenia (data, kwota, kwota_dod, id_pracownika) values
(to_date('2024-11-30', 'YYYY-MM-DD'), 4000.00, 500.00, 1);
insert into wynagrodzenia (data, kwota, kwota_dod, id_pracownika) values
(to_date('2024-11-30', 'YYYY-MM-DD'), 4500.00, 300.00, 2);
insert into wynagrodzenia (data, kwota, kwota_dod, id_pracownika) values
(to_date('2024-11-30', 'YYYY-MM-DD'), 6000.00, 500.00, 3);
insert into wynagrodzenia (data, kwota, kwota_dod, id_pracownika) values
(to_date('2024-11-30', 'YYYY-MM-DD'), 700.00, 300.00, 4);