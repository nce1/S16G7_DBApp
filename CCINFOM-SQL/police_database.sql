-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
-- 
-- Host: localhost    Database: police_database
-- ------------------------------------------------------
-- Server version	8.0.17
CREATE DATABASE  IF NOT EXISTS `police_database`; 
/*DEFAULT CHARACTER SET utf8*/
USE `police_database`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `background`
--
DROP TABLE IF EXISTS background;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE background(backgroundId INT NOT NULL,
						lastName VARCHAR(50) NOT NULL,
                        firstName VARCHAR(50) NOT NULL,
					    birthdate DATE NOT NULL,
                        sex ENUM('M', 'F'),
                        profession VARCHAR(20) NOT NULL,
                        addressId INT NOT NULL,
                        status ENUM('Alive', 'Deceased') NOT NULL DEFAULT 'Alive', 
                        yearOfDeath DATE DEFAULT NULL,
                        PRIMARY KEY(backgroundId),
                        FOREIGN KEY(addressId) REFERENCES address(addressId)) DEFAULT CHARSET=latin1;
                        /*!40101 SET character_set_client = @saved_cs_client */;

--
-- Inputting data for table `background`
--
LOCK TABLES `background` WRITE;
/*!40000 ALTER TABLE `background` DISABLE KEYS */;
INSERT INTO background VALUES('12340001', 'Bill', 'Anne', '2000-10-10', 'F', 'Unemployed', '40001', 'Alive', NULL),
							 ('12340002', 'Doug', 'Cillian', '1990-09-09', 'M', 'Researcher', '40002', 'Deceased', '2010-02-03'),
                             ('12340003', 'Flynn', 'Eddie','1999-06-06', 'M', 'Police Officer', '40003', 'Alive', NULL), 
                             ('12340004', 'Doe', 'John', '1980-07-12','M', 'Salesperson', '40004', 'Alive', NULL),
                             ('12340005', 'Smith', 'Dave', '2001-01-9', 'M', 'Doctor', '40005', 'Alive', NULL),
                             ('12340006', 'Marasigan', 'Kate', '1996-04-25', 'F', 'Artist', '40006', 'Alive', NULL),
                             ('12340007', 'Madrigal', 'Jose', '1979-11-09', 'M', 'Police Officer', '40007', 'Alive', NULL),
                             ('12340008', 'Harvy', 'James', '1987-09-10', 'M', 'Police Officer', '40008', 'Alive', NULL),
                             ('12340009', 'Solomon', 'Denise', '2000-12-20', 'F', 'Police Officer', '40009', 'Alive', NULL),
                             ('12340010', 'Barbaro', 'Monica', '1994-06-29', 'F', 'Police Officer', '40010', 'Alive', NULL),
                             ('12340011', 'Peralta', 'Jake', '1989-07-14', 'M', 'Police Officer', '40011', 'Alive', NULL),
                             ('12340012', 'Stone', 'Lily', '1982-11-05', 'F', 'Musician', '40012', 'Alive', NULL),
							 ('12340013', 'Gray', 'Victor', '1992-03-22', 'M', 'Engineer', '40013', 'Alive', NULL),
							 ('12340014', 'King', 'Emily', '1988-05-17', 'F', 'Teacher', '40014', 'Alive', NULL),
                             ('12340015', 'Jeffords', 'Terry', '1971-06-12', 'M', 'Police Officer', '40015', 'Alive', NULL),
                             ('12340016', 'Lee', 'Andrew', '1994-09-30', 'M', 'Plumber', '40016', 'Alive', NULL),
							 ('12340017', 'Davis', 'Sarah', '1981-12-04', 'F', 'Nurse', '40017', 'Alive', NULL),
							 ('12340018', 'Clark', 'Michael', '1978-08-25', 'M', 'Firefighter', '40018', 'Alive', NULL),
							 ('12340019', 'Martinez', 'Carlos', '1996-01-02', 'M', 'Chef', '40019', 'Alive', NULL),
							 ('12340020', 'Santiago', 'Amy', '1995-03-10', 'F', 'Police Officer', '40020', 'Alive', NULL),
							 ('12340021', 'Boyle', 'Charles', '1990-11-02', 'M', 'Police Officer', '40021', 'Alive', NULL),
							 ('12340022', 'Diaz', 'Rosa', '1993-06-18', 'F', 'Police Officer', '40022', 'Alive', NULL),
							 ('12340023', 'Foster', 'James', '1985-07-11', 'M', 'Accountant', '40023', 'Alive', NULL),
							 ('12340024', 'Parker', 'Mia', '1992-12-28', 'F', 'Manager', '40024', 'Alive', NULL),
							 ('12340025', 'Young', 'John', '1989-11-03', 'M', 'Engineer', '40025', 'Alive', NULL),
							 ('12340026', 'Baker', 'Olivia', '1997-01-18', 'F', 'Designer', '40026', 'Alive', NULL),
							 ('12340027', 'Scott', 'Liam', '1984-04-12', 'M', 'Pilot', '40027', 'Alive', NULL),
                             ('12340028', 'Linetti', 'Gina', '1989-04-12', 'F', 'Police Officer', '40028', 'Alive', NULL),
							 ('12340029', 'Carter', 'Megan', '1991-06-20', 'F', 'Journalist', '40029', 'Alive', NULL),
                             ('12340030', 'Holt', 'Raymond', '1972-08-16', 'M', 'Police Officer', '40030', 'Alive', NULL),
							 ('12340031', 'Lowrey', 'Mike', '1992-07-25', 'M', 'Police Officer', '40031', 'Alive', NULL),
							 ('12340032', 'Lawrence', 'Martin', '1984-05-14', 'M', 'Police Officer', '40032', 'Alive', NULL),
							 ('12340033', 'Stabler', 'Elliot', '1981-02-06', 'M', 'Police Officer', '40033', 'Alive', NULL),
							 ('12340034', 'Morgan', 'Paula', '1979-10-19', 'F', 'Manager', '40034', 'Alive', NULL),
							 ('12340035', 'Nelson', 'Gregory', '1985-09-11', 'M', 'Architect', '40035', 'Alive', NULL),
							 ('12340036', 'Harris', 'Katherine', '1983-01-25', 'F', 'Artist', '40036', 'Alive', NULL),
                             ('12340037', 'Munch', 'John', '1980-10-10', 'M', 'Police Officer', '40037', 'Alive', NULL),
							 ('12340038', 'Grant', 'Jack', '1993-08-14', 'M', 'Writer', '40038', 'Alive', NULL),
                             ('12340039', 'Benson', 'Olivia', '1982-03-18', 'F', 'Police Officer', '40039', 'Alive', NULL),
							 ('12340040', 'Rollins', 'Amanda', '1994-09-22', 'F', 'Police Officer', '40040', 'Alive', NULL),
							 ('12340041', 'Cragen', 'Donald', '1975-01-05', 'M', 'Police Officer', '40041', 'Alive', NULL),
						  	 ('12340042', 'Tutuola', 'Odafin', '1983-11-01', 'M', 'Police Officer', '40042', 'Alive', NULL);
