-- 3 queries
-- 1 each for ConferenceDivision and Team tables, and 1 join query


-- ConferenceDivision Querie

/*

SELECT 
    ConferenceDivisionID,
    Conference,
    Division
FROM dbo.ConferenceDivision
ORDER BY Conference, Division;


-- TEAM Querie 


SELECT 
    TeamID,
    TeamName,
    TeamCityState,
    TeamColors,
    ConferenceDivisionID

FROM dbo.Team
ORDER BY TeamName;


-- INNER JOIN Querie


SELECT 
    t.TeamName,
    t.TeamCityState,
    t.TeamColors,
    cd.Conference,
    cd.Division
FROM dbo.Team t
INNER JOIN dbo.ConferenceDivision cd
    ON t.ConferenceDivisionID = cd.ConferenceDivisionID
ORDER BY cd.Conference, cd.Division, t.TeamName;



-- INNER JOIN Querie with WHERE clause to filter for AFC East teams From Class Discussion

-- declare @myTeamName nvarchar(50) = 'Buffalo Bills';

/*

GO;

create or alter procedure procGetTeamsByConferenceDivision
(
    @Conference NVARCHAR(50) = null,
    @Division NVARCHAR(50) = null
)
AS 
BEGIN
    SELECT TeamName, TeamColors, Conference, Division
    FROM dbo.Team t
    INNER JOIN dbo.ConferenceDivision cd
        ON t.ConferenceDivisionID = cd.ConferenceDivisionID
        WHERE cd.Conference = ISNULL(@Conference, cd.Conference) 
            AND cd.Division = ISNULL(@Division, cd.Division)
    ORDER BY t.TeamName;
END


-- Example execution of the stored procedure
-- EXEC procGetTeamsByConferenceDivision @Conference = 'AFC', @Division = 'East';

GO;







GO

CREATE OR ALTER PROCEDURE procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
(
    @TeamName NVARCHAR(100)
)
AS
BEGIN
    SELECT t2.TeamName,
           cd.Conference,
           cd.Division
    FROM dbo.Team t1
    INNER JOIN dbo.ConferenceDivision cd
        ON t1.ConferenceDivisionID = cd.ConferenceDivisionID
    INNER JOIN dbo.Team t2
        ON t2.ConferenceDivisionID = cd.ConferenceDivisionID
    WHERE t1.TeamName = @TeamName
      AND t2.TeamName <> @TeamName
    ORDER BY t2.TeamName;
END

GO

*/


