CREATE OR REPLACE FUNCTION KitapEkle(bookName TEXT,printDate TIMESTAMP,quantity INTEGER,pageNumber INTEGER,tur TEXT,tip CHAR(1),author TEXT)
RETURNS INTEGER
AS
$$
DECLARE
    yazarlar record;
    turler record;
    tarihler record;
    yazarNumara record;
    tarihNumara record;
    turNumarasi record;
    kitapNumarasi record;
BEGIN
    SELECT INTO tarihler "BasimTarihi" FROM "Tarih" WHERE "BasimTarihi" = printDate;
    IF tarihler IS NULL THEN
        INSERT INTO "Tarih"("BasimTarihi") VALUES(printDate);
    END IF;
    SELECT INTO tarihNumara "TarihNo" FROM "Tarih" WHERE "BasimTarihi" = printDate;

    
    SELECT INTO yazarlar "YazarNo" FROM "Yazar" WHERE "YazarAdi" = author;
    IF yazarlar IS NULL THEN
        INSERT INTO "Yazar"("YazarAdi") VALUES(author);
    END IF;
    SELECT INTO yazarNumara "YazarNo" FROM "Yazar" WHERE "YazarAdi" = author;
    
    
    SELECT INTO turler "TurNo" FROM "Tur" WHERE "TurAdi" = tur;
    IF turler IS NULL THEN
        INSERT INTO "Tur"("TurAdi") VALUES(tur);
    END IF;
    SELECT INTO turNumarasi "TurNo" FROM "Tur" WHERE "TurAdi" = tur;
	
	
    INSERT INTO "Kitap"("KitapAdi","BasimTarihi","Miktar","SayfaSayisi","Tip","Yazar")
    VALUES(bookName,tarihNumara."TarihNo",quantity,pageNumber,tip,yazarNumara."YazarNo");
    
    
    SELECT INTO kitapNumarasi "KitapNo" FROM "Kitap" ORDER BY "KitapNo" DESC LIMIT 1;
    INSERT INTO "KitapTur"("Kitap","Tur") VALUES(kitapNumarasi."KitapNo",turNumarasi."TurNo");
    
    RETURN 1;
   
END;
$$
LANGUAGE "plpgsql";

SELECT * FROM KitapEkle('agwgvbvbawg','2020-10-07',40,200,'R','Gargano Derviş');


CREATE OR REPLACE FUNCTION KisiEkle(personfirstName TEXT,personLastName TEXT,address TEXT)
RETURNS INTEGER
AS
$$
DECLARE
    adresler record;
    adresNumara record;
BEGIN
    SELECT INTO adresler "Adres" FROM "Adres" WHERE "Adres" = address;
    IF adresler IS NULL THEN
        INSERT INTO "Adres"("Adres") VALUES(address);
    END IF;
    SELECT INTO adresNumara "AdresNo" FROM "Adres" WHERE "Adres" = address;


    INSERT INTO "Kisi"("Ad","Soyad","Adres")
    VALUES(personfirstName,personLastName,adresNumara."AdresNo");
    
    RETURN 1;
   
END;
$$
LANGUAGE "plpgsql";


SELECT * FROM KisiEkle('Ahmet','Yıldırım','nijerya');

CREATE OR REPLACE FUNCTION KitapSil(kitapNumara INTEGER)
RETURNS INTEGER
AS
$$
DECLARE
    kitapTurSil "KitapTur"%ROWTYPE;
BEGIN
    FOR kitapTurSil IN SELECT "ListeNo" FROM "KitapTur" WHERE "Kitap" = kitapNumara LOOP
        DELETE FROM "KitapTur" WHERE "ListeNo" = kitapTurSil."ListeNo";
    END LOOP;
    
    DELETE FROM "Kitap" WHERE "KitapNo" = kitapNumara;
    RETURN 1;
END;
$$
LANGUAGE "plpgsql";

SELECT * FROM KitapSil(2);

CREATE OR REPLACE FUNCTION KitapAl(kisiNo INTEGER,kitapAdi TEXT,kitapMiktar INTEGER, kAlisTarihi TIMESTAMP)
RETURNS INTEGER
AS
$$
DECLARE
    tarihler record;
    tarihNumara record;
BEGIN
    SELECT INTO tarihler "AlisTarihi" FROM "Tarih" WHERE "AlisTarihi" = kAlisTarihi;
    IF tarihler IS NULL THEN
        INSERT INTO "Tarih"("AlisTarihi") VALUES(kAlisTarihi);
    END IF;
    SELECT INTO tarihNumara "TarihNo" FROM "Tarih" WHERE "AlisTarihi" = kAlisTarihi;

    INSERT INTO "IslemListesi"("Kisi","KitapAdi","KitapMiktar","Sure")
    VALUES(kisiNo,kitapAdi,kitapMiktar,tarihNumara."TarihNo");
    
    RETURN 1;
END;
$$
LANGUAGE "plpgsql";

SELECT * FROM KitapAl(1,'agwgawg',50,'2017-8-18');

CREATE OR REPLACE FUNCTION "KitapMiktariDegisikligi"()
RETURNS TRIGGER
AS
$$
BEGIN
    UPDATE "Kitap"
    SET "Miktar" = "Miktar" - NEW."KitapMiktar"  
    WHERE "KitapAdi" = NEW."KitapAdi";
    
    RETURN NEW;
END;
$$
LANGUAGE "plpgsql";   

CREATE TRIGGER "KitapAlindiginda"
AFTER INSERT  ON  "IslemListesi"
FOR EACH ROW
EXECUTE PROCEDURE "KitapMiktariDegisikligi"();

DROP TRIGGER "KitapAlindiginda" ON "IslemListesi";

SELECT * FROM KitapAl(4,'Çalıkuşu',3,'2018-8-18');


CREATE OR REPLACE FUNCTION "KisininIslemleriniSil"()
RETURNS TRIGGER
AS
$$
BEGIN
    DELETE FROM "IslemListesi" WHERE "Kisi" = OLD."KisiNo";
    
    RETURN OLD;
END;
$$
LANGUAGE "plpgsql";

CREATE TRIGGER "KisiSilindiginde"
AFTER DELETE  ON  "Kisi"
FOR EACH ROW
EXECUTE PROCEDURE "KisininIslemleriniSil"();

DROP TRIGGER "KisiSilindiginde" ON "Kisi";

DELETE FROM "Kisi" WHERE "KisiNo" = 5;

SELECT * FROM KisiEkle('Ali','Koç','serdivan');

SELECT * FROM KitapAl(5,'Kaşağı',5,'2018-8-18');












