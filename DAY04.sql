CREATE TABLE ogrenciler93
(
ogrenci_no char(7),
isim varchar(20),
soy_isim varchar(25),
not_ort real
primary key(ogrenci_no,not_ort),
unique (soy_isim,isim)	
); -- normalde primary key atayamıoz 2 kısma ama bu şablonda yazarsak atayabiliyoz

--ödev
--ankarada calisani olan marka id lerini ve calisan sayilarini listeleyiniz.
select * from markalar;
select * from calisanlar2;

select marka_id as ankaradacalisanid, calisan_sayisi from markalar
where marka_isim in
(select isyeri from calisanlar2 where sehir='Ankara');

--ALIASES

drop table if exists calisanlar5;
CREATE TABLE calisanlar5  (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO calisanlar5 VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO calisanlar5 VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO calisanlar5 VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar5;

-- Eğer iki sutunun verilerini birleştirmek istersek concat sembolu || kullanırız
select calisan_id as id ,
calisan_isim || ' ' || calisan_dogdugu_sehir as calisan_bilgisi 
from calisanlar5;

-- 2. Yol
select calisan_id as id,
concat(calisan_isim ,' ', calisan_dogdugu_sehir) as calisan_bilgisi
from calisanlar5;

--IS NULL CONDITION
create table insanlar
(
ssn char(9),
name varchar(50),
adres varchar(50)	
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

-- name sutununda null olan degerleri listeleyelim.
select * from insanlar where name is null;

-- ınsanlar tablosunda null olmayan degerleri listeleyiniz.
select name from insanlar where name is not null;

-- insanlar tablosunda null deger almis verileri no name olarak degistiriniz.
update insanlar
set name= 'No Name' where name is null;

select * from insanlar;

drop table if exists insanlar;

-- ORDER BY KOMUTU
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar (ASC)
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar;

--Insanlar tablosundaki datalari adres’e gore siralayin 
select * from insanlar order by adres;

select * from insanlar order by soyisim;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar where isim = 'Mine' order by ssn;

--NOT : Order By komutundan sonra field(sutun) ismi yerine field(sutun) numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin 
select * from insanlar where soyisim = 'Bulut' order by 2;

-- Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar order by ssn desc;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar order by isim asc , soyisim desc; -- asc yazsak da yazmasak da olur.

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eğer sutun uzunluğuna göre sıralamak istersek LENGTH komutu kullanırız 
Ve yine uzunluğu büyükten küçüğe sıralamak istersek sonuna DESC komutunu ekleriz
*/
select isim,soyisim from insanlar order by length(soyisim);

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
select isim || ' ' ||soyisim as isim_soyisim
from insanlar order by length (isim||soyisim);
--2. yol
select isim || ' ' ||soyisim as isim_soyisim
from insanlar order by length (isim) + length (soyisim);
--3.yol
select concat(isim,' ',soyisim) as isim_soyisim from insalar
order by length (isim) + length (soyisim);
--4.yol
select concat(isim,' ',soyisim) as isim_soyisim from insalar
order by length (concat(isim,soyisim));


-- GROUP BY KULLANIMI
CREATE TABLE manav
(
isim varchar(50),  
Urun_adi varchar(50),  
Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select * from manav;
delete from manav;

--Isme gore alinan toplam urunleri listeleyiniz
select isim,sum(urun_miktar) as aldigi_toplam_urun
from manav
group by isim;

--Isme gore alinan toplam urunleri bulun ve urunleri büyükten küçüğe listeleyiniz
select isim,sum(urun_miktar) as aldigi_toplam_urun 
from manav
group by isim
order by aldigi_toplam_urun desc;

-- Urun ismine gore urunu alan toplam kisi sayisi
select urun_adi, count(isim) from manav
group by urun_adi;

select isim,count(urun_adi) as aldigi_urun_miktari from manav
group by isim;


select * from manav;



