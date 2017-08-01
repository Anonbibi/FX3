--
-- Structure de la table `stationaryradar`
--

CREATE TABLE `stationaryradar` (
  `x` double(8,2) NOT NULL,
  `y` double(8,2) NOT NULL,
  `z` double(8,2) NOT NULL,
  `maxspeed` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;