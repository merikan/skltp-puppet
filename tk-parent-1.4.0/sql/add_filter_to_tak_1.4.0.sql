-- Två nya tabeller för att addera filter till Anropsbehörighet
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