/* PRINT / DECLARE / SET / BEGIN END */

print 'Hello World!'

declare @myVariable INT
set @myVariable = 8
print @myVariable

declare @var10 int, @var20 INT
set @var10 = 33
set @var20 = 55
print @var10
print @var20

print 'I am playing with ' + 'TSQL and SQL SERVER '
print 'I have ' + convert(varchar(50), @var1) + ' dollars. '


DECLARE @var1 INT, @var2 INT
SET @var1 = 3
SET @var2 = 5

PRINT CHAR(9) + 'I have ' + CONVERT(VARCHAR(50), @var1) + CHAR(13) + ' dollars...'
PRINT 'Variable 1 =  ' + CONVERT(VARCHAR(5), @var1) + CHAR(13) + 'Variable 2 =  ' + CONVERT(VARCHAR(5), @var2)
PRINT 'Variable 1 =  ' + CONVERT(VARCHAR(5), @var1) + CHAR(13) + 'Variable 2 =  ' + CONVERT(VARCHAR(5), @var2) 
+ CHAR(13) + 'Total: '
PRINT @var1 + @var2


DECLARE @var3 INT, @var4 INT
SET @var3 = 17
SET @var4 = 87

IF @var3 <= 33
	BEGIN
PRINT 'Variable 3 <=  ' + CONVERT(VARCHAR(5), @var3) + CHAR(13)
END
ELSE
	BEGIN
		PRINT  'Variable 3 is not <  ' + CONVERT(VARCHAR(5), @var3) + CHAR(13)
	END

IF @var3 != 3
	BEGIN
		PRINT 'Variable 3 is NOT  ' + CONVERT(VARCHAR(5), @var3) + CHAR(13)
	END
ELSE
	BEGIN
		PRINT  'Variable 3 is not <  ' + CONVERT(VARCHAR(5), @var3) + CHAR(13)
	END


DECLARE @var5 INT, @var6 INT
SET @var5 =  3
SET @var6 = 5

IF  @var5 < 2
	BEGIN 
		PRINT '@var5 < 2'
	END
ELSE IF @var5 > 1 AND @var5 < 3
	BEGIN
		PRINT  '@var5 > 1 AND @var5 < 3'
	END

ELSE IF @var5 = 4 OR @var5 < 6
	BEGIN
		PRINT '@var5 = 4 OR @var5 < 6'
	END
ELSE
		PRINT '@var5 does not qualify!'