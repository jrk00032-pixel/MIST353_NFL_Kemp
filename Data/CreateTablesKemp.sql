-- Create a database for NFL app
-- Create tables for ConferenceDivision and Team

/* Drop tables if they already exist 
if(OBJECT_ID() IS NOT NULL)
    DROP TABLE Team;


*/

if(OBJECT_ID('FanTeam') IS NOT NULL)
    DROP TABLE FanTeam;

if(OBJECT_ID('NFLFan') IS NOT NULL)
    DROP TABLE NFLFan;

if(OBJECT_ID('NFLAdmin') IS NOT NULL)
    DROP TABLE NFLAdmin;        

if(OBJECT_ID('Team') IS NOT NULL)
    DROP TABLE Team;

if(OBJECT_ID('ConferenceDivision') IS NOT NULL)
    DROP TABLE ConferenceDivision; 

if(OBJECT_ID('AppUser') IS NOT NULL)
    DROP TABLE AppUser;





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

