
CREATE TABLE `coffrelspd` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `solde` varchar(10) NOT NULL,
  `lasttransfert` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `coffrelspd` (`id`, `identifier`, `solde`, `lasttransfert`) VALUES
(1, '0', '500', '10');

ALTER TABLE `coffrelspd`
  ADD PRIMARY KEY (`id`);
COMMIT;