/*!40000 ALTER TABLE `background` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--
DROP TABLE IF EXISTS address;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE address(addressId INT NOT NULL,
					 houseNo VARCHAR(10) NOT NULL,
                     street VARCHAR(15) NOT NULL,
                     baranggay VARCHAR(15) NOT NULL,
                     city VARCHAR(15) NOT NULL,
                     province VARCHAR(15) NOT NULL,
                     region VARCHAR(15) NOT NULL,
                     zipCode VARCHAR(5) NOT NULL,
                     PRIMARY KEY(addressId)) DEFAULT CHARSET=latin1;
                     /*!40101 SET character_set_client = @saved_cs_client */;

--
-- Inputting data for table `address`
--                                        
LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO address VALUES('40001', '123', 'Rizal', 'Bagong Silang', 'Caloocan', 'Metro Manila', 'NCR', '1428'),
						  ('40002', '303', 'Salinas', 'Lahug', 'Cebu City', 'Cebu', 'Region VII', '6000'),
                          ('40003', '456', 'Taft Avenue', 'Barangay 76', 'Pasay', 'Metro Manila', 'NCR', '1300'), 
                          ('40004', '321', 'Alabang', 'Cupang', 'Muntinlupa', 'Metro Manila', 'NCR', '1771'),
                          ('40005', '765', 'Malinis', 'Malanday', 'Valenzuela', 'Metro Manila', 'NCR', '1441'),
                          ('40006', '456', 'Bonifacio', 'San Roque', 'Quezon City', 'Metro Manila', 'NCR', '1109'),
                          ('40007', '987', 'Rizal Drive', 'Fort Bonifacio', 'Taguig', 'Metro Manila', 'NCR', '1630'),
                          ('40008', '543', 'Chino Roces', 'San Lorenzo', 'Makati', 'Metro Manila', 'NCR', '1223'),
                          ('40009', '567', 'Roxas Blvd', 'Barangay 15', 'Pasay', 'Metro Manila', 'NCR', '1302'),
                          ('40010', '432', 'Gil Puyat', 'Pio del Pilar', 'Makati', 'Metro Manila', 'NCR', '1230'),
                          ('40011', '876', 'Tagaytay', 'San Agustin', 'Trece Martires', 'Cavite', 'Region IV-A', '4109'),
                          ('40012', '112', 'Mabini', 'San Isidro', 'Parañaque', 'Metro Manila', 'NCR', '1700'),
                          ('40013', '213', 'Katipunan', 'Holy Spirit', 'Quezon City', 'Metro Manila', 'NCR', '1123'),
                          ('40014', '314', 'Quezon Ave', 'Philam', 'Quezon City', 'Metro Manila', 'NCR', '1101'),
                          ('40015', '415', 'Sampaloc', 'San Miguel', 'Manila', 'Metro Manila', 'NCR', '1008'),
                          ('40016', '516', 'Tandang Sora', 'Bayanihan', 'Quezon City', 'Metro Manila', 'NCR', '1114'),
                          ('40017', '617', 'E. Rodriguez', 'Marikina Heights', 'Marikina', 'Metro Manila', 'NCR', '1800'),
                          ('40018', '718', 'Magsaysay', 'Dona Imelda', 'Quezon City', 'Metro Manila', 'NCR', '1125'),
                          ('40019', '819', 'Dumaguete', 'Mabuhay', 'Taguig', 'Metro Manila', 'NCR', '1635'),
                          ('40020', '920', 'Antonio', 'Bacood', 'Manila', 'Metro Manila', 'NCR', '1025'),
                          ('40021', '321', 'Sto. Niño', 'Pasong Tamo', 'Makati', 'Metro Manila', 'NCR', '1212'),
                          ('40022', '122', 'Avenida', 'San Andres', 'Manila', 'Metro Manila', 'NCR', '1002'),
                          ('40023', '223', 'Davao', 'San Rafael', 'Quezon City', 'Metro Manila', 'NCR', '1122'),
                          ('40024', '324', 'P. Guevarra', 'Paligsahan', 'Quezon City', 'Metro Manila', 'NCR', '1103'),
                          ('40025', '425', 'Cagayan', 'Barangay San Antonio', 'Makati', 'Metro Manila', 'NCR', '1210'),
                          ('40026', '526', 'Sorsogon', 'Dona Petrona', 'Quezon City', 'Metro Manila', 'NCR', '1117'),
                          ('40027', '627', 'Legarda', 'San Jose', 'Manila', 'Metro Manila', 'NCR', '1014'),
                          ('40028', '728', 'Rizal', 'Culiat', 'Quezon City', 'Metro Manila', 'NCR', '1120'),
                          ('40029', '829', 'Montalban', 'San Juan', 'San Juan', 'Metro Manila', 'NCR', '1500'),
                          ('40030', '930', 'Kalayaan', 'Kapasigan', 'Pasig', 'Metro Manila', 'NCR', '1600'),
                          ('40031', '1031', 'Commonwealth', 'Baño', 'Quezon City', 'Metro Manila', 'NCR', '1106'),
                          ('40032', '1132', 'Asuncion', 'Sampaloc', 'Manila', 'Metro Manila', 'NCR', '1001'),
                          ('40033', '1233', 'Bonifacio', 'Bayabas', 'Muntinlupa', 'Metro Manila', 'NCR', '1770'),
                          ('40034', '1344', 'Del Monte', 'San Francisco', 'Quezon City', 'Metro Manila', 'NCR', '1111'),
                          ('40035', '1455', 'Malabon', 'Kapunongan', 'Malabon', 'Metro Manila', 'NCR', '1470'),
                          ('40036', '1566', 'Las Pinas', 'Almanza', 'Las Piñas', 'Metro Manila', 'NCR', '1740'),
                          ('40037', '1677', 'Sta. Mesa', 'Dimasalang', 'Manila', 'Metro Manila', 'NCR', '1003'),
                          ('40038', '1788', 'Taguig', 'North Signal', 'Taguig', 'Metro Manila', 'NCR', '1634'),
                          ('40039', '1899', 'Caloocan', 'Bagumbayan', 'Caloocan', 'Metro Manila', 'NCR', '1400'),
                          ('40040', '2000', 'Camarillo', 'East Rembo', 'Makati', 'Metro Manila', 'NCR', '1235'),
                          ('40041', '2111', 'Iloilo', 'Duhat', 'Valenzuela', 'Metro Manila', 'NCR', '1443'),
                          ('40042', '2222', 'Quezon City', 'Santo Niño', 'Quezon City', 'Metro Manila', 'NCR', '1108');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `precincts`
