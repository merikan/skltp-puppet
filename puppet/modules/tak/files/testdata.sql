

INSERT INTO `LogiskAdressat` (`id`, `beskrivning`, `hsaId`, `version`) VALUES
(1, 'Demo adressat tidbok, vardcentralen kusten, Karna', 'HSA-VKK123', 0),
(2, 'Demo adressat tidbok, vardcentralen kusten, Marstrand', 'HSA-VKM345', 0),
(3, 'Demo adressat tidbok, vardcentralen kusten, Ytterby', 'HSA-VKY567', 0),
(4, 'VP''s egna ping-tjanst', 'Ping', 0);

INSERT INTO `Tjanstekontrakt` (`id`, `beskrivning`, `namnrymd`, `version`) VALUES
(1, 'Tidbokning - GetSubjectOfCareSchedule', 'urn:riv:crm:scheduling:GetSubjectOfCareSchedule:1:rivtabp21', 0),
(2, 'Ping', 'urn:riv:itinfra:tp:Ping:1:rivtabp20', 0);

INSERT INTO `Tjanstekomponent` (`id`, `adress`, `beskrivning`, `hsaId`, `version`) VALUES
(1, 'http://33.33.33.33:8080/Schedulr-0.1/ws/GetSubjectOfCareSchedule/1', 'Demo tidbok', 'Schedulr', 0),
(4, '', 'tp test client', 'tp', 0),
(5, 'http://localhost:10000/test/Ping_Service', 'VP intern ping tjänst', 'Ping-service', 0);

INSERT INTO `LogiskAdress` (`id`, `fromTidpunkt`, `tomTidpunkt`, `version`, `logiskAdressat_id`, `rivVersion_id`, `tjanstekontrakt_id`, `tjansteproducent_id`) VALUES
(1, '2013-05-24', '2113-05-24', 0, 1, 2, 1, 1),
(2, '2013-05-24', '2113-05-24', 0, 2, 2, 1, 1),
(3, '2013-05-24', '2113-05-24', 0, 3, 2, 1, 1),
(4, '2013-05-28', '2113-05-28', 0, 4, 1, 2, 5);


INSERT INTO `Anropsbehorighet` (`id`, `fromTidpunkt`, `integrationsavtal`, `tomTidpunkt`, `version`, `logiskAdressat_id`, `tjanstekonsument_id`, `tjanstekontrakt_id`) VALUES
(1, '2013-05-24', 'I1', '2113-05-24', 0, 1, 4, 1),
(2, '2013-05-24', 'I1', '2113-05-24', 0, 2, 4, 1),
(3, '2013-05-24', 'I1', '2113-05-24', 0, 3, 4, 1),
(4, '2013-05-28', 'I2', '2113-05-28', 0, 4, 4, 2);


--
-- Constraints for table `Anropsbehorighet`
--
-- ALTER TABLE `Anropsbehorighet`
--  ADD CONSTRAINT `Anropsbehorighet_ibfk_1` FOREIGN KEY (`logiskAdressat_id`) REFERENCES `LogiskAdressat` (`id`),
--  ADD CONSTRAINT `Anropsbehorighet_ibfk_2` FOREIGN KEY (`tjanstekonsument_id`) REFERENCES `Tjanstekomponent` (`id`),
--  ADD CONSTRAINT `Anropsbehorighet_ibfk_3` FOREIGN KEY (`tjanstekontrakt_id`) REFERENCES `Tjanstekontrakt` (`id`);

--
-- Constraints for table `LogiskAdress`
--
-- ALTER TABLE `LogiskAdress`
--  ADD CONSTRAINT `LogiskAdress_ibfk_1` FOREIGN KEY (`logiskAdressat_id`) REFERENCES `LogiskAdressat` (`id`),
--  ADD CONSTRAINT `LogiskAdress_ibfk_2` FOREIGN KEY (`rivVersion_id`) REFERENCES `RivVersion` (`id`),
--  ADD CONSTRAINT `LogiskAdress_ibfk_3` FOREIGN KEY (`tjanstekontrakt_id`) REFERENCES `Tjanstekontrakt` (`id`),
--  ADD CONSTRAINT `LogiskAdress_ibfk_4` FOREIGN KEY (`tjansteproducent_id`) REFERENCES `Tjanstekomponent` (`id`);

