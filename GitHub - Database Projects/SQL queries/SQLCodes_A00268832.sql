Drop Table Venue;
Drop Table Concert;
Drop Table Journalist;
Drop Table Concert Pass;
Drop Table Newspaper;
Drop Table Sponsor;

Create Table Venue (
Venue_Id Number(2) Not Null,
Name Varchar2(28) Not Null, 
Address Varchar2(22) Not Null,
City Varchar2(14) Not Null,
Country Varchar2(7) Not Null,
Category Varchar2(7) Not Null,
Type Varchar2(10) Not Null,
Year_Built Varchar2(4) Not Null,
Cost Number(9,2) Not Null,
Capacity Number(4) Not Null,
Email Varchar2(28) Not Null,
Web_Site Varchar2(73) Not Null,
Constraint Venue_Venue_Id_Pk Primary Key(Venue_Id),
Constraint Venue_Category_Ck Check(Category In (‘Indoor’, ‘Outdoor’)),
Constraint Venue_Type_Ck Check(Type In (‘All Seater’, ‘Terrace’, ‘Covered’)),
Constraint Venue_Email_Uq Unique(Email),
Constraint Venue_Web_Site_Uq Unique(Web_Site));





Create Table Newspaper(
   Newspaper_Id Number(8) Not Null,
   Name Varchar2(9) Not Null,
   Address Varchar2(11) Not Null,
   Town Varchar2(8) Not Null,
   County Varchar2(9) Not Null,
   Year_Founded Number(4) Not Null,
   Category Varchar2(10) Not Null,
   Email Varchar2(28) Not Null,
   Web_Site_Address Varchar2(60) Not Null,
   Annual_Turnover Decimal(7,2) Not Null,
  Constraint Newspaper_Newspaper_Id_Pk Primary Key(Newspaper_Id),
  Constraint Newspaper_Category_Ck Check(Category In ('Tabloid','Broadsheet')),
  Constraint Newspaper_Email_Uq Unique(Email),
  Constraint Newspaper_Web_Site_Address_Uq Unique(Web_Site_Address));

Create Table Sponsor(
Sponsor_Id Number(4) Not Null,
Name Varchar2(18) Not Null,
Address Varchar2(19) Not Null,
Town Varchar2(7) Not Null,
County Varchar2(9) Not Null,
Tel_No Number(10) Not Null,
Web_Site Varchar2(66) Not Null,
Business_Type Varchar2(13) Not Null,
Sponsorship_Budget Number(5) Not Null,
Constraint Sponsor_Sponsor_Id_Pk Primary Key(Sponsor_Id),
Constraint Sponsor_Tel_No_Uq Unique(Tel_No),
Constraint Sponsor_Web_Site_Uq Unique(Web_Site),
Constraint Sponsor_Business_Type_Ck Check(Business_Type In ('Finance', 'Manufacturing', 'Media')));

