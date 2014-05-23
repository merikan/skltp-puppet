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
('93f8d9871f5b3b4bd95111fbd24764d70ae88e326d5c2e02adaceb0969c01052', '1', 'Booking', 'NA', '2013-08-25 07:40:44', 'schedulr-controller', 'HSA-VKK123', NULL, '5565594230', '188803099368', 'riv:crm:scheduling', 'Schedulr', NULL),
('801a0c1508e85d118013a03e5b6653104b8c09e9befb17b40c1590d6a7c5fe01', '2', 'Booking', 'NA', '2013-08-25 07:40:44', 'schedulr-controller', 'HSA-VKK123', NULL, '5565594230', '188803099368', 'riv:crm:scheduling', 'Schedulr', NULL),
('5517b68faf4ecafb6d17d4e208422260b62b62bcf5ecded546d97ceafb559f1c', '3', 'Booking', 'NA', '2013-08-25 07:44:41', 'schedulr-controller', 'HSA-VKY567', NULL, '5565594230', '188803099368', 'riv:crm:scheduling', 'Schedulr', NULL);
