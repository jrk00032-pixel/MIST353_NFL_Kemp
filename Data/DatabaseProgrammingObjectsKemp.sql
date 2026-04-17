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


create or alter proc procGetTeamsForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    SELECT t.TeamName, cd.Conference, cd.Division, t.TeamColors
    FROM NFLFan F
    INNER JOIN dbo.Team t
        ON F.NFLFanID = t.TeamID
    INNER JOIN dbo.ConferenceDivision cd
        ON t.ConferenceDivisionID = cd.ConferenceDivisionID
    WHERE f.NFLFanID = @NFLFanID    

END

-- execute procGetTeamsForSpecifiedFan @NFLFanID = 1;

EXEC procValidateUser 'tom.brady@example.com', 'your_password_hash'




DROP PROCEDURE IF EXISTS procGetTeamsForSpecifiedFan;





create or alter procedure procGetTeamsByFanID
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


-- execute procGetTeamsByFanID @NFLFanID = 1;
-- execute procGetTeamsByFanID @NFLFanID = 2;

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