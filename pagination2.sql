USE [FirstDB]
GO
/****** Object:  StoredProcedure [dbo].[GetPagedData]    Script Date: 26-07-2024 10:45:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetPagedData] 
    @PageSize INT=0,
    @PageNumber INT,
	@TotalCount int out
AS
BEGIN
   DECLARE @Offset INT;
    SET @Offset = (@PageNumber - 1) * @PageSize;
    SET NOCOUNT ON;
	 set @PageSize =  case when @PageSize =0 or @PageSize is null then 10;


 
	set @TotalCount=(select * from TB_Hostel where IsActive=1)/@PazeSize;
	
    SELECT *
    FROM TB_Hostel where IsActive=1
    ORDER BY Name
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END
ALTER PROCEDURE [dbo].[GetPagedData] 
    @PageSize INT = 0,
    @PageNumber INT,
    @TotalCount INT OUT
AS
BEGIN
    SET NOCOUNT ON;

   
    IF @PageSize = 0 OR @PageSize IS NULL
    BEGIN
        SET @PageSize = 3;
    END

   
    DECLARE @Offset INT;
    SET @Offset = (@PageNumber - 1) * @PageSize;

   
    SELECT @TotalCount = COUNT(*)
    FROM TB_Hostel 
    WHERE IsActive = 1;

   
    SELECT *
    FROM TB_Hostel 
    WHERE IsActive = 1
    ORDER BY Name
    OFFSET @Offset ROWS 
    FETCH NEXT @PageSize ROWS ONLY;
END
DECLARE @TotalCount INT;

EXEC [dbo].[GetPagedData] 
    @PageSize = 3, 
    @PageNumber = 2, 
    @TotalCount = @TotalCount OUTPUT;

-- Now you can use @TotalCount to see the total number of records
SELECT @TotalCount AS TotalCount;
select * from TB_Hostel where isactive=1
select * from candidates  where email='yashna@gmail.com' and Password='963852' ;