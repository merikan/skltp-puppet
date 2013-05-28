-- user=admin password=changeme
-- user=skltp password=skltp
INSERT INTO `anvandare` (`id`, `anvandarnamn`, `losenord_hash`, `administrator`, `version`) VALUES
(1, 'admin', 'fa9beb99e4029ad5a6615399e7bbae21356086b3', 1, 0),
(2, 'skltp', '3e1a694fd3a41e113dfbd4bf108cdee44206d1b1', 1, 0);

INSERT INTO `RivVersion` (`id`, `beskrivning`, `namn`, `version`) VALUES
(1, 'RIV TA BP 2.0', 'RIVTABP20', 0),
(2, 'RIV TA BP 2.1', 'RIVTABP21', 0);