--
DROP TABLE IF EXISTS precincts;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE precincts(precinctID INT NOT NULL,
					   cityJurisdiction VARCHAR(20) NOT NULL UNIQUE, -- zip code (prevent confusion)
                       PRIMARY KEY(precinctID)) DEFAULT CHARSET=latin1;
                       /*!40101 SET character_set_client = @saved_cs_client */;

--
-- Inputting data for table `precincts`
--                                        
LOCK TABLES `precincts` WRITE;
/*!40000 ALTER TABLE `precincts` DISABLE KEYS */;
INSERT INTO precincts VALUES ('1000', 'Manila'),
                             ('1001', 'Quezon City'),
                             ('1002', 'Cebu City'),
                             ('1003', 'Davao City'),
                             ('1004', 'Baguio City'),
                             ('1005', 'Iloilo City'),
                             ('1006', 'Cagayan de Oro'),
                             ('1007', 'Zamboanga City'),
                             ('1008', 'Bacolod City'),
                             ('1009', 'General Santos'),
                             ('1010', 'Taguig'),
                             ('1011', 'Makati'),
                             ('1012', 'Pasig'),
                             ('1013', 'Las Piñas'),
                             ('1014', 'Tagaytay'),
                             ('1015', 'Marikina'),
                             ('1016', 'Parañaque'),
                             ('1017', 'Malabon'),
                             ('1018', 'Navotas'),
                             ('1019', 'Mandaluyong');
