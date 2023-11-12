USE db_zooTest3;
GO

/*convert(varchar(50), @totalHub) = this is converting the data from MONEY to VARCHAR
char(13) line break
char(9) tab key */

DECLARE @totalHab MONEY;
DECLARE @totalNut MONEY;
DECLARE @results MONEY;

SET @totalHab = (SELECT SUM(habitat_cost) FROM tbl_habitat);
SET @totalNut = (SELECT SUM(nutrition_cost) FROM tbl_nutrition);
SET @results = (@totalHab + @totalNut);

PRINT (
    CONVERT(VARCHAR(50), @totalHab) + CHAR(9) + ' - Total habitat cost' + CHAR(13) + CHAR(10) +
    CONVERT(VARCHAR(50), @totalNut) + CHAR(9) + ' - total nutrition cost' + CHAR(13) + + CHAR(10) + '--------' + CHAR(13) + CHAR(10) +
    CONVERT(VARCHAR(50), @results)
);