# Välj rätt databas
use tak;

# Skapa nya tabeller i vald databas

DROP TABLE IF EXISTS Filtercategorization;
DROP TABLE IF EXISTS Filter;
DROP TABLE IF EXISTS anvandare;
DROP TABLE IF EXISTS Vagval;
DROP TABLE IF EXISTS Anropsbehorighet;
DROP TABLE IF EXISTS LogiskAdress;
DROP TABLE IF EXISTS Tjanstekontrakt;
DROP TABLE IF EXISTS AnropsAdress;
DROP TABLE IF EXISTS Tjanstekomponent;
DROP TABLE IF EXISTS RivTaProfil;



CREATE TABLE `RivTaProfil` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `beskrivning` varchar(255) DEFAULT NULL,
  `namn` varchar(255) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_NAMN` (`namn`)
) ENGINE=INNODB;

CREATE TABLE `Tjanstekomponent` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `beskrivning` varchar(255) DEFAULT NULL,
  `hsaId` varchar(255) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_HSAID` (`hsaId`)
) ENGINE=INNODB;

CREATE TABLE `Tjanstekontrakt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `beskrivning` varchar(255) DEFAULT NULL,
  `namnrymd` varchar(255) DEFAULT NULL,
  `majorVersion` bigint(20) DEFAULT 0,
  `minorVersion` bigint(20) DEFAULT 0,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_NAMNRYMD` (`namnrymd`)
) ENGINE=INNODB;

CREATE TABLE `LogiskAdress` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `beskrivning` varchar(255) DEFAULT NULL,
  `hsaId` varchar(255) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_HSAID` (`hsaId`)
) ENGINE=INNODB;

CREATE TABLE `Anropsbehorighet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fromTidpunkt` date DEFAULT NULL,
  `integrationsavtal` varchar(255) DEFAULT NULL,
  `tomTidpunkt` date DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `logiskAdress_id` bigint(20) NOT NULL,
  `tjanstekonsument_id` bigint(20) NOT NULL,
  `tjanstekontrakt_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_TJANSTEKONSUMENT` (`tjanstekonsument_id`,`tjanstekontrakt_id`,`logiskAdress_id`,`fromTidpunkt`,`tomTidpunkt`),
  KEY `FK1144C39E31F3452` (`tjanstekontrakt_id`),
  KEY `FK1144C39E388AE8DD` (`tjanstekonsument_id`),
  KEY `FK1144C39EA69F7BA2` (`logiskAdress_id`),
  FOREIGN KEY (logiskAdress_id) REFERENCES LogiskAdress (id),
  FOREIGN KEY (tjanstekonsument_id) REFERENCES Tjanstekomponent (id),
  FOREIGN KEY (tjanstekontrakt_id) REFERENCES Tjanstekontrakt (id)
) ENGINE=INNODB;

CREATE TABLE `AnropsAdress` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `adress` varchar(255) DEFAULT NULL,
  `rivTaProfil_id` bigint(20) NOT NULL,
  `tjanstekomponent_id` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_TJANSTEKOMPONENT_ADRESS` (`tjanstekomponent_id`,`rivTaProfil_id`,`adress`),
  KEY `FK9144C39E31F3452` (`tjanstekomponent_id`),
  KEY `FK9144C39E388AE8DD` (`rivTaProfil_id`),
  FOREIGN KEY (tjanstekomponent_id) REFERENCES Tjanstekomponent (id),
  FOREIGN KEY (rivTaProfil_id) REFERENCES RivTaProfil (id)

) ENGINE=INNODB;


CREATE TABLE `Vagval` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fromTidpunkt` date DEFAULT NULL,
  `tomTidpunkt` date DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `logiskAdress_id` bigint(20) NOT NULL,
  `tjanstekontrakt_id` bigint(20) NOT NULL,
  `anropsAdress_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_VAGVAL_ADRESS` (`anropsAdress_id`, `tjanstekontrakt_id`,`logiskAdress_id`,`fromTidpunkt`,`tomTidpunkt`),
  KEY `FK2C881BB350F9DB81` (`anropsAdress_id`),
  KEY `FK2C881BB3E6234A82` (`tjanstekontrakt_id`),
  KEY `FK2C881BB331F3452` (`logiskAdress_id`),
  FOREIGN KEY (logiskAdress_id) REFERENCES LogiskAdress (id),
  FOREIGN KEY (anropsAdress_id) REFERENCES AnropsAdress (id),
  FOREIGN KEY (tjanstekontrakt_id) REFERENCES Tjanstekontrakt (id)
) ENGINE=INNODB;

CREATE TABLE `Anvandare` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `anvandarnamn` varchar(255) NOT NULL,
  `losenord_hash` varchar(255) NOT NULL,
  `administrator` boolean DEFAULT FALSE,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB;

CREATE TABLE `Filter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `servicedomain` varchar(255) NOT NULL,
  `version` bigint(20) NOT NULL,
  `anropsbehorighet_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_SERVICEDOMAIN` (`anropsbehorighet_id`,`servicedomain`),
  KEY `FK7D6DB798BC716E82` (`anropsbehorighet_id`),
  FOREIGN KEY (anropsbehorighet_id) REFERENCES Anropsbehorighet (id)
) ENGINE=INNODB;

CREATE TABLE `Filtercategorization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `version` bigint(20) NOT NULL,
  `filter_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UC_CATEGORY` (`filter_id`,`category`),
  KEY `FK7EB5D6C12046FE42` (`filter_id`),
  FOREIGN KEY (filter_id) REFERENCES Filter (id)
) ENGINE=INNODB;
