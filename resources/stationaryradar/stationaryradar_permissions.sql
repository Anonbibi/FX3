--
-- Structure de la table `stationaryradar_permissions`
--

CREATE TABLE `stationaryradar_permissions` (
  `steamid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `permission_level` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Index pour la table `stationaryradar_permissions`
--
ALTER TABLE `stationaryradar_permissions`
  ADD PRIMARY KEY (`steamid`);