Create Table Journalist(
Journalist_Id Number(9) Not Null,
Forename Varchar2(12) Not Null,
Surname Varchar2(11) Not Null,
Address Varchar2(22) Not Null,
Town Varchar2(8) Not Null,
County Varchar2(11) Not Null,
Gender Varchar2(6) Not Null,
Date_Of_Birth Date Not Null,
Qualifications Varchar2(6) Not Null,
Media_Sector Varchar2(21) Not Null,
Email_Address Varchar2(26) Not Null,
Twitter_Username Varchar2(13) Not Null,
Annual_Earnings Decimal(9,2) Not Null,
Newspaper_Id Number(8) Not Null,
Constraint Journalist_Journalist_Id_Pk Primary Key(Journalist_Id),
Constraint Journalist_Gender_Ck Check(Gender In ('Male', 'Female'),
Constraint Journalist_Qualifications_Ck Check(Qualifications In ('BSC', 'B Comm', 'BA', 'B Eng')),
Constraint Journalist_Media_Sector_Ck Check(Media_Sector In ('Print Media', 'Internet Publications', 'Television', 'Radio', 'Podcast')),
Constraint Journalist_Email_Address_Uq Unique(Email_Address),
Constraint Journalist_Twitter_Username_Uq Unique(Twitter_Username),
Constraint Journalist_Newspaper_Id_Fk Foreign Key(Newspaper_Id) References Newspaper(Newspaper_Id));



Create Table Concert(
Concert_Id Number(3) Not Null,
Concert_Date Date Not Null,
Group_Name Varchar2(15) Not Null,
Category Varchar2(9) Not Null,
Start_Time Varchar2(5) Not Null,
Capacity Number(4) Not Null, 
Expected_Attendance Number(4) Not Null,
Actual_Attendance Number(4) Not Null,
Ticket_Price Number(4,2), 
Venue_Id Number(2),
Sponsor_Id Number(4),
Sponsorship_Amount Number(8,2),
Atmosphere Varchar2(6),
Constraint Concert_Concert_Id_Pk Primary Key(Concert_Id),
Constraint Concert_Category_Ck Check(Category In ('Pop', 'Rock', 'Classical')),
Constraint Concert_Venue_Id_Fk Foreign Key(Venue_Id) References Venue(Venue_Id),
Constraint Concert_Sponsor_Id_Fk Foreign Key(Sponsor_Id) References Sponsor(Sponsor_Id),
Constraint Concert_Atmosphere_Ck Check(Atmosphere In ('Poor', 'Good', 'Superb')));

Create Table Concert_Pass(
Concert_Id Number(3) Not Null,
Journalist_Id Number(9) Not Null,
Seat_Number Varchar2(3) Not Null,
Priviledges Varchar2(15) Not Null,
Constraint Concert_Pass_ConJourn_Id_Pk Primary Key(Concert_Id,Journalist_Id),
Constraint Concert_Pass_Seat_Number_Uq Unique(Seat_Number),
Constraint Concert_Journalist_Id_Fk Foreign Key(Journalist_Id) References Journalist(Journalist_Id));



/* Table: Venue */
/* Venue_Id,Name,Address,City,Country,Category,Type,Year_Built, Cost ,Capacity,Email,Web_Site */
Insert into Venue values(1,'Douglas Brakus','78 Kingsford Terrace','Kinnegad','Ireland','Outdoor','All Seater',1993,7337351.00,8000,'rslegg0@flavors.me','http://sogou.com/ipsum/praesent/blandit/lacinia/erat/vestibulum.aspx?');
Insert into Venue values(2,'Jerde, Rosenbaum and Moen','47 Spaight Road','Ashford','Ireland','Indoor','Terrace',1996,8555789.00,5000,'nohagirtie1@patch.com','http://samsung.com/elementum/nullam/varius/nulla/facilisi/cras.jpg?');
Insert into Venue values(3,'Reichert-Hayes','555 Holmberg Drive','Ballyjamesduff','Ireland','Indoor','Terrace',1999,4911065.00,6000,'bmacknight2@friendfeed.com','https://statcounter.com/amet/nulla/quisque.xml?');
Insert into Venue values(4,'Leffler, Schmeler and Parker','3676 Rockefeller Drive','Ardee','Ireland','Outdoor','Terrace',2013,950535.00,6000,'nworthy3@chronoengine.com','https://friendfeed.com/in.aspx?');
Insert into Venue values(5,'Ratke-Denesik','6 Porter Road','Clondalkin','Ireland','Outdoor','Covered',1990,4576545.00,6000,'sscholtz4@multiply.com','http://tripadvisor.com/vivamus/vestibulum/sagittis/sapien/cum/sociis.png?');
Insert into Venue values(6,'Runolfsdottir LLC','711 Pierstorff Avenue','Sallins','Ireland','Outdoor','Covered',1996,7392883.00,7000,'cthursfield5@youtu.be','https://ycombinator.com/metus.aspx?');
Insert into Venue values(7,'Rogahn, Lind and Jerde','319 New Castle Point','Gorey','Ireland','Outdoor','Terrace',1997,1857729.00,7500,'seste6@netlog.com','https://nyu.edu/urna.jsp?');
Insert into Venue values(8,'Flatley, Davis and Kertzmann','978 Grasskamp Point','Carrigtwohill','Ireland','Outdoor','Terrace',2003,4652687.00,8000,'kspaven7@geocities.com','https://prlog.org/morbi/sem/mauris/laoreet/ut/rhoncus.jpg?');
Insert into Venue values(9,'Satterfield-Grady','9 Banding Way','Granard','Ireland','Outdoor','Terrace',2002,5866156.00,5050,'wcroose8@wunderground.com','http://ask.com/et/ultrices/posuere/cubilia.html?');
Insert into Venue values(10,'Veum, Parisian and Kuvalis','5426 Vera Place','Tullyallen','Ireland','Outdoor','Covered',2009,8633599.00,5000,'amachoste9@earthlink.net','http://sphinn.com/pede/venenatis.aspx?'); 
Insert into Venue values(11,'Blick, Herman and Schumm','2 Hermina Plaza','Tullamore','Ireland','Indoor','Covered',1992,2339242.00,6500,'rmeralia@deliciousdays.com','https://ustream.tv/ante/vel/ipsum/praesent/blandit/lacinia.jsp?');
Insert into Venue values(12,'Ondricka LLC','95761 Hayes Plaza','Cluain Meala','Ireland','Indoor','All Seater',1984,3119459.00,7600,'rkratesb@pen.io','https://chron.com/consectetuer/adipiscing/elit/proin/interdum.js?');
Insert into Venue values(13,'Haley-Feeney','53 Oak Plaza','Laoghaire','Ireland','Indoor','All Seater',2006,9599903.00,8100,'rtattonc@addtoany.com','http://blogtalkradio.com/maecenas/pulvinar/lobortis/est/phasellus.jsp?');
Insert into Venue values(14,'Roob, Treutel and Smith','7167 Lakewood Lane','Macroom','Ireland','Indoor','All Seater',2012,3282001.00,6000,'bcayzerd@google.com','http://list-manage.com/vestibulum/ante/ipsum/primis/in/faucibus.xml?');
Insert into Venue values(15,'Koepp Inc','46861 Grover Place','Cloyne','Ireland','Outdoor','Terrace',2012,2740611.00,7000,'lbiskupeke@apple.com','https://answers.com/massa/quis/augue/luctus/tincidunt/nulla/mollis.jpg?');
Insert into Venue values(16,'Williamson and Sons','08610 Macpherson Place','Cork','Ireland','Indoor','Terrace',2002,5246363.00',8900,'tcattof@narod.ru,https://exblog.jp/in.jsp?');
Insert into Venue values(17,'Terry-Harris','569 Lawn Hill','Cluain Meala','Ireland','Outdoor','All Seater',2006,1983072.00,7700,'blinceyg@soup.io','http://shinystat.com/posuere.js?');
Insert into Venue values(18,'Parker-Boyer','1 Barby Way','Laoghaire','Ireland','Outdoor','Covered',1996,'8927549.00,9000,'cespinheirah@dagondesign.com','http://forbes.com/at/vulputate/vitae/nisl/aenean.png?');
Insert into Venue values(19,'Wilderman Group','89420 Mayer Hill','Piltown','Ireland','Outdoor','All Seater',1984,2330796.00,4500,'bshafieri@webeden.co.uk','http://csmonitor.com/ac/diam.json?');
Insert into Venue values(20,'Wehner-Wolf','9658 Browning Hill','Mullagh','Ireland','Indoor','Terrace',1992,8249974.00,7000,'bbecklesj@oakley.com','https://google.com.au/in/felis/donec/semper/sapien/a/libero.js?');

/*Table: Newspaper */
/* Newspaper_Id,Name,Address,Town,County,Year_Founded,Category,Email,Web_Site_Address, Annual_Turnover  */
 Insert into Newspaper  Values (46906910, ‘Holdlamis’, ‘Fairfield’, ‘Athlone’, ‘Cavan’,1972, ‘Broadsheet’, ‘bfowler0@dagondesign.com’, ‘https://furl.net/cras/pellentesque/volutpat/dui/maecenas.png’, 29793.59 )
Insert into Newspaper  Values (98082914, ‘Alpha’, ‘Sommers’, ‘Arvagh’, ‘Clare’,2009, ‘Tabloid’, ‘rtolomio1@cocolog-nifty.com’, ‘http://chronoengine.com/vestibulum/ante/ipsum/primis/in.json’,74,724.97  )
Insert into Newspaper  Values (62415463, ‘Span’, ‘Westport’, ‘Waterloo’, ‘Cavan’,2009, ‘Tabloid’,’grelfe2@hibu.com’, ‘http://whitehouse.gov/eleifend/luctus/ultricies.jpg’,46,138.59 )
Insert into Newspaper  Values (25285988, ‘Sub-Ex’, ‘Merchant’, ‘Ardue’, ‘Westmeath’,2008, ‘Tabloid;, ‘lskule3@woothemes.com’, ‘https://dagondesign.com/lectus/aliquam.js’, 84,265.89)
Insert into Newspaper  Values (44564546, ‘Konklux’, ‘Briar Crest’, ‘Waterloo’, ‘Cavan’,1996, ‘Broadsheet,ntrodler4@earthlink.net’, ‘http://scientificamerican.com/quis/turpis/sed.xml’,40,196.77 )


/*Table: Sponsor */
/* Sponsor_Id,Name,Address,Town,County,Tel_No,Web_Site,Business_Type,Sponsorship_Budget */
Insert Into Sponsor Values (4151, 'Carolee Ludwell', '5 Warner Parkway', 'Athlone’, ‘Clare',805603204, 'https://abc.net.au/luctus/nec/molestie/sed.aspx', 'Finance',62834);
Insert Into Sponsor Values (4941, 'Catherine Batstone', '8 Scoville Drive', 'Ardue', 'Westmeath',869186672, 'https://boston.com/justo/in/hac/habitasse.js', 'Media',85922);
Insert Into Sponsor Values (6184, 'Patton Palombi', '50 Gerald Way', 'Annagh', 'Westmeath',818654231, 'https://bizjournals.com/odio.html', 'Finance',20704);
Insert Into Sponsor Values (2067, 'Lorant Caso', '4768 Mayer Trail', 'Ardue', 'Westmeath',872941844, 'http://sourceforge.net/in/felis/eu/sapien/cursus/vestibul/proin.js', 'Manufacturing',24423);
Insert Into Sponsor Values (2214, 'Eleanore Bunkle', '192 Farmco Crossing', 'Abbey', 'Cavan',893867305, 'https://cpanel.net/sapien/ut/nunc/vestibulum/ante.html', 'Finance',17730);
Insert Into Sponsor Values (8420, 'Arabelle Jonas', '15 Oak Valley Road', 'Athlone', 'Clare',818289233, 'http://irs.gov/nam/dui.json', 'Media',95810);








/* Table: Journalist */
/* Journalist_Id,Forename,Surname,Address,Town,County,Gender,Date_Of_Birth,Qualifications,Media_Sector,Email_Address,Twitter_Username,  Annual_Earnings  ,Newspaper_Id */

Insert Into Journalist Values (691862500,'Almeda,Hawsby', '0 Spenser Trail', 'Waterloo', 'Carlow', 'Female', '12-Nov-1985', 'BSC', 'Television', 'ahawsby0@gnu.org', 'ahawsby0', 3866296.00, 98082914);
Insert Into Journalist Values (852895539, 'Maud', 'Moggie', '65 Moose Center', 'Annagh', 'Cavan', 'Female', '16-Sep-1978', 'B Eng', 'Podcast', 'mmoggie1@google.co.jp', 'mmoggie1', 8129006.00, 98082914);
Insert Into Journalist Values (292352602, 'Dulsea', 'Kneeshaw', '3 Longview Plaza', 'Annagh', 'Clare', 'Female', '18-Dec-1985', 'BA', 'Television', 'dkneeshaw2@trellian.com', 'dkneeshaw2', 3984386.00 ,46906910);
Insert Into Journalist Values (270447263, 'Rivkah', 'Berrey', '9 Porter Center', 'Abbey', 'Carlow', 'Female', '10-Nov-1975', 'BA', 'Podcast', 'rberrey3@1und1.de', 'rberrey3', 5416478.00, 98082914);
Insert Into Journalist Values (238872863, 'Wilburt', 'Varfolomeev', '8 Elka Court', 'Ardue', 'Clare', 'Male', '02-Mar-1980' ,'BA', 'Podcast', 'wvarfolomeev4@census.gov', 'wvarfolomeev4',4280258.00, 98082914);
Insert Into Journalist Values (509657010, 'Charita', 'Yarrall', '88861 Mesta Junction', 'Abbey', 'Clare', 'Female','06-Nov-1990', 'BA', 'Internet Publications', 'cyarrall5@goo.gl', 'cyarrall5', 3938256.00, 62415463);
Insert Into Journalist Values (957111491, 'Cullin', 'Lawerence', '32726 Reindahl Trail', 'Ardue', 'Clare', 'Male', '22-Feb-1978', 'BA', 'Podcast', 'clawerence6@ehow.com', 'clawerence6',7530658.00, 46906910);
Insert Into Journalist Values (826296466, 'Tori', 'Swyer-Sexey', '339 Village Center', 'Abbey', 'Cavan', 'Female', '22-Jun-1985', 'B Eng', 'Print Media', 'tswyersexey7@woothemes.com', 'tswyersexey7', 8033013.00, 98082914);
Insert Into Journalist Values (638412146, 'Francyne', 'Glasscoo', '7 Waubesa Parkway', 'Abbey', 'Cork County', 'Female', '04-Oct-1988', 'B Comm', 'Radio', 'fglasscoo8@unesco.org', 'fglasscoo8', 928926.00, 46906910);
Insert Into Journalist Values (225303004, 'Rusty', 'Bilney', '96 Forest Junction', 'Abbey', 'Clare', 'Male', '25-May-1977', 'B Comm', 'Print Media', 'rbilney9@tinyurl.com', 'rbilney9',6731047.00, 98082914);
Insert Into Journalist Values (736615345, 'Maurine', 'Paty', '50568 Roxbury Way', 'Ardue', 'Cavan', 'Female', '19-Dec-1988', 'BSC', 'Internet Publications', 'mpatya@com.com', 'mpatya',7113523.00, 25285988);
Insert Into Journalist Values (483356405, 'Sim', 'Burchell', '4 Boyd Point', 'Ardue', 'Clare', 'Male', '13-Mar-1976','BSC', 'Podcast', 'sburchellb@pinterest.com', 'sburchellb' ,6334460.00, 25285988);
Insert Into Journalist Values (361944481, 'Josy', 'Splaven', '62256 Schlimgen Circle', 'Annagh', 'Carlow', 'Female' ,'19-Jun-1977', 'BSC', 'Television', 'jsplavenc@dropbox.com', 'jsplavenc', 4977470.00, 25285988);
Insert Into Journalist Values (873437823, 'Abdul', 'Robertshaw', '30 Sundown Circle', 'Waterloo', 'Clare', 'Male', '14-Jul-1984', 'BA', 'Television', 'arobertshawd@blogs.com', 'arobertshawd', 439629.00, 25285988);
Insert Into Journalist Values (919661524, 'Bartholomeus', 'Culleford', '36 Doe Crossing Lane', 'Annagh', 'Clare', 'Male' , '12-Oct-1986', 'B Comm' ,'Television', 'bculleforde@parallels.com','bculleforde', 1566047.00 , 62415463);
Insert Into Journalist Values (417808835, 'Vivi', 'Camel', '3 American Road', 'Waterloo', 'Cork County', 'Female', '30-Sep-1977', 'BA', 'Radio', 'vcamelf@eepurl.com', 'vcamelf', 8279761.00, 25285988);
Insert Into Journalist Values (292680833, 'Cly', 'Iliffe', '196 Hermina Way', 'Abbey', 'Clare', 'Male', '06-May-1983', 'BSC', 'Television', 'ciliffeg@bbc.co.uk', 'ciliffeg', 1968381.00, 25285988);
Insert Into Journalist Values (987045518, 'Ginnifer', 'Poel', '3 Morningstar Center', 'Annagh', 'Cork County', 'Female', '06-Mar-1984', 'BSC', 'Print Media', 'gpoelh@ow.ly', 'gpoelh', 8790224.00, 62415463);
Insert Into Journalist Values (698559806, 'Spike', 'Thursby', '98 Center Crossing', 'Waterloo', 'Clare ', 'Male', '01-Jan-1979', 'BSC', 'Podcast', 'sthursbyi@businessinsider.com', 'sthursbyi', 6117027.00, 62415463);
Insert Into Journalist Values (995335072, 'Bink', 'Joseff', '286 Reindahl Park', 'Abbey', 'Clare', 'Male', '05-Apr-1983', 'BA', 'Television', 'bjoseffj@opera.com', 'bjoseffj', 8005064.00, 62415463);




/* Table: Concert */
/*Consert_Id,Concert_Date,Group,Category,Start_Time,Capacity,Expected_Attendance,Actual_Attendance,Ticket_Price,Venue_Id,Sponsor_Id, Sponsorship_Amount ,Atmosphere*/
Insert Into Concert Values(423, '27-Oct-2018', 'Superfate', 'Rock', '10:44',7096,4360,891,59.5,1,4941, 585634.95, 'Poor');
Insert Into Concert Values(384, '01-Aug-2018', 'Roseum', 'Rock', '05:41',6860,3376,917,53.85,1,4941, 467032.55, 'Poor');
Insert Into Concert Values(35, '01-May-2018', 'Orphenadrine', 'Rock', '00:37', 7444,3695,3631,51.31,4,8420, 877377.21, 'Good');
Insert Into Concert Values(171, '19-Nov-2019', 'Dipropion Hydro', 'Classical', '20:59', 6848,1108,3432,48.17,5,4151, 169675.18 , 'Superb');
Insert Into Concert Values(773, '27-Nov-2018', 'ConZip', 'Rock', '14:27',6382,2622,2789,47.97,1,2067, 94425.75 , 'Good');
Insert Into Concert Values(644, '14-Jan-2019', 'Caldecort','Rock','05:28',7774,674,67,49.47,2,2067, 152523.83 , 'Poor');
Insert Into Concert Values(544,'29-Jan-2019', 'Lamotrigine', 'Rock', '04:34', 7914,859,3844,53.51,16,6184, 122332.18 ,'Superb');
Insert Into Concert Values(444,'30-Mar-2019', 'sunmark', 'Classical', '13:41',6032,2781,3443,43.6,19,4941, 26893.61 ,'Poor');


/* Table: Concert_Pass */
/* Concert_Id,Journalist_Id,Seat_Number,Priviledges */
Insert Into Concert_Pass Values (423,691862500, 'Z21', 'Hot Food');
Insert Into Concert_Pass Values (384,691862500, 'W68', 'Drinks');
Insert Into Concert_Pass Values (384,225303004, 'Q04', 'Drinks');
Insert Into Concert_Pass Values (423,957111491, 'U32', 'Access All Area');
Insert Into Concert_Pass Values (384,957111491, 'T93', 'Coffee and Tea');
Insert Into Concert_Pass Values (544,919661524, 'N85', 'Access All Area');
Insert Into Concert_Pass Values (544,691862500, 'V04', 'Hot Food');
Insert Into Concert_Pass Values (423,995335072, 'X32' , 'Hot Food');
Insert Into Concert_Pass Values (423,225303004, 'I45', 'Drinks');
Insert Into Concert_Pass Values (423,987045518, 'P88', 'Access All Area');
Insert Into Concert_Pass Values (171,691862500, 'E75' , 'Coffee and Tea');
Insert Into Concert_Pass Values (384,270447263, 'U13', 'Access All Area');
Insert Into Concert_Pass Values (444,987045518, 'Y28', 'Drinks');
Insert Into Concert_Pass Values (171,270447263, 'J57', 'Hot Food');
Insert Into Concert_Pass Values (171,225303004, 'W93' , 'Access All Area');
Insert Into Concert_Pass Values (171,417808835, 'H43', 'Drinks');
Insert Into Concert_Pass Values (644,225303004, 'W92', 'Hot Food');
Insert Into Concert_Pass Values (444,270447263, 'G78', 'Access All Area');
Insert Into Concert_Pass Values (444,225303004, 'J97', 'Access All Area');
Insert Into Concert_Pass Values (644,957111491, 'P60', 'Hot Food');
Insert Into Concert_Pass Values (171,361944481, 'G88', 'Drinks');
Insert Into Concert_Pass Values (444,361944481, 'Q36' , 'Coffee and Tea');
Insert Into Concert_Pass Values (644,987045518, 'W22', 'Access All Area');
Insert Into Concert_Pass Values (644,698559806, 'N56', 'Access All Area');
Insert Into Concert_Pass Values (171,957111491, 'C36','Hot Food');
