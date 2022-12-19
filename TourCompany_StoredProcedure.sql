/*
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
							TOUR COMPANY STORED PROCEDURE 
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
*/

-- Yaş değeri 60'tan büyük olan turistlere özel faturada tur ücretinde %15 indirim yapan stored procedure

SELECT DATEDIFF(YEAR,M.DogumTarihi,GETDATE()) AS Yas
	FROM TurSatis TS
	JOIN Musteri M
	ON TS.MusteriId = M.MusteriId
	JOIN Tur T
	ON TS.TurId = T.TurId

CREATE PROCEDURE sp_IndirimYap
(
   @SatisId AS INT,
   @MusteriId AS INT,
   @TurId AS INT,
   @Yas AS INT
)
AS
BEGIN
    SET @SatisId = (SELECT SatisId FROM TurSatis WHERE SatisId=@SatisId)
    SET @MusteriId = (SELECT MusteriId  FROM TurSatis WHERE SatisId=@SatisId)
	SET @TurId = (SELECT TurId FROM TurSatis WHERE SatisId=@SatisId)
	SET @Yas = (SELECT DATEDIFF(YEAR,M.DogumTarihi,GETDATE()) AS Yas
	            FROM TurSatis TS
	            JOIN Musteri M
	            ON TS.MusteriId = M.MusteriId
	            JOIN Tur T
	            ON TS.TurId = T.TurId
	            WHERE TS.MusteriId = @MusteriId )

       IF(@Yas)>60
	     BEGIN
	     UPDATE Tur 
	     SET TurUcreti = TurUcreti * 15 /100 * -1
	     WHERE TurId = @TurId
	     END	
	   ELSE
	     BEGIN
	     UPDATE Tur
	     SET TurUcreti = TurUcreti
	     WHERE TurId = @TurId
	     END
END











