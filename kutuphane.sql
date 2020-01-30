CREATE OR REPLACE FUNCTION KisiGetir()
RETURNS TABLE(Ad TEXT,Soyad TEXT, Adres INTEGER)
AS
$$
BEGIN
    RETURN QUERY SELECT "Ad", "Soyad", "Adres" FROM "public"."Kisi";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION KisiEkle()
RETURNS TABLE(Ad TEXT,Soyad TEXT, Adres INTEGER)
AS
$$
DECLARE
    name TEXT;
    surname TEXT;
    address INTEGER;
BEGIN
    RETURN QUERY INSERT INTO "Kisi"("Ad","Soyad","Adres")
    VALUES("name","surname","address");
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION KisiSil()
RETURNS TABLE(Ad TEXT,Soyad TEXT, Adres INTEGER)
AS
$$
DECLARE
    personNumber INTEGER;
BEGIN
    RETURN QUERY DELETE FROM "Kisi" WHERE "KisiNo" = "personNumber";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION AdresGetir()
RETURNS TABLE(Adres TEXT)
AS
$$
BEGIN
    RETURN QUERY SELECT "Adres" FROM "public"."Adres";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION AdresEkle()
RETURNS TABLE(Adres TEXT)
AS
$$
DECLARE
    address TEXT;
BEGIN
    RETURN QUERY INSERT INTO "Adres"("Adres")
    VALUES("address");
      
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION AdresSil()
RETURNS TABLE(Adres TEXT)
AS
$$
DECLARE
    addressNumber INTEGER;
BEGIN
    RETURN QUERY DELETE FROM "Adres" WHERE "AdresNo" = "addressNumber";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION KitapGetir()
RETURNS TABLE(KitapAdi TEXT,BasimTarihi INTEGER,Miktar INTEGER,SayfaSayisi INTEGER,Tip CHAR(1),Yazar INTEGER)
AS
$$
BEGIN
    RETURN QUERY SELECT "KitapAdi","BasimTarihi","Miktar","SayfaSayisi","Tip","Yazar" FROM "public"."Kitap";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION KitapEkle()
RETURNS TABLE(KitapAdi TEXT,BasimTarihi INTEGER,Miktar INTEGER,SayfaSayisi INTEGER,Tip CHAR(1),Yazar INTEGER)
AS
$$
DECLARE
    bookName TEXT;
    printDate INTEGER;
    quantity INTEGER;
    pageNumber INTEGER;
    type CHAR(1);
    author INTEGER;
BEGIN
    RETURN QUERY INSERT INTO "Kisi"("KitapAdi","BasimTarihi","Miktar","SayfaSayisi","Tip","Yazar")
    VALUES("bookName","printDate","quantity","pageNumber","type","author");
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION KitapSil()
RETURNS TABLE(KitapAdi TEXT,BasimTarihi INTEGER,Miktar INTEGER,SayfaSayisi INTEGER,Tip CHAR(1),Yazar INTEGER)
AS
$$
DECLARE
    bookNumber INTEGER;
BEGIN
    RETURN QUERY DELETE FROM "Kisi" WHERE "KitapNo" = "bookNumber";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION TarihGetir()
RETURNS TABLE(AlisTarihi DATE,BasimTarihi DATE)
AS
$$
BEGIN
    RETURN QUERY SELECT "AlisTarihi", "BasimTarihi" FROM "public"."Tarih";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION TarihEkle()
RETURNS TABLE(AlisTarihi DATE,BasimTarihi DATE)
AS
$$
DECLARE
    printDate DATE;
    takeDate DATE;
BEGIN
    RETURN QUERY INSERT INTO "Tarih"("AlisTarihi","BasimTarihi")
    VALUES("printDate","takeDate");
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION TarihSil()
RETURNS TABLE(AlisTarihi DATE,BasimTarihi DATE)
AS
$$
DECLARE
    dateNumber INTEGER;
BEGIN
    RETURN QUERY DELETE FROM "Tarih" WHERE "TarihNo" = "dateNumber";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION TurGetir()
RETURNS TABLE(TurAdi VARCHAR(20))
AS
$$
BEGIN
    RETURN QUERY SELECT "TurAdi" FROM "public"."Tur";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION TurEkle()
RETURNS TABLE(TurAdi VARCHAR(20))
AS
$$
DECLARE
    typeName VARCHAR(20);
BEGIN
    RETURN QUERY INSERT INTO "Tur"("TurAdi")
    VALUES("typeName");
      
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION TurSil()
RETURNS TABLE(TurAdi VARCHAR(20))
AS
$$
DECLARE
    typeNumber INTEGER;
BEGIN
    RETURN QUERY DELETE FROM "Tur" WHERE "TurNo" = "typeNumber";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION YazarGetir()
RETURNS TABLE(YazarAdi TEXT)
AS
$$
BEGIN
    RETURN QUERY SELECT "YazarAdi" FROM "public"."Yazar";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION YazarEkle()
RETURNS TABLE(YazarAdi TEXT)
AS
$$
DECLARE
    authorName TEXT;
BEGIN
    RETURN QUERY INSERT INTO "Yazar"("YazarAdi")
    VALUES("authorName");
      
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION YazarSil()
RETURNS TABLE(YazarAdi TEXT)
AS
$$
DECLARE
    authorNumber INTEGER;
BEGIN
    RETURN QUERY DELETE FROM "Yazar" WHERE "YazarNo" = "authorNumber";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION KitapTurGetir()
RETURNS TABLE(Kitap INTEGER,Tur INTEGER)
AS
$$
BEGIN
    RETURN QUERY SELECT "Kitap","Tur" FROM "public"."KitapTur";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION KitapTurEkle()
RETURNS TABLE(Kitap INTEGER,Tur INTEGER)
AS
$$
DECLARE
    book INTEGER;
    type INTEGER; 
BEGIN
    RETURN QUERY INSERT INTO "KitapTur"("Kitap","Tur")
    VALUES("book","type");
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION KitapTurSil()
RETURNS TABLE(Kitap INTEGER,Tur INTEGER)
AS
$$
DECLARE
    listNumber INTEGER;
BEGIN
    RETURN QUERY DELETE FROM "KitapTur" WHERE "ListeNo" = "listNumber";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION IslemListesiGetir()
RETURNS TABLE(Kisi INTEGER,KitapAdi TEXT,KitapMiktar INTEGER,Sure INTEGER)
AS
$$
BEGIN
    RETURN QUERY SELECT "Kisi","KitapAdi","KitapMiktar","Sure" FROM "public"."IslemListesi";
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION IslemListesiEkle()
RETURNS TABLE(Kisi INTEGER,KitapAdi TEXT,KitapMiktar INTEGER,Sure INTEGER)
AS
$$
DECLARE
    person INTEGER;
    bookName TEXT;
    bookQuantity INTEGER;
    time INTEGER;   
BEGIN
    RETURN QUERY INSERT INTO "IslemListesi"("Kisi","KitapAdi","KitapMiktar","Sure")
    VALUES("person","bookName","bookQuantity","time");
   
END;
$$
LANGUAGE "plpgsql";


CREATE OR REPLACE FUNCTION IslemListesiSil()
RETURNS TABLE(Kisi INTEGER,KitapAdi TEXT,KitapMiktar INTEGER,Sure INTEGER)
AS
$$
DECLARE
    operationNumber INTEGER;
BEGIN
    RETURN QUERY DELETE FROM "IslemListesi" WHERE "IslemListesiNo" = "operationNumber";
   
END;
$$
LANGUAGE "plpgsql";




