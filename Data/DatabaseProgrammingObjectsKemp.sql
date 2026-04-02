-- 3 queries
-- 1 each for ConferenceDivision and Team tables, and 1 join query


-- ConferenceDivision Querie


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