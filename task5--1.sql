--stored procedures

CREATE PROCEDURE InsertTask
    @Name NVARCHAR(50),
    @Mobile NVARCHAR(20),
    @Email NVARCHAR(30),
    @StateId NVARCHAR(50),
    @CityId NVARCHAR(50)
AS
BEGIN
    INSERT INTO tb_task5 (Name, Mobile, Email, StateId, CityId)
    VALUES (@Name, @Mobile, @Email, @StateId, @CityId);
END
--update stored procedure
CREATE PROCEDURE UpdateTask
    @Id INT,
    @Name NVARCHAR(50),
    @Mobile NVARCHAR(20),
    @Email NVARCHAR(30),
    @StateId NVARCHAR(50),
    @CityId NVARCHAR(50)
AS
BEGIN
    UPDATE tb_task5
    SET 
        Name = @Name,
        Mobile = @Mobile,
        Email = @Email,
        StateId = @StateId,
        CityId = @CityId
    WHERE Id = @Id;
END
---delete stored procedure

CREATE PROCEDURE DeleteTask
    @Id INT
AS
BEGIN
    DELETE FROM tb_task5
    WHERE Id = @Id;
	

--------------------select stored procedure---------------
SELECT * FROM task5city WHERE StateId = 's2'
create procedure selecttask(@id int)
as begin
select * from tb_task5 where(Id=@id)
end
------------------PAGINATION STORED PROCEDURE----------------
CREATE PROCEDURE PageTask
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
    FROM  tb_task5 
 SELECT *
    FROM tb_task5 
    ORDER BY Name
    OFFSET @Offset ROWS 
    FETCH NEXT @PageSize ROWS ONLY;
END
declare @totalcount int;
exec [dbo].[PageTask]
@PageSize=2,
@PageNumber=2,
@TotalCount=@TotalCount output;
select @totalcount as totalcount
insert into tb_task5 values('Alekhya','9988774455','alekhya126@gmail.com','s1','c1')
select * from tb_task5
insert into tb_task5 values('Srinu','9879056230','srinu@gmail.com','s1','c1')
insert into tb_task5 values('Geetha','9852032145','geetha@gmail.com','s1','c1')
insert into tb_task5 values('Shiva','8974562130','shiva@gmail.com','s1','c1')
