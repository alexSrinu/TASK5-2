USE [FirstDB]
GO
/****** Object:  StoredProcedure [dbo].[InsertTask]    Script Date: 19-08-2024 10:29:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[InsertTask]
    @Name NVARCHAR(50),
    @Mobile NVARCHAR(20),
    @Email NVARCHAR(30),
    @StateId NVARCHAR(50),
    @CityId NVARCHAR(50)
	--@CityName varchar(50),
	--@StateName varchar(50)
AS
BEGIN
    INSERT INTO tb_task5 (Name, Mobile, Email, CityId,StateId)
    VALUES (@Name, @Mobile, @Email,@StateId,@CityId);
END