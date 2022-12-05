
CREATE TABLE musteriler  (
urun_id int,  
musteri_isim varchar(50), 
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple');  
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');  
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');  
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');  
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');  
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

-- between condition
-- Musteriler tablosundan urun_id'si 20 ile 40 arasında olan tüm verileri listeleyiniz

select * from musteriler where urun_id>=20 and urun_id<=40;
select * from musteriler where urun_id between 20 and 40;

select * from musteriler where urun_id not between 20 and 40;

-- SUBQUERIES --> Sorgu içinde sorgu
drop table if exists calisanlar2;
CREATE TABLE calisanlar2 
(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);

select * from calisanlar2;
select * from markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini 
--ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.

select isim,maas,isyeri from calisanlar2
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);

-- marka_id’si 101’den büyük olan marka çalişanlarinin 
-- isim, maaş ve şehirlerini listeleyiniz

select isim,maas,sehir from calisanlar2
where isyeri in(select marka_isim from markalar where marka_id>101 );

/*
--ÖDEV- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
*/
-- AGGREGATE METHOD
--Calisanlar tablosunda maksimum maası listeleyiniz
select max(maas) as maksimum_maas from calisanlar2;

/*
Eğer bir sütuna geçici olarak bir isim vermek istersek AS komutunu yazdıktan sonra vermek
istediğimiz ismi yazarız
*/

--Calisanlar tablosunda minimum maası listeleyiniz
select min(maas) as minimum_maas from calisanlar2;

--Calisanlar tablosundaki maasların toplamını listeleyiniz
select sum(maas) as maaslar_toplami from calisanlar2;

--Calisanlar tablosundaki maasların ortalamasını listeleyiniz
select avg(maas) as maas_ort from calisanlar2; -- as den sonra isim verdik yazmayadabilirdik
select round(avg(maas),2) from calisanlar2; -- round ile virgülden sonraki kismi silip ortaladık eger maastan sonra virgül 2 3 vs yazsak virgülden sonra o kdr sayiyi gosterir

--Calisanlar tablosundaki maasların sayısı
select count(maas) as maaslarin_sayisi from calisanlar2; -- maas yerine * da koyabilirdik. * isareti row lari yani satirlari sayar.
-- eger maas null olursa ve parantezin icine * koyarsak maas 7 iken count 8 sonucunu verir.

/*
Eğer count(*) kullanırsak tablodaki tüm satırların sayısını verir
Sutun adı kullanırsak o sutundaki sayıları verir
*/

--AGGREGATE METHODLARDA SUBQUERY
-- Her markanin id’sini, ismini ve toplam kaç şehirde 
-- bulunduğunu listeleyen bir SORGU yaziniz
Select marka_id, marka_isim,
(select count(sehir) as sehir_sayisi from calisanlar2 where  ) 
from markalar;

--  Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
--  toplam maaşini listeleyiniz
select marka_isim ,calisan_sayisi,
(select sum(maas) as toplam_maas from calisanlar2 where marka_isim=isyeri)
from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
-- maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz. 

select marka_isim,calisan_sayisi,
(select max(maas) from calisanlar2 where marka_isim=isyeri),
(select min(maas) from calisanlar2 where marka_isim=isyeri)
from markalar;
