/*
GO

create or alter PROCEDURE procValidateUser
(
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(200)
)
AS
BEGIN
    SELECT AppUserID, FirstName + ' ' + LastName AS FullName, UserRole
    FROM dbo.AppUser
    WHERE Email = @Email
      AND PasswordHash = Convert(VARBINARY(200), @PasswordHash, 1);
END


-- execute procValidateUser @Email = 'tom.brady@example.com', @PasswordHash = 0x01;
-- select * from AppUser;





/*
GO






DROP PROCEDURE IF EXISTS procGetTeamsForSpecifiedFan;


SELECT DB_NAME() AS CurrentDatabase;

SELECT name
FROM sys.procedures
WHERE name LIKE '%Fan%';

IF OBJECT_ID('procGetTeamsByFanID', 'P') IS NOT NULL
    DROP PROCEDURE procGetTeamsByFanID;

create or alter procedure procGetTeamsForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    SELECT t.TeamName, cd.Conference, cd.Division, t.TeamColors, ft.PrimaryTeam
    FROM FanTeam ft
    INNER JOIN dbo.Team t
        ON ft.TeamID = t.TeamID
    INNER JOIN dbo.ConferenceDivision cd
        ON t.ConferenceDivisionID = cd.ConferenceDivisionID
    WHERE ft.NFLFanID = @NFLFanID   

END


-- execute procGetTeamsForSpecifiedFan @NFLFanID = 1;
-- execute procGetTeamsForSpecifiedFan @NFLFanID = 2;

EXEC procGetTeamsByFanID @NFLFanID = 1;



USE [MIST353-NFL-Kemp];
GO

GRANT EXECUTE ON dbo.procGetTeamsByFanID TO Aplogin;
GO


USE [MIST353-NFL-Kemp];
GO

CREATE USER Aplogin FOR LOGIN Aplogin;
GO

GRANT EXECUTE ON dbo.procGetTeamsByFanID TO Aplogin;
GO

SELECT SUSER_SNAME() AS CurrentLogin;
SELECT USER_NAME() AS CurrentDatabaseUser;

USE [MIST353-NFL-Kemp];
GO
GRANT EXECUTE ON dbo.procGetTeamsByFanID TO Aplogin;
GO

SELECT name FROM sys.server_principals WHERE name = 'Aplogin';


USE [MIST353-NFL-Kemp];
GO
CREATE USER Aplogin FOR LOGIN Aplogin;
GO
GRANT EXECUTE ON dbo.procGetTeamsByFanID TO Aplogin;
GO

SELECT SUSER_SNAME() AS LoginName, USER_NAME() AS DatabaseUser;

-- Check if Aplogin user already exists in the database
SELECT name FROM sys.database_principals WHERE name = 'Aplogin';



go 


create or alter procedure procSceduleGame
(
    @HomeTeamID INT,
    @AwayTeamID INT,
    @GameRound NVARCHAR(50),
    @GameDate DATE,
    @GameStartTime TIME,
    @StadiumID INT,
    @NFLAdminID INT
)
AS 
BEGIN
    -- store the NFLAdminID in context so that the trigger can access it when inserting into AdminChangesTracker

    declare @context VARBINARY(128) = cast(@NFLAdminID as VARBINARY(128));
    SET CONTEXT_INFO @context;

    INSERT INTO Game (HomeTeamID, AwayTeamID, GameRound, GameDate, GameStartTime, StadiumID)
    VALUES (@HomeTeamID, @AwayTeamID, @GameRound, @GameDate, @GameStartTime, @StadiumID);
END


execute procScheduleGame
    @HomeTeamID = 17, 
    @AwayTeamID = 19, 
    @GameRound = 'Wild Card', 
    @GameDate = '2026-01-10', 
    @GameStartTime = '20:00', 
    @StadiumID = 17, 
    @NFLAdminID = 6;

    delete from Game where GameID = 12;

    select * from Game;


print(df.columns)  # or st.write(df.columns)







-- trigger to track changes made by the Admin to the Game table


create or alter trigger trgTrackChangesOnSchedulingGame
on Game
after insert
as
BEGIN
    declare @NFLAdminID INT;
    declare @GameID INT;
    declare @ChangeType NVARCHAR(50);
    declare @ChangeDescription NVARCHAR(500);
    declare @GameRound NVARCHAR(50);
    declare @GameDate DATE;
    declare @GameStartTime TIME;
    declare @HomeTeamID INT;
    declare @AwayTeamID INT;
    declare @HomeTeamName NVARCHAR(50);
    declare @AwayTeamName NVARCHAR(50);
    declare @StadiumID INT;
    declare @StadiumName NVARCHAR(100);
    declare @AdminFullName NVARCHAR(100);

    -- get the NFLAdminID from context
    set @NFLAdminID = convert(int, convert(binary(4),context_info()));

    -- get the GameID of the newly inserted game
    select @GameID = GameID, @GameRound = GameRound, @GameDate = GameDate, @GameStartTime = GameStartTime,
        @HomeTeamID = HomeTeamID, @AwayTeamID = AwayTeamID, @StadiumID = StadiumID
    from inserted;
    select @HomeTeamName = TeamName from Team where TeamID = @HomeTeamID;
    select @AwayTeamName = TeamName from Team where TeamID = @AwayTeamID;
    select @StadiumName = StadiumName from Stadium where StadiumID = @StadiumID;
    select @AdminFullName = Firstname + ' ' + Lastname from AppUser where AppUserID = @NFLAdminID;

    set @ChangeType = 'Insert';
    set @ChangeDescription = @AdminFullName + ' scheduled a new game with GameID ' + cast(@GameID as NVARCHAR(50))
        + ' at ' + @HomeTeamName + ' vs ' + @AwayTeamName + ' on ' + cast(@GameDate as NVARCHAR(50))
        + ' at ' + cast(@GameStartTime as NVARCHAR(50)) + ' in stadium ' + @StadiumName
        + '. Game round: ' + @GameRound;

    insert into AdminChangesTracker (NFLAdminID, GameID, ChangeType, ChangeDescription)
    values (@NFLAdminID, @GameID, @ChangeType, @ChangeDescription);

    END




select * from Game order by GameID desc;

delete from Game where GameID = 11;








GO

CREATE OR ALTER PROCEDURE procEnterScores
(
    @GameID INT,
    @HomeTeamScore INT,
    @AwayTeamScore INT,
    @NFLAdminID INT
)
AS
BEGIN
    DECLARE @context VARBINARY(128) = CAST(@NFLAdminID AS VARBINARY(128));
    SET CONTEXT_INFO @context;

    UPDATE Game
    SET HomeTeamScore = @HomeTeamScore,
        AwayTeamScore = @AwayTeamScore,
        WinningTeamID = CASE
            WHEN @HomeTeamScore > @AwayTeamScore THEN HomeTeamID
            WHEN @AwayTeamScore > @HomeTeamScore THEN AwayTeamID
            ELSE NULL
        END
    WHERE GameID = @GameID;
END

GO

CREATE OR ALTER TRIGGER trgTrackChangesOnEnteringScores
ON Game
AFTER UPDATE
AS
BEGIN
    DECLARE @NFLAdminID INT;

    SET @NFLAdminID = CONVERT(INT, CONVERT(BINARY(4), CONTEXT_INFO()));

    INSERT INTO AdminChangesTracker
    (
        NFLAdminID,
        GameID,
        ChangeType,
        ChangeDescription
    )
    SELECT
        @NFLAdminID,
        i.GameID,
        'Update',
        au.FirstName + ' ' + au.LastName
            + ' updated scores for GameID ' + CAST(i.GameID AS NVARCHAR(50))
            + ': Home=' + ht.TeamName + ' (' + CAST(i.HomeTeamScore AS NVARCHAR(50)) + ')'
            + ', Away=' + at.TeamName + ' (' + CAST(i.AwayTeamScore AS NVARCHAR(50)) + ')'
            + ', WinningTeam=' + wt.TeamName
    FROM inserted i
    INNER JOIN Team ht
        ON i.HomeTeamID = ht.TeamID
    INNER JOIN Team at
        ON i.AwayTeamID = at.TeamID
    INNER JOIN Team wt
        ON i.WinningTeamID = wt.TeamID
    INNER JOIN AppUser au
        ON au.AppUserID = @NFLAdminID;
END

GO



create or alter procedure procGetAllChangesMadeBySpecifiedAdmin

(

    @NFLAdminID INT

)

as

begin

    select ACT.ChangeDateTime, ACT.ChangeType, ACT.ChangeDescription,

    G.GameRound, G.GameDate, G.GameStartTime,

    HT.TeamName as HomeTeam, AT.TeamName as AwayTeam, S.StadiumName

    from AdminChangesTracker ACT inner join Game G

        on ACT.GameID = G.GameID

        inner join Team HT

        on G.HomeTeamID = HT.TeamID

        inner join Team AT

        on G.AwayTeamID = AT.TeamID

        inner join Stadium S

        on G.StadiumID = S.StadiumID

    where ACT.NFLAdminID = @NFLAdminID

    order by ACT.ChangeDateTime desc;

end


-- execute procGetAllChangesMadeBySpecifiedAdmin @NFLAdminID = 5; -- Bill Belichick