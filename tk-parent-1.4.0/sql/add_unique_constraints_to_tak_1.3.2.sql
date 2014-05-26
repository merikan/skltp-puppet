
-- Skapa unique constraints för alla kolumner där TAK förväntar sig att det ska finnas. 
-- Unique contraints har tidigare fungerat i TAK utan att de har behövt finnas
-- uppsatta i schemat. Men i och med Grails version 2.2.4 (se jira SKLTP-309, https://skl-tp.atlassian.net/browse/SKLTP-309)
-- så verkar så inte längre vara fallet.

ALTER TABLE `RivVersion` 
ADD CONSTRAINT UC_NAMN UNIQUE(`namn`);

ALTER TABLE `Tjanstekomponent` 
ADD CONSTRAINT UC_HSAID UNIQUE(`hsaId`);

ALTER TABLE `Tjanstekontrakt` 
ADD CONSTRAINT UC_NAMNRYMD UNIQUE(`namnrymd`);

ALTER TABLE `LogiskAdressat` 
ADD CONSTRAINT UC_HSAID UNIQUE(`hsaId`);

ALTER TABLE `LogiskAdress` 
ADD UNIQUE KEY UC_RIVVERSION (`rivVersion_id`, `tjanstekontrakt_id`, `logiskAdressat_id`, `fromTidpunkt`, `tomTidpunkt`);

ALTER TABLE `Anropsbehorighet` 
ADD UNIQUE KEY UC_TJANSTEKONSUMENT (`tjanstekonsument_id`, `tjanstekontrakt_id`, `logiskAdressat_id`, `fromTidpunkt`, `tomTidpunkt`);