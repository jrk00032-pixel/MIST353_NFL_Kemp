-- Create a database for NFL app

-- use master;

-- create database MIST353_NFL_RDB_Kemp;

-- drop database NFL_RDB_Kemp;

use MIST353_NFL_RDB_Kemp;

-- Create tables for first iteration

create TABLE ConferenceDivision (
    ConferenceDivisionID int identity(1,1)
        CONSTRAINT PK_ConferenceDivisionID PRIMARY KEY,
    Conference NVARCHAR(50) not null,
        CONSTRAINT CHK_Conference CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) not null
        CONSTRAINT CHK_Division CHECK (Division IN ('East', 'North', 'South', 'West'))
);

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