/*!40000 ALTER TABLE `precincts` ENABLE KEYS */;
UNLOCK TABLES;
                       
--
-- Table structure for table `officers`
--
DROP TABLE IF EXISTS officers;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE officers(policeID INT NOT NULL,
					  backgroundId INT NOT NULL UNIQUE,
                      position ENUM('Rookie Officer', 'Experienced Officer', 'Corporal', 'Sergeant', 'Lieutenant',
									'Captain', 'Major', 'Deputy Chief', 'Chief of Police', 'Commissioner') NOT NULL,
                      precinctID INT NOT NULL,
                      startDate DATE NOT NULL,
                      PRIMARY KEY(policeID),
                      FOREIGN KEY(precinctID) REFERENCES precincts(precinctID),
                      FOREIGN KEY(backgroundId) REFERENCES background(backgroundId)) DEFAULT CHARSET=latin1;
                       /*!40101 SET character_set_client = @saved_cs_client */;

--
-- Inputting data for table `officers`
--                                        
LOCK TABLES `officers` WRITE;
/*!40000 ALTER TABLE `officers` DISABLE KEYS */;
INSERT INTO officers VALUES ('10101', '12340003', 'Rookie Officer', '1006', '2020-02-06'),
							('10102', '12340007', 'Commissioner', '1000', '2020-07-08'),
							('10103', '12340008', 'Corporal', '1002', '2020-12-20'),
							('10104', '12340009', 'Experienced Officer', '1003', '2021-04-14'),
							('10105', '12340010', 'Corporal', '1004', '2021-09-09'),
							('10106', '12340011', 'Corporal', '1005', '2021-12-13'),
							('10107', '12340015', 'Sergeant', '1007', '2022-01-25'),
							('10108', '12340020', 'Sergeant', '1008', '2022-05-21'),
							('10109', '12340021', 'Lieutenant', '1009', '2022-07-17'),
							('10110', '12340022', 'Corporal', '1010', '2022-09-30'),
							('10111', '12340028', 'Experienced Officer', '1011', '2023-02-06'),
							('10112', '12340030', 'Chief of Police', '1006', '2023-04-15'),
							('10113', '12340031', 'Sergeant', '1008', '2023-06-21'),
							('10114', '12340032', 'Lieutenant', '1004', '2023-08-14'),
							('10115', '12340033', 'Captain', '1002', '2023-11-01'),
							('10116', '12340037', 'Lieutenant', '1003', '2024-01-10'),
							('10117', '12340039', 'Sergeant', '1011', '2024-03-18'),
							('10118', '12340040', 'Sergeant', '1009', '2024-05-01'),
							('10119', '12340041', 'Major', '1007', '2024-08-01'),
							('10120', '12340042', 'Sergeant', '1010', '2024-10-12');
