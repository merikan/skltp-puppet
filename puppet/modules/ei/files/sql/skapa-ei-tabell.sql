CREATE TABLE `engagement_index_table` (
  `id` varchar(64) NOT NULL,
  `business_object_instance_id` varchar(128) NOT NULL,
  `categorization` varchar(255) NOT NULL,
  `clinical_process_interest_id` varchar(128) NOT NULL,
  `creation_time` datetime NOT NULL,
  `data_controller` varchar(64) NOT NULL,
  `logical_address` varchar(64) NOT NULL,
  `most_recent_content` datetime DEFAULT NULL,
  `owner` varchar(64) NOT NULL,
  `registered_resident_id` varchar(32) NOT NULL,
  `service_domain` varchar(255) NOT NULL,
  `source_system` varchar(64) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `engagement_search_index` (`registered_resident_id`,`service_domain`,`categorization`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `engagement_index_table` (`id`, `business_object_instance_id`, `categorization`, `clinical_process_interest_id`, `creation_time`, `data_controller`, `logical_address`, `most_recent_content`, `owner`, `registered_resident_id`, `service_domain`, `source_system`, `update_time`) VALUES
('05c0f9292aafb87632ea7886ae1ac08fc1dfb85a1e62c28466ff212c19f87a09', '1', 'Booking', 'NA', '2013-08-25 07:40:44', 'schedulr-controller', 'HSA-VKK123', NULL, '5565594230', '188803099368', 'riv:crm:scheduling', 'Schedulr', NULL),
('4551febbb9e0b89c62152e2809e19c55c3b34c7bc586f94cd315cb0ff3adc4c1', '3', 'Booking', 'NA', '2013-08-25 07:44:41', 'schedulr-controller', 'HSA-VKY567', NULL, '5565594230', '188803099368', 'riv:crm:scheduling', 'Schedulr', NULL),
('569bf2322ad87b5e2ffa841c05414a3b485e44a1726f4982f6679b2db2927a70', '2', 'Booking', 'NA', '2013-08-25 07:40:44', 'schedulr-controller', 'HSA-VKK123', NULL, '5565594230', '188803099368', 'riv:crm:scheduling', 'Schedulr', NULL);
