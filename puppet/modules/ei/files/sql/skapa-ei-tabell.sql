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