/*!40000 ALTER TABLE `officers` ENABLE KEYS */;
UNLOCK TABLES;
                       
--
-- Table structure for table `incidents`
--
DROP TABLE IF EXISTS incidents;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE incidents(caseID INT NOT NULL,
                       description TEXT NOT NULL,
                       type ENUM('Violent', 'Property', 'White-Collar', 'Organized', 'Cybercrime'),
					   status ENUM('Under Investigation', 'Forwarded to Prosecution', 'Charges Filed', 'Awaiting Trial', 'Convicted', 'Acquitted', 'Dismissed') DEFAULT "Under Investigation",
					   dateReported DATE NOT NULL,
                       dateOfOccurrence DATE NOT NULL,
                       dateResolved DATE DEFAULT NULL,
                       precinctID INT NOT NULL,
                       PRIMARY KEY(caseID),
                       FOREIGN KEY(precinctID) REFERENCES precincts(precinctID)) DEFAULT CHARSET=latin1;
                       /*!40101 SET character_set_client = @saved_cs_client */;

--
-- Inputting data for table `incidents`
--   
LOCK TABLES `incidents` WRITE;
/*!40000 ALTER TABLE `incidents` DISABLE KEYS */;
INSERT INTO incidents VALUE (20000, 'A robbery occurred at a jewelry store in the city center.', 'Violent', 'Under Investigation', '2024-11-01', '2024-11-01', NULL, 1000);
INSERT INTO incidents VALUE (20001, 'Multiple cars were stolen from a parking garage in a residential area.', 'Property', 'Under Investigation', '2024-11-05', '2024-11-05', NULL, 1001);
INSERT INTO incidents VALUE (20002, 'An insider trading scheme involving a large financial firm was reported.', 'White-Collar', 'Acquitted', '2024-10-20', '2024-09-20', '2024-11-10', 1002);
INSERT INTO incidents VALUE (20003, 'A violent gang fight resulted in multiple injuries and property damage.', 'Violent', 'Charges Filed', '2024-11-02', '2024-10-31',NULL, 1000);
INSERT INTO incidents VALUE (20004, 'A network of cybercriminals accessed personal data from several banks.', 'Cybercrime', 'Under Investigation', '2024-11-03', '2024-11-03', NULL, 1003),
(20005, 'A business embezzlement case involving a corporate executive.', 'White-Collar', 'Awaiting Trial', '2024-09-15', '2024-09-10', NULL, 1001),
(20006, 'An organized crime ring was busted in a series of drug trafficking incidents.', 'Organized', 'Convicted', '2024-07-10', '2024-07-01','2024-10-15', 1004),
(20007, 'A protest turned violent and resulted in property damage and injuries.', 'Violent', 'Under Investigation', '2024-08-05', '2024-08-05', NULL, 1005),
(20008, 'A large-scale cyber attack targeted government websites and infrastructure.', 'Cybercrime', 'Dismissed', '2020-07-20', '2020-07-20','2024-10-05', 1003),
(20009, 'A multi-location theft ring that involved several stores in the city.', 'Property', 'Under Investigation', '2022-11-10', '2022-11-09',NULL, 1002),
(20010, 'A money laundering scheme within a high-profile financial institution.', 'White-Collar', 'Forwarded to Prosecution', '2024-08-18','2024-08-17', '2024-09-30', 1004),
(20011, 'A car bombing linked to organized criminal syndicates.', 'Organized', 'Under Investigation', '2024-11-12','2024-11-12', NULL, 1006),
(20012, 'Theft of sensitive data from multiple healthcare providers.', 'Cybercrime', 'Under Investigation', '2023-10-01', '2023-10-01', NULL, 1007),
(20013, 'A fight between rival gangs at a nightclub in downtown.', 'Violent', 'Charges Filed', '2024-09-20', '2024-09-20', NULL, 1000),
(20014, 'Embezzlement of company funds through fraudulent accounting.', 'White-Collar', 'Dismissed', '2024-07-15', '2024-07-15', '2024-08-10', 1005),
(20015, 'A fraud case involving fake investment schemes targeting retirees.', 'White-Collar', 'Under Investigation', '2024-10-05','2024-10-05', NULL, 1002),
(20016, 'A series of online extortion attempts targeting businesses.', 'Cybercrime', 'Under Investigation', '2020-11-15', '2020-11-14', NULL, 1003),
(20017, 'A raid on an illegal gambling den run by organized criminals.', 'Organized', 'Convicted', '2021-06-25', '2021-06-23','2024-09-10', 1006),
(20018, 'Arson cases linked to insurance fraud schemes in residential areas.', 'Property', 'Acquitted', '2024-08-30',  '2024-08-30', '2024-10-05', 1001),
(20019, 'A high-speed chase resulting in injuries and property damage in a car theft case.', 'Violent', 'Forwarded to Prosecution', '2024-10-15',  '2024-10-15', '2024-11-05', 1000); 
/*!40000 ALTER TABLE `incidents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offenders`
--
DROP TABLE IF EXISTS offenders;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE offenders(caseID INT NOT NULL,
					   backgroundId INT NOT NULL,
                       offense VARCHAR(50) NOT NULL,
                       status ENUM('Under Investigation', 'Arrested', 'Awaiting Trial', 'In Prison', 'On Parole', 'On Probation', 'Released', 'Fugitive', 'Dismissed') DEFAULT 'Under Investigation',
                       PRIMARY KEY(caseID, backgroundId),
                       FOREIGN KEY(backgroundId) REFERENCES background(backgroundId),
                       FOREIGN KEY(caseID) REFERENCES incidents(caseID)) DEFAULT CHARSET=latin1;
                       /*!40101 SET character_set_client = @saved_cs_client */;
                       
