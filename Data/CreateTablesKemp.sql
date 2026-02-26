-- Create a database for NFL app
-- Create tables for ConferenceDivision and Team

/*

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


*/


