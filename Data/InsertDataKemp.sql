-- Insert Data
-- Insert all the ConferenceDivision data (8 rows)
-- Insert team data for AFC North (4 rows)


--use MIST353_NFL;


/*


Insert into dbo.ConferenceDivision (Conference, Division)
values ('AFC', 'North'),
       ('AFC', 'East'),
       ('AFC', 'South'),
       ('AFC', 'West'),
       ('NFC', 'North'),
       ('NFC', 'East'),
       ('NFC', 'South'),
       ('NFC', 'West');




Insert into dbo.Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
values ('Baltimore Ravens', 'Baltimore, MD', 'Purple, Black, Metallic Gold', 1),
       ('Cincinnati Bengals', 'Cincinnati, OH', 'Black, Orange, White', 1),
       ('Cleveland Browns', 'Cleveland, OH', 'Brown, Orange, White', 1),
       ('Pittsburgh Steelers', 'Pittsburgh, PA', 'Black, Gold, White', 1),

        ('Buffalo Bills', 'Buffalo, NY', 'Royal Blue, Red, White', 2),
        ('Miami Dolphins', 'Miami, FL', 'Aqua, Orange, White', 2),
        ('New England Patriots', 'Foxborough, MA', 'Navy Blue, Red, Silver', 2),
        ('New York Jets', 'East Rutherford, NJ', 'Green, White', 2),

        ('Houston Texans', 'Houston, TX', 'Deep Steel Blue, Battle Red, Liberty White', 3),
        ('Indianapolis Colts', 'Indianapolis, IN', 'Royal Blue, White', 3),
        ('Jacksonville Jaguars', 'Jacksonville, FL', 'Teal, Black, Gold, White', 3),
        ('Tennessee Titans', 'Nashville, TN', 'Titans Navy, Titans Light Blue, Red, Silver', 3),

        ('Denver Broncos', 'Denver, CO', 'Orange, Navy Blue, White', 4),
        ('Kansas City Chiefs', 'Kansas City, MO', 'Red, Gold, White', 4),
        ('Las Vegas Raiders', 'Las Vegas, NV', 'Silver, Black', 4),
        ('Los Angeles Chargers', 'Los Angeles, CA', 'Powder Blue, Gold, White', 4),

        ('Chicago Bears', 'Chicago, IL', 'Navy Blue, Orange, White', 5),
        ('Detroit Lions', 'Detroit, MI', 'Honolulu Blue, Silver, White', 5),
        ('Green Bay Packers', 'Green Bay, WI', 'Dark Green, Gold, White', 5),
        ('Minnesota Vikings', 'Minneapolis, MN', 'Purple, Gold, White', 5),

        ('Dallas Cowboys', 'Arlington, TX', 'Navy Blue, Metallic Silver, White', 6),
        ('New York Giants', 'East Rutherford, NJ', 'Royal Blue, Red, White', 6),
        ('Philadelphia Eagles', 'Philadelphia, PA', 'Midnight Green, Silver, Black, White', 6),
        ('Washington Commanders', 'Landover, MD', 'Burgundy, Gold, White', 6),

        ('Atlanta Falcons', 'Atlanta, GA', 'Red, Black, Silver, White', 7),
        ('Carolina Panthers', 'Charlotte, NC', 'Black, Panther Blue, Silver, White', 7),
        ('New Orleans Saints', 'New Orleans, LA', 'Old Gold, Black, White', 7),
        ('Tampa Bay Buccaneers', 'Tampa, FL', 'Red, Pewter, Black, White', 7),

        ('Arizona Cardinals', 'Glendale, AZ', 'Cardinal Red, Black, White', 8),
        ('Los Angeles Rams', 'Los Angeles, CA', 'Royal Blue, Sol Gold, White', 8),
        ('San Francisco 49ers', 'San Francisco, CA', 'Scarlet Red, Gold, White', 8),
        ('Seattle Seahawks', 'Seattle, WA', 'College Navy, Action Green, Wolf Grey, White', 8);


*/




Select * from dbo.ConferenceDivision;
Select * from dbo.Team;

--GO;


-- SELECT DB_NAME() AS CurrentDatabase;

/*

SELECT * 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'ConferenceDivision';

*/