--
-- Inputting data for table `offenders`
--                                        
LOCK TABLES `offenders` WRITE;
/*!40000 ALTER TABLE `offenders` DISABLE KEYS */;
INSERT INTO offenders VALUES ('20000', '12340004', 'Theft', 'Under Investigation'),
							 ('20000', '12340005', 'Assault', 'Arrested'),
							 ('20001', '12340043', 'Burglary', 'Awaiting Trial'),
							 ('20002', '12340044', 'Robbery', 'In Prison'),
							 ('20003', '12340045', 'Fraud', 'On Parole'),
							 ('20004', '12340046', 'Murder', 'On Probation'),
							 ('20005', '12340047', 'Arson', 'Released'),
 							 ('20006', '12340048', 'Vandalism', 'Fugitive'),
 							 ('20007', '12340049', 'Drug Possession', 'Dismissed'),
 							 ('20008', '12340050', 'Bribery', 'Under Investigation'),
							 ('20009', '12340051', 'Extortion', 'Arrested'),
							 ('20010', '12340052', 'Kidnapping', 'Awaiting Trial'),
							 ('20011', '12340053', 'Sexual Assault', 'In Prison'),
 							 ('20012', '12340054', 'Rape', 'On Parole'),
 							 ('20013', '12340055', 'Battery', 'On Probation'),
							 ('20014', '12340056', 'Stalking', 'Released'),
							 ('20015', '12340057', 'Identity Theft', 'Fugitive'),
 							 ('20016', '12340058', 'Harassment', 'Dismissed'),
							 ('20017', '12340059', 'Attempted Murder', 'Under Investigation'),
							 ('20018', '12340060', 'Smuggling', 'Arrested'),
							 ('20019', '12340061', 'Illegal Gambling', 'Awaiting Trial');
 /*!40000 ALTER TABLE `offenders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participants`
--
DROP TABLE IF EXISTS participants;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE participants(caseID INT NOT NULL,
						  backgroundId INT NOT NULL,
                          testimony TEXT NOT NULL,
                          involvement ENUM('Witness', 'Victim'),
                          PRIMARY KEY(caseID, backgroundId),
                          FOREIGN KEY(backgroundId) REFERENCES background(backgroundId),
						  FOREIGN KEY(caseID) REFERENCES incidents(caseID)) DEFAULT CHARSET=latin1;
                       /*!40101 SET character_set_client = @saved_cs_client */;

