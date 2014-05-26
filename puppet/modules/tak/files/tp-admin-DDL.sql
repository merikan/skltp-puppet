DROP TABLE IF EXISTS Filtercategorization;
DROP TABLE IF EXISTS Filter;
DROP TABLE IF EXISTS anvandare;
DROP TABLE IF EXISTS LogiskAdress;
DROP TABLE IF EXISTS Anropsbehorighet;
DROP TABLE IF EXISTS LogiskAdressat;
DROP TABLE IF EXISTS Tjanstekontrakt;
DROP TABLE IF EXISTS Tjanstekomponent;
DROP TABLE IF EXISTS RivVersion;


CREATE TABLE `RivVersion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `beskrivning` varchar(255) DEFAULT NULL,
  `namn` varchar(255) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_NAMN` (`namn`)
) TYPE=INNODB; 

CREATE TABLE `Tjanstekomponent` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `adress` varchar(255) DEFAULT NULL,
  `beskrivning` varchar(255) DEFAULT NULL,
  `hsaId` varchar(255) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_HSAID` (`hsaId`)
) TYPE=INNODB; 

CREATE TABLE `Tjanstekontrakt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `beskrivning` varchar(255) DEFAULT NULL,
  `namnrymd` varchar(255) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_NAMNRYMD` (`namnrymd`)
) TYPE=INNODB; 

CREATE TABLE `LogiskAdressat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `beskrivning` varchar(255) DEFAULT NULL,
  `hsaId` varchar(255) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_HSAID` (`hsaId`)
) TYPE=INNODB; 

CREATE TABLE `Anropsbehorighet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fromTidpunkt` date DEFAULT NULL,
  `integrationsavtal` varchar(255) DEFAULT NULL,
  `tomTidpunkt` date DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `logiskAdressat_id` bigint(20) NOT NULL,
  `tjanstekonsument_id` bigint(20) NOT NULL,
  `tjanstekontrakt_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_TJANSTEKONSUMENT` (`tjanstekonsument_id`,`tjanstekontrakt_id`,`logiskAdressat_id`,`fromTidpunkt`,`tomTidpunkt`),
  KEY `FK1144C39E31F3452` (`tjanstekontrakt_id`),
  KEY `FK1144C39E388AE8DD` (`tjanstekonsument_id`),
  KEY `FK1144C39EA69F7BA2` (`logiskAdressat_id`),
  FOREIGN KEY (logiskAdressat_id) REFERENCES LogiskAdressat (id),
  FOREIGN KEY (tjanstekonsument_id) REFERENCES Tjanstekomponent (id),
  FOREIGN KEY (tjanstekontrakt_id) REFERENCES Tjanstekontrakt (id)
) TYPE=INNODB;

CREATE TABLE `LogiskAdress` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fromTidpunkt` date DEFAULT NULL,
  `tomTidpunkt` date DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `logiskAdressat_id` bigint(20) NOT NULL,
  `rivVersion_id` bigint(20) NOT NULL,
  `tjanstekontrakt_id` bigint(20) NOT NULL,
  `tjansteproducent_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_RIVVERSION` (`rivVersion_id`, `tjanstekontrakt_id`,`logiskAdressat_id`,`fromTidpunkt`,`tomTidpunkt`),
  KEY `FK2C881BB350F9DB81` (`tjansteproducent_id`),
  KEY `FK2C881BB3E6234A82` (`rivVersion_id`),
  KEY `FK2C881BB331F3452` (`tjanstekontrakt_id`),
  KEY `FK2C881BB3A69F7BA2` (`logiskAdressat_id`),
  FOREIGN KEY (logiskAdressat_id) REFERENCES LogiskAdressat (id),
  FOREIGN KEY (rivVersion_id) REFERENCES RivVersion (id),
  FOREIGN KEY (tjanstekontrakt_id) REFERENCES Tjanstekontrakt (id),
  FOREIGN KEY (tjansteproducent_id) REFERENCES Tjanstekomponent (id)
) TYPE=INNODB;

CREATE TABLE `anvandare` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `anvandarnamn` varchar(255) NOT NULL,
  `losenord_hash` varchar(255) NOT NULL,
  `administrator` boolean DEFAULT FALSE,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) TYPE=INNODB;

CREATE TABLE `Filter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `servicedomain` varchar(255) NOT NULL,
  `version` bigint(20) NOT NULL,
  `anropsbehorighet_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_SERVICEDOMAIN` (`anropsbehorighet_id`,`servicedomain`),
  KEY `FK7D6DB798BC716E82` (`anropsbehorighet_id`),
  FOREIGN KEY (anropsbehorighet_id) REFERENCES Anropsbehorighet (id)
) TYPE=INNODB;

CREATE TABLE `Filtercategorization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `version` bigint(20) NOT NULL,
  `filter_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_CATEGORY` (`filter_id`,`category`),
  KEY `FK7EB5D6C12046FE42` (`filter_id`),
  FOREIGN KEY (filter_id) REFERENCES Filter (id)
) TYPE=INNODB; 
