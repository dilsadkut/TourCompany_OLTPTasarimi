
/*
--------------------------------------------------------------------------------------------------------------------------------------
*************                                                                                                               **********
************										TOUR COMPANY RAPORLAR		  ************							              ************
**********                                                                                                               ************* 
--------------------------------------------------------------------------------------------------------------------------------------
*/

--En çok gezilen yer/yerler neresidir?

SELECT       
       B.BolgeAdi,
       COUNT(TS.TurId) AS ZiyaretSayisi      
FROM TurSatis TS
JOIN Tur T
ON TS.TurId = T.TurId
JOIN Bolge B
ON T.BolgeId = B.BolgeId
GROUP BY TS.TurId,B.BolgeAdi
ORDER BY TS.TurId DESC


--Ağustos ayında en çok çalışan rehber/rehberler kimdir/kimlerdir?

SELECT 
       R.RehberAd,
	   R.RehberSoyad,
       COUNT(*) AS KayitSayisi
FROM TurSatis TS
JOIN Rehber R
ON TS.RehberId = R.RehberId
WHERE MONTH(TS.TurunGerceklesmeTarihi)=08
GROUP BY R.RehberAd,R.RehberSoyad 
ORDER BY KayitSayisi DESC

/*Kadın turistlerin gezdiği yerleri, toplam ziyaret edilme sayılarıyla 
beraber listeleyin */

SELECT M.MusteriAdi,
       M.MusteriSoyadi,
	   M.Cinsiyet,
	   B.BolgeAdi,
	   SUM(B.BolgeId) AS ToplamZiyaretSayisi
FROM TurSatis TS
JOIN Musteri M
ON TS.MusteriId = M.MusteriId
JOIN Tur T
ON TS.TurId = T.TurId
JOIN Bolge B
ON B.BolgeId = T.BolgeId
WHERE M.Cinsiyet='Kadın'
GROUP BY M.MusteriAdi, M.MusteriSoyadi,M.Cinsiyet,B.BolgeAdi


--İngiltere’den gelip de Kız Kulesi’ni gezen turistler kimlerdir?

SELECT 
       M.MusteriAdi,
       M.MusteriSoyadi,
       Ul.Ulke,
       B.BolgeAdi   
FROM TurSatis TS
JOIN Tur T
ON T.TurId = TS.TurId
JOIN Bolge B
ON T.BolgeId = B.BolgeId
JOIN Musteri M
ON TS.MusteriId = M.MusteriId
JOIN Ulke Ul
ON M.UlkeId = Ul.UlkeId
WHERE Ul.UlkeId=3 AND B.BolgeAdi='Kız Kulesi' /* UlkeId 3 olanlar İngiltere'den gelenler */

--Gezilen yerler hangi yılda kaç defa gezilmiştir?

SELECT DISTINCT YEAR(TS.TurunGerceklesmeTarihi) AS Yil,
       B.BolgeAdi,
       SUM(TS.TurId) AS ZiyaretSayisi	  
FROM TurSatis TS
JOIN Tur T
ON TS.TurId=T.TurId
JOIN Bolge B
ON T.BolgeId = B.BolgeId
GROUP BY TS.TurunGerceklesmeTarihi, B.BolgeAdi


/*2’den fazla tura rehberlik eden rehberlerin en çok tanıttıkları 
yerler nelerdir? */

SELECT 
     R.RehberAd,
	 R.RehberSoyad,
     COUNT(*) AS TurSayisi,
	 B.BolgeAdi
FROM TurSatis TS
JOIN Tur T
ON TS.TurId = T.TurId
JOIN Bolge B
ON T.BolgeId =B.BolgeId
JOIN Rehber R
ON TS.RehberId = R.RehberId
GROUP BY R.RehberAd, R.RehberSoyad, B.BolgeAdi
HAVING COUNT(*)>2
ORDER BY B.BolgeAdi ASC
     
--İtalyan turistler en çok nereyi gezmiştir?

SELECT 
       B.BolgeAdi	  
FROM TurSatis TS
JOIN Tur T
ON TS.TurId = T.TurId
JOIN Musteri M
ON TS.MusteriId = M.MusteriId
JOIN Bolge B
ON T.BolgeId = B.BolgeId
JOIN Ulke Ul
ON M.UlkeId = Ul.UlkeId
WHERE Ul.UlkeId=1 /* UlkeId 1 ise Italya'dan gelmiş demektir */


--Kapalı Çarşı’yı gezen en yaşlı turist kimdir?

SELECT TOP 1 M.MusteriId, 
             M.MusteriAdi,
			 M.MusteriSoyadi,
			 M.DogumTarihi,
			 M.Cinsiyet
FROM Tur T
JOIN Bolge B
ON T.BolgeId = B.BolgeId
JOIN TurSatis TS
ON TS.TurId = T.TurId
JOIN Musteri M
ON M.MusteriId = TS.MusteriId
WHERE B.BolgeAdi ='Kapalı Çarşı'
ORDER BY M.DogumTarihi ASC

--Yunanistan’dan gelen Finlandiyalı turistin gezdiği yerler nerelerdir?

SELECT M.MusteriAdi,
       M.MusteriSoyadi,
	   Uy.Uyruk,
	   Ul.Ulke,
       B.BolgeAdi
FROM Musteri M
JOIN Uyruk Uy
ON M.UyrukId = Uy.UyrukId
JOIN Ulke Ul
ON M.UlkeId = Ul.UlkeId
JOIN TurSatis TS
ON M.MusteriId = TS.MusteriId
JOIN Tur T
ON T.TurId = TS.TurId
JOIN Bolge B
ON T.BolgeId = B.BolgeId
WHERE Uy.UyrukId=3 AND Ul.UlkeId=2 /* UyrukId 3 ise Finlandiyalı, UlkeId 2 ise Yunanistan'dan geliyor */

--Dolmabahçe Sarayı’na en son giden turistler ve rehberi listeleyin.

SELECT M.MusteriAdi,
       M.MusteriSoyadi,
	   M.DogumTarihi,
	   M.Cinsiyet,
	   R.RehberAd,
	   R.RehberSoyad
FROM Musteri M
JOIN TurSatis TS
ON M.MusteriId = TS.MusteriId
JOIN Tur T
ON T.TurId = TS.TurId
JOIN Bolge B
ON T.BolgeId = B.BolgeId
JOIN Rehber R
ON TS.RehberId = R.RehberId
WHERE B.BolgeAdi='Dolmabahçe Sarayı'
ORDER BY TS.TurunGerceklesmeTarihi DESC