--
-- Inputting data for table `participants`
--                                        
LOCK TABLES `participants` WRITE;
/*!40000 ALTER TABLE `participants` DISABLE KEYS */;
INSERT INTO participants VALUES ('20000', '12340001', 'Saw a suspicious person near the scene.', 'Victim'),
								('20000', '12340002', 'Heard shouting before the incident.', 'Witness'),
								('20001', '12340004', 'Provided information about the suspect.', 'Victim'),
								('20002', '12340005', 'Observed a vehicle speeding away.', 'Witness'),
								('20003', '12340012', 'Recognized the suspect from a prior case.', 'Victim'),
								('20004', '12340013', 'Helped identify key evidence.', 'Witness'),
								('20005', '12340014', 'Described unusual activity in the neighborhood.', 'Victim'),
								('20006', '12340016', 'Gave details about the time of the event.', 'Witness'),
								('20007', '12340017', 'Identified the victim at the scene.', 'Victim'),
								('20008', '12340018', 'Shared security footage for investigation.', 'Witness'),
								('20009', '12340019', 'Explained the sequence of events.', 'Victim'),
								('20010', '12340023', 'Saw the suspect fleeing on foot.', 'Witness'),
								('20011', '12340024', 'Provided critical testimony in court.', 'Victim'),
								('20012', '12340025', 'Witnessed an argument before the incident.', 'Witness'),
								('20013', '12340026', 'Noticed suspicious behavior days prior.', 'Victim'),
								('20014', '12340027', 'Testified about the suspect’s whereabouts.', 'Witness'),
								('20015', '12340029', 'Recounted details of the crime scene.', 'Victim'),
								('20016', '12340034', 'Helped locate additional witnesses.', 'Witness'),
								('20017', '12340035', 'Spotted the suspect entering a nearby building.', 'Victim'),
								('20018', '12340036', 'Shared evidence related to the case.', 'Witness'),
								('20019', '12340038', 'Gave a statement about suspicious activity.', 'Victim');
