CREATE TABLE ogrenciler4
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);

INSERT INTO ogrenciler4 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler4 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler4 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler4 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler4 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler4 VALUES(127, 'Mustafa Bak', 'Ali', 99);

SELECT * FROM ogrenciler4;

-- ısmi MUSTAFA BAK VE NESİBE YILMAZ OLAN KAYITLARI SİL
DELETE FROM ogrenciler4 WHERE  isim = 'Nesibe Yilmaz' or isim = 'Mustafa Bak';

-- VELİ İSMİ HASAN OLAN DATAYI SİLELİM

DELETE FROM ogrenciler4 Where veli_isim='Hasan';

--TRANCUTE 
--BİR TABLODAKİ TUM VERİLERİ GERİ ALAMICMIZ SEKİLDE SİLER, SARTLI SİLME YAPMAZ

Truncate table ogrenciler4;

--ON DELETE CASCADE
DROP TABLE IF EXISTS talebeler -- eger adresler tablosu varsa siler

CREATE TABLE talebeler
(
id char(3) primary key,
isim varchar(50),
veli_isim varchar(50),
yazili_notu int	
);

drop table if exists notlar;

CREATE TABLE notlar
(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
Constraint notlar_fk FOREIGN KEY (talebe_id) references talebeler(id)
on delete cascade	
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar;

--notlar tabsosundan id si 123 olan datayi silelim. sadece child classti veriyi siler
delete from notlar where talebe_id = '123';

-- talebeler tablosundan id si 126 olan datayı silelim.on delete cascade kulldngmz icin silebiliyoruz ve her iki kısımdan da veriler siliniyor.
delete from talebeler where id ='126';

/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/

--in condition
DROP TABLE if exists musteriler
 
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
 
SELECT * FROM musteriler
-- Musteriler tablosundan urun ismi orange, apple veya apricot olan tüm verileri listeleyiniz
select * from musteriler where urun_isim ='Orange' or urun_isim = 'Apple' or urun_isim = 'Apricot';
select * from musteriler where urun_isim ='Orange' and musteri_isim='Adem';
-- IN CONDITION
SELECT * FROM musteriler where urun_isim in('Orange','Apple','Apricot');

--not in ---yazdigimiz verilerin disindakileri getirir.
SELECT * FROM musteriler where urun_isim not in('Orange','Apple','Apricot');



