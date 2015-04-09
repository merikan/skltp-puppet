

-- user=admin password=changeme
-- user=skltp password=skltp
INSERT INTO `Anvandare` (`id`, `anvandarnamn`, `losenord_hash`, `administrator`, `version`) VALUES
(1, 'admin', 'fa9beb99e4029ad5a6615399e7bbae21356086b3', 1, 0),
(2, 'skltp', '3e1a694fd3a41e113dfbd4bf108cdee44206d1b1', 1, 0);


INSERT INTO `RivTaProfil` (`id`, `beskrivning`, `namn`, `version`) VALUES
(1, 'RIV TA BP 2.0', 'RIVTABP20', 0),
(2, 'RIV TA BP 2.1', 'RIVTABP21', 0);


INSERT INTO `Tjanstekontrakt` (`id`, `beskrivning`, `namnrymd`, `majorVersion`, `minorVersion`, `version`) VALUES
(1, 'Tidbokning - GetSubjectOfCareSchedule', 'urn:riv:crm:scheduling:GetSubjectOfCareScheduleResponder:1', 1, 0, 0),
(2, 'Ping', 'urn:riv:itinfra:tp:PingResponder:1', 1, 0, 0),
(3, 'Stödtjänst VP', 'urn:riv:itintegration:registry:GetLogicalAddresseesByServiceContractResponder:1', 1, 0, 0),
(4, 'Stödtjänst VP', 'urn:riv:itintegration:registry:GetSupportedServiceContractsResponder:1', 1, 0, 0),
(5, 'Engagemangsindex - Findcontent', 'urn:riv:itintegration:engagementindex:FindContentResponder:1', 1, 0, 0),
(6, 'Engagemangsindex - ProcessNotification', 'urn:riv:itintegration:engagementindex:ProcessNotificationResponder:1', 1, 0, 0),
(7, 'Engagemangsindex - Update', 'urn:riv:itintegration:engagementindex:UpdateResponder:1', 1, 0, 0),
(8, 'Engagemangsindex - GetUpdates', 'urn:riv:itintegration:engagementindex:GetUpdatesResponder:1', 1, 0, 0),
(9, 'GetCareContacts', 'urn:riv:clinicalprocess:logistics:logistics:GetCareContactsResponder:2', 2, 0, 0);


INSERT INTO `Tjanstekomponent` (`id`, `beskrivning`, `hsaId`, `version`) VALUES
(1, 'Demo tidbok', 'Schedulr', 0),
(4, 'tp test client', 'client', 0),
(5, 'VP intern ping tjänst', 'Ping-service', 0),
(6, 'Producent: Engagemangsidex - Update', 'EI-Update', 0),
(7, 'Producent: Engagemangsidex - FindContent', 'EI-FindContent', 0),
(8, 'Producent: Engagemangsidex - ProcessNotification', 'EI-ProcessNotification', 0),
(9, 'VP-Cachad-GetLogicalAddresseesByServiceContract', 'VP-Cachad-GetLogicalAddresseesByServiceContract', 0),
(10, 'Inera som konsument, t ex en aggregerande tjänst', 'NTjP', 0),
(11, 'Producent: GetAggregatedSubjectOfCareSchedule', 'AGT-Tidbok', 0),
(12, 'NTjP EI som konsument, borde kunna vara NTjP men är i EI v1.0 hårt koplat till owner identiteten som är Inera''s org nr...', '5565594230', 0),
(13, 'demo_ei_notify_service', 'demo_ei_notify_service', 0),
(14, 'Test producent för källsystem #1 för GetCareContacts, v2', 'HSAID-PRODUCER-1', 0),
(15, 'Test producent för källsystem #2 för GetCareContacts, v2', 'HSAID-PRODUCER-2', 0),
(16, 'Test producent för källsystem #3 för GetCareContacts, v2', 'HSAID-PRODUCER-3', 0),
(17, 'Producent: GetAggregatedCareContacts', 'AGT-CareContacts', 0);