/*!40000 ALTER TABLE `participants` ENABLE KEYS */;
UNLOCK TABLES;
                       
--
-- Table structure for table `officerCases`
--
DROP TABLE IF EXISTS officerCases;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE officerCases(caseID INT NOT NULL,
						  policeID INT NOT NULL,
                          PRIMARY KEY(caseId, policeID),
                          FOREIGN KEY(caseID) REFERENCES incidents(caseID),
                          FOREIGN KEY(policeID) REFERENCES officers(policeID)) DEFAULT CHARSET=latin1;
                       /*!40101 SET character_set_client = @saved_cs_client */;

--
-- Inputting data for table `officerCases`
--                                        
LOCK TABLES `officerCases` WRITE;
/*!40000 ALTER TABLE `officerCases` DISABLE KEYS */;
INSERT INTO officerCases VALUES
(20000, 10101),
(20001, 10102), 
(20002, 10103), 
(20003, 10104), 
(20004, 10105),
(20005, 10106), 
(20006, 10107),
(20007, 10108), 
(20008, 10109), 
(20009, 10110), 
(20010, 10111), 
(20011, 10112), 
(20012, 10113), 
(20013, 10114), 
(20014, 10115), 
(20015, 10116), 
(20016, 10117), 
(20017, 10118), 
(20018, 10119), 
(20019, 10120); 
/*!40000 ALTER TABLE `officerCases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobHistory`
--
DROP TABLE IF EXISTS jobHistory;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE jobHistory(jobHistoryID INT NOT NULL,
						policeID INT NOT NULL,
						position ENUM('Rookie Officer', 'Experienced Officer', 'Corporal', 'Sergeant', 'Lieutenant',
									'Captain', 'Major', 'Deputy Chief', 'Chief of Police', 'Commissioner') NOT NULL,
                        precinctID INT NOT NULL,
                        startDate DATE NOT NULL,
						endDate DATE NOT NULL,
                        PRIMARY KEY (jobHistoryID),
                        FOREIGN KEY(precinctID) REFERENCES precincts(precinctID)) DEFAULT CHARSET=latin1;
                       /*!40101 SET character_set_client = @saved_cs_client */;
                       
LOCK TABLES `jobHistory` WRITE;
/*!40000 ALTER TABLE `jobHistory` DISABLE KEYS */;
INSERT INTO jobHistory VALUES
(6789001, 10107, 'Sergeant', 1002, '1999-10-23', '2003-07-20'), 
(6789002, 10107, 'Lieutenant', 1002, '2003-07-20', '2006-11-29'),
(6789003, 10107, 'Captain', 1002, '2006-11-29', '2009-03-10'), 
(6789004, 10107, 'Major', 1007, '2009-03-22', '2013-08-16'), 
(6789005, 10107, 'Deputy Chief', 1007, '2013-08-16', '2015-01-10'), 
(6789006, 10107, 'Chief of Police', 1001, '2015-01-10', '2020-07-08'), 
(6789007, 10120, 'Rookie Officer', 1011, '2006-01-10', '2008-11-23'), 
(6789008, 10120, 'Experienced Officer', 1011, '2008-11-23', '2009-09-13'), 
(6789009, 10120, 'Experienced Officer', 1000, '2009-09-13', '2013-06-24'), 
(6789010, 10120, 'Experienced Officer', 1001, '2013-06-24', '2020-07-08'), 
(6789011, 10120, 'Corporal', 1001, '2020-07-08', '2024-10-12'),
(6789012, 10112, 'Captain', 1017, '2005-11-08', '2008-08-11'),
(6789013, 10112, 'Captain', 1006, '2008-08-11', '2013-01-18'),
(6789014, 10112, 'Major', 1006, '2013-01-18', '2017-03-04'),
(6789015, 10112, 'Deputy Chief', 1006, '2017-03-04', '2023-04-15');
/*!40000 ALTER TABLE `jobHistory` ENABLE KEYS */;
UNLOCK TABLES;
