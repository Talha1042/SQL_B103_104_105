CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun;

--musteri urun tablosundan urun isimlerini tekrarsiz listeleyiniz.
-- group by cozumu
select urun_isim from musteri_urun
group by urun_isim

--distinct cozumu
select distinct(urun_isim) from musteri_urun

--Tabloda kac farkli meyve vardir ?

select urun_isim ,count(urun_isim) from musteri_urun
group by urun_isim

select urun_isim, count(distinct urun_isim) from musteri_urun
group by urun_isim

-- FETCH NEXT () ROW ONLY / OFFSET / LIMIT

-- Musteri urun tablosundan ilk üç kaydı listeleyiniz

select * from musteri_urun order by urun_id 
fetch next 3 row only;

--Limit

select * from musteri_urun order by urun_id
limit 3

--Musteri urun tablosundan ilk kaydi listeleyiniz.

select * from musteri_urun order by urun_id
limit 1

--Musteri urun tablosundan son uc kaydimlisteleyiniz.

select * from musteri_urun order by urun_id desc
limit 3

drop table maas
CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int
);

INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

select * from maas

--en yuksek maası olan personeli listeleyiniz

select * from maas order by maas desc
limit 1

--maas tablosundan en yuksek 2. maası listeleyiniz
select * from maas order by maas desc
offset 1
limit 1

/*
OFFSET --> Satır atlamak istediğimizde offset komutunu kullanırız
*/
select * from maas order by maas desc
offset 1 
fetch next 1 row only

-- maas tablosundan en dusuk dorduncu maası listeleyiniz
select * from maas order by maas
offset 3  -- satır atlıoz offsetle
limit 1

-- DDL --> ALTER TABLE

drop table personel -- Tabloyu ortadan kaldırmak için kullanılır

CREATE TABLE personel  (
id int,
isim varchar(50), 
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel

--1) ADD default deger ile tabloya bir field ekleme

alter table personel 
add ulke varchar(30)

alter table personel 
add zipcode varchar(30)


alter table personel 
add adres varchar(50)
default 'Turkiye'  -- default yazarsak olustuduğumuz sutuna belirttigimiz veriyi tum sutunlara girer.

-- 2) DROP tablodan sutun silme
alter table personel 
drop column zipcode

alter table personel
drop adres,drop sirket -- iki sutunu birden silmis olduk 

--3) RENAME COLUMN sutun adi degistirme
alter table personel
rename column sehir to il

-- 4) RENAME tablonun ismini degistirme
alter table personel 
rename to isci

-- 5) TYPE/SET(modify) sutunlarin ozelliklerini degistirme

alter table isci 
alter column il type varchar(30),
alter column maas set not null;


/*
Eğer numerik data türüne sahip bir sütunun data türüne string bir data türü atamak istersek
TYPE varchar(30) USING(maas::varchar(30)) bu formatı kullanırız
*/
alter table isci
alter column maas
type varchar(30) 
using(maas::varchar(30))

SELECT * FROM personel
select * from isci

-- TRANSACTION (BEGIN-SAVEPOINT-ROLLBACK-COMMIT)
/*
Transaction başlatmak için BEGIN komutu kullanmamız gerekir ve Transaction'ı sonlardık için
COMMIT komutunu çalıştırmalıyız
*/



drop table ogrenciler2

CREATE TABLE ogrenciler2
(
id serial, -- Serial data türü otomatik olarak 1 den baslayarak sıralı olarak sayı ataması yapar
            -- INSERT INTO ile tabloya veri eklerken serial data türünü kullandığım veri değeri yerine DEFAULT yazarız
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;

SELECT * from ogrenciler2
delete from ogrenciler2
drop table ogrenciler2















