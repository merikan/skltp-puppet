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
('5517b68faf4ecafb6d17d4e208422260b62b62bcf5ecded546d97ceafb559f1c', '3', 'Booking', 'NA', '2013-08-25 07:44:41', 'schedulr-controller', 'HSA-VKY567', NULL, '5565594230', '188803099368', 'riv:crm:scheduling', 'Schedulr', NULL),
('4a87187f0c179f8b159a0cce5eb4915e52eac4c9d76d0990453f346b1d3f020e', 'NA', 'vko', 'NA', '2014-10-07 10:20:05', 'HSAID-DATA-CONTROLLER', 'HSAID-SOURCE_SYSTEM-1', NULL, '5565594230', '188803099368', 'riv:clinicalprocess:logistics:logistics', 'HSAID-SOURCE_SYSTEM-1', NULL),
('5a2194b645de14ee7ce4ea68ed5cb6bdb7eb589920e72efe27d0a71ca3811f3b', 'NA', 'vko', 'NA', '2014-10-07 10:19:54', 'HSAID-DATA-CONTROLLER', 'HSAID-SOURCE_SYSTEM-1', NULL, '5565594230', '194911172296', 'riv:clinicalprocess:logistics:logistics', 'HSAID-SOURCE_SYSTEM-1', NULL),
('5cfe78d57f13d9d08811fe824c63ee8356150a8a6bde58597a240fcffd6c3441', 'NA', 'vko', 'NA', '2014-10-07 10:19:54', 'HSAID-DATA-CONTROLLER', 'HSAID-SOURCE_SYSTEM-2', NULL, '5565594230', '194911172296', 'riv:clinicalprocess:logistics:logistics', 'HSAID-SOURCE_SYSTEM-2', NULL);