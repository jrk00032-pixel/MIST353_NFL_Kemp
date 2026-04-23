-- Create a database for NFL app
-- Create tables for ConferenceDivision and Team

/* Drop tables if they already exist 
if(OBJECT_ID() IS NOT NULL)
    DROP TABLE Team;


*/



if(OBJECT_ID('AdminChangesTracker') is not null)
    drop table AdminChangesTracker;
if(OBJECT_ID('TeamStadium') is not null)
    drop table TeamStadium;
if(OBJECT_ID('Game') is not null)
    drop table Game;
if(OBJECT_ID('Stadium') is not null)
    drop table Stadium;

if(OBJECT_ID('FanTeam') is not null)
    drop table FanTeam;
if(OBJECT_ID('Team') is not null)
    drop table Team;
if(OBJECT_ID('ConferenceDivision') is not null)
    drop table ConferenceDivision;
if(OBJECT_ID('NFLAdmin') is not null)
    drop table NFLAdmin;
if(OBJECT_ID('NFLFan') is not null)
    drop table NFLFan;
if(OBJECT_ID('AppUser') is not null)
    drop table AppUser;





-- create tables for First iteration

create TABLE ConferenceDivision (
    ConferenceDivisionID int identity(1,1)
        CONSTRAINT PK_ConferenceDivisionID PRIMARY KEY,
    Conference NVARCHAR(50) not null,
        CONSTRAINT CHK_Conference CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) not null
        CONSTRAINT CHK_Division CHECK (Division IN ('East', 'North', 'South', 'West'))
    CONSTRAINT UQ_ConferenceDivision UNIQUE (Conference, Division)
);

/*
alter table ConferenceDivision
NOCHECK CONSTRAINT CK_ConferenceNames;

alter table ConferenceDivision
CHECK CONSTRAINT CK_DivisionNames;
*/

GO

create table Team (
    TeamID int identity(1,1)
        CONSTRAINT PK_TeamID PRIMARY KEY,
    TeamName NVARCHAR(50) not null,
    TeamCityState NVARCHAR(50) not null,
    TeamColors NVARCHAR(50) not null,
    ConferenceDivisionID int not null,
        CONSTRAINT FK_Team_ConferenceDivisionID FOREIGN KEY (ConferenceDivisionID) REFERENCES ConferenceDivision(ConferenceDivisionID)
);




-- create tables for second iteration
GO

create table AppUser (
    AppUserID int identity(1,1)
        CONSTRAINT PK_AppUserID PRIMARY KEY,
    FirstName NVARCHAR(50) not null,
    LastName NVARCHAR(50) not null,
    Email NVARCHAR(100) not null
        CONSTRAINT UQ_AppUser_Email UNIQUE,

    PasswordHash VARBINARY(200) not null,
    Phone NVARCHAR(50) null,
    UserRole NVARCHAR(50) not null
        CONSTRAINT CHK_UserRole CHECK (UserRole IN (N'NFLAdmin', N'NFLFan'))
);


GO

create table NFLFan(
    NFLFanID int
        CONSTRAINT PK_NFLFanID PRIMARY KEY
        CONSTRAINT FK_NFLFan_AppUserID FOREIGN KEY REFERENCES AppUser(AppUserID)

);

GO

create table NFLAdmin(
    NFLAdminID int
        CONSTRAINT PK_NFLAdminID PRIMARY KEY
        CONSTRAINT FK_NFLAdmin_AppUserID FOREIGN KEY REFERENCES AppUser(AppUserID)

);

GO

create table FanTeam(
    FanTeamID int identity(1,1)
        CONSTRAINT PK_FanTeamID PRIMARY KEY,
    NFLFanID int not null
        CONSTRAINT FK_FanTeam_NFLFanID FOREIGN KEY REFERENCES NFLFan(NFLFanID),
    TeamID int not null
        CONSTRAINT FK_FanTeam_TeamID 
            FOREIGN KEY REFERENCES Team(TeamID),
        CONSTRAINT UQ_FanTeam UNIQUE (NFLFanID, TeamID),
    PrimaryTeam BIT not null  
);

GO



create table Stadium (
    StadiumID INT identity(1,1)
        constraint PK_Stadium PRIMARY KEY,
    StadiumName NVARCHAR(100) NOT NULL,
    StadiumCityState NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL
);

go


create table TeamStadium (
    TeamStadiumID INT identity(1,1)
        constraint PK_TeamStadium PRIMARY KEY,
    TeamID INT NOT NULL
        constraint FK_TeamStadium_Team FOREIGN KEY REFERENCES Team(TeamID),
    StadiumID INT NOT NULL
        constraint FK_TeamStadium_Stadium FOREIGN KEY REFERENCES Stadium(StadiumID),
    StartYear INT NOT NULL,
    EndYear INT NULL,
    constraint UK_TeamStadium UNIQUE (TeamID, StadiumID, StartYear)
);

go


create table Game (
    GameID INT identity(1,1)
        constraint PK_Game PRIMARY KEY,
    GameRound NVARCHAR(50) NOT NULL
        constraint CK_GameRound CHECK (GameRound IN ('Wild Card', 'Divisional', 'Conference', 'Super Bowl')),
    GameDate DATE NOT NULL,
    GameStartTime TIME NOT NULL,
    HomeTeamID INT NOT NULL
        constraint FK_Game_HomeTeam FOREIGN KEY REFERENCES Team(TeamID),
    AwayTeamID INT NOT NULL
        constraint FK_Game_AwayTeam FOREIGN KEY REFERENCES Team(TeamID),
    StadiumID INT NOT NULL
        constraint FK_Game_Stadium FOREIGN KEY REFERENCES Stadium(StadiumID),
    HomeTeamScore INT NULL,
    AwayTeamScore INT NULL,
    WinningTeamID INT NULL
        constraint FK_Game_WinningTeam FOREIGN KEY REFERENCES Team(TeamID),
    constraint CK_Game_Teams CHECK (HomeTeamID != AwayTeamID),
    constraint UK_Game UNIQUE (HomeTeamID, AwayTeamID, GameDate)
);



create table AdminChangesTracker (
    AdminChangesTrackerID INT identity(1,1)
        constraint PK_AdminChangesTracker PRIMARY KEY,
    NFLAdminID INT NOT NULL
        constraint FK_AdminChangesTracker_NFLAdmin FOREIGN KEY REFERENCES NFLAdmin(NFLAdminID),
    GameID INT NOT NULL
        constraint FK_AdminChangesTracker_Game FOREIGN KEY REFERENCES Game(GameID),
    ChangeDateTime DATETIME NOT NULL DEFAULT GETDATE(),
    ChangeType NVARCHAR(50) NOT NULL
        constraint CK_AdminChangesTracker_ChangeType CHECK (ChangeType IN (N'Insert', N'Update', N'Delete')),
    ChangeDescription NVARCHAR(500) NOT NULL
);



SELECT DB_NAME() AS CurrentDatabase;
GO

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Team';
GO