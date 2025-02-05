USE [FirstDB]
GO
/****** Object:  StoredProcedure [dbo].[UpdateTask]    Script Date: 19-08-2024 12:26:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UpdateTask]
    @Id INT,
    @Name NVARCHAR(50),
    @Mobile NVARCHAR(20),
    @Email NVARCHAR(30),
    @StateName NVARCHAR(50),
    @CityName NVARCHAR(50)
AS
BEGIN
    UPDATE tb_task5
    SET 
        Name = @Name,
        Mobile = @Mobile,
        Email = @Email,
        StateName = @StateName,
        CityName = @CityName
    WHERE Id = @Id;
END