INSERT INTO `AnropsAdress` (`id`, `adress`, `rivTaProfil_id`, `tjanstekomponent_id`, `version`) VALUES
(1, 'http://localhost:8080/Schedulr-0.5/ws/GetSubjectOfCareSchedule/1', 2, 1, 0),
(5, 'http://localhost:10000/test/Ping_Service', 1, 5, 0),
(6, 'http://localhost:8081/skltp-ei/update-service/v1', 2, 6, 0),
(7, 'http://localhost:8082/skltp-ei/find-content-service/v1', 2, 7, 0),
(8, 'http://localhost:8081/skltp-ei/notification-service/v1', 2, 8, 0),
(9, 'https://localhost:23001/vp/GetLogicalAddresseesByServiceContract/1/rivtabp21', 2, 9, 0),
(11, 'http://localhost:8083/GetAggregatedSubjectOfCareSchedule/service/v1', 2, 11, 0),
(13, 'http://localhost:10000/test/demo_ei_notify_service', 2, 13, 0),
(14, 'http://localhost:10001/CareContactTestProcuder/service/GetCareContacts/v2', 2, 14, 0),
(15, 'http://localhost:10001/CareContactTestProcuder/service/GetCareContacts/v2', 2, 15, 0),
(16, 'http://localhost:10001/CareContactTestProcuder/service/GetCareContacts/v2', 2, 16, 0),
(17, 'http://localhost:8084/GetAggregatedCareContacts/service/v2', 2, 17, 0);


INSERT INTO `LogiskAdress` (`id`, `beskrivning`, `hsaId`, `version`) VALUES
(1, 'Demo adressat tidbok, vardcentralen kusten, Karna', 'HSA-VKK123', 0),
(2, 'Demo adressat tidbok, vardcentralen kusten, Marstrand', 'HSA-VKM345', 0),
(3, 'Demo adressat tidbok, vardcentralen kusten, Ytterby', 'HSA-VKY567', 0),
(4, 'VP''s egna ping-tjanst', 'Ping', 0),
(5, 'Organisation: Inera', '5565594230', 0),
(6, 'demo-ei-notify-publisher', 'demo-ei-notify-publisher', 0),
(7, 'Källsystem 1', 'HSAID-SOURCE_SYSTEM-1', 0),
(8, 'Källsystem 2', 'HSAID-SOURCE_SYSTEM-2', 0),
(9, 'Källsystem 3', 'HSAID-SOURCE_SYSTEM-3', 0),
(10, 'Sverige', 'SE', 0);


INSERT INTO `Anropsbehorighet` (`id`, `fromTidpunkt`, `integrationsavtal`, `tomTidpunkt`, `version`, `logiskAdress_id`, `tjanstekonsument_id`, `tjanstekontrakt_id`) VALUES
(1, '2013-05-24', 'I1', '2113-05-24', 0, 1, 4, 1),
(2, '2013-05-24', 'I1', '2113-05-24', 0, 2, 4, 1),
(3, '2013-05-24', 'I1', '2113-05-24', 0, 3, 4, 1),
(4, '2013-05-28', 'I2', '2113-05-28', 0, 4, 4, 2),
(5, '2013-08-24', 'EI', '2113-08-24', 0, 5, 12, 3),
(6, '2013-08-24', 'I3', '2113-08-24', 0, 5, 4, 1),
(7, '2013-08-24', 'EI', '2113-08-24', 0, 5, 10, 5),
(8, '2013-08-25', 'I4', '2113-08-25', 0, 5, 4, 5),
(9, '2013-09-16', 'I3 (för Schedulr)', '2113-09-16', 0, 5, 4, 7),
(10, '2013-09-16', 'I5', '2113-09-16', 0, 6, 4, 6),
(11, '2013-09-16', 'EI', '2113-09-16', 0, 6, 12, 6),
(12, '2014-10-06', 'I4', '2114-10-06', 0, 10, 4, 9);


INSERT INTO `Vagval` (`id`, `fromTidpunkt`, `tomTidpunkt`, `version`, `logiskAdress_id`, `tjanstekontrakt_id`, `anropsAdress_id`) VALUES
(1, '2013-05-24', '2113-05-24', 0, 1, 1, 1),
(2, '2013-05-24', '2113-05-24', 0, 2, 1, 1),
(3, '2013-05-24', '2113-05-24', 0, 3, 1, 1),
(4, '2013-05-28', '2113-05-28', 0, 4, 2, 5),
(5, '2013-08-24', '2113-08-24', 0, 5, 3, 9),
(6, '2013-08-24', '2113-08-24', 0, 5, 5, 7),
(7, '2013-08-24', '2113-08-24', 0, 5, 6, 8),
(8, '2013-08-24', '2113-08-24', 0, 5, 7, 6),
(9, '2013-08-24', '2113-08-24', 0, 5, 1, 11),
(10, '2013-09-16', '2113-09-16', 0, 6, 6, 13),
(11, '2014-10-06', '2214-10-06', 0, 7, 9, 14),
(12, '2014-10-06', '2214-10-06', 0, 8, 9, 15),
(13, '2014-10-06', '2214-10-06', 0, 9, 9, 16),
(14, '2014-10-07', '2114-10-07', 0, 5, 9, 17);