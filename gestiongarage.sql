SET AUTOCOMMIT = 0;

START TRANSACTION ;

CREATE DATABASE IF NOT EXISTS gestiongarage;

CREATE TABLE IF NOT EXISTS `client`
(
	`idClient` int(10) PRIMARY KEY AUTO_INCREMENT,
	`nom` VARCHAR(50) DEFAULT NULL,
	`prenom` VARCHAR(50) DEFAULT NULL,
	`codepostal` VARCHAR(30) DEFAULT NULL,
	`telephone` VARCHAR(30)DEFAULT NULL,
	`mobile` VARCHAR(30)DEFAULT NULL,
	`idDevis` int(10) DEFAULT Null,
	`idFiche` int(10) DEFAULT Null

);
CREATE TABLE `devis`
(
	`idDevis` int(10) PRIMARY KEY AUTO_INCREMENT,	
	`idFactureDevis` int(10) NOT NULL,
	`devisValide` boolean DEFAULT FALSE
	
);

CREATE TABLE `factureDevis`
(
	`idFactureDevis` int(10) PRIMARY KEY AUTO_INCREMENT,
	`tauxTVA` float(10) not Null,
	`dateFacture` date not Null,
	`detail` varchar(300) DEFAULT NULL,
	`sommeGlobale` decimal(10,2) not NULL
);

CREATE TABLE `factureFiche`
(
	`idFactureFiche` int(10) PRIMARY KEY AUTO_INCREMENT,
	`sommeGlobale` decimal(10,2) not NULL,
	`tauxTVA` float(10) not Null,
	`dateFacture` date not Null,
	`detail` varchar(300) DEFAULT NULL
);

CREATE TABLE `fiche`
(
	`idFiche` int(10) PRIMARY KEY AUTO_INCREMENT,
	`description` varchar(200) not NULL,
	`ficheValidee` boolean not Null,
	`ficheCloturee` boolean not Null,
	`niveauPriorite` varchar(100) DEFAULT NULL,	
	`createurFiche` varchar(100) DEFAULT NULL,	
	`idFactureFiche` int(10) DEFAULT Null
);

CREATE TABLE `tache`
(
	`idTache` int(10) PRIMARY KEY AUTO_INCREMENT,
	`idFiche` int(10) DEFAULT NULL,
	`tacheTerminee` boolean DEFAULT FALSE
);	

CREATE TABLE  `users`
(
	`idUser` int(10) PRIMARY KEY AUTO_INCREMENT,
	`nom` VARCHAR(100) DEFAULT NULL,
	`prenom` VARCHAR(100) DEFAULT NULL,
	`idTache` int(10) DEFAULT NULL,
	`idDevis` int(10) DEFAULT NULL,
	`bloque` boolean DEFAULT FALSE
);

CREATE TABLE `r_users_p`
(
	`idUser` int(10) DEFAULT null,
	`idProfil` int(10) DEFAULT null,
	CONSTRAINT PK_r_users_p PRIMARY KEY (`idUser`,`idProfil` )
);

CREATE TABLE `profil`
(
	`idProfil` int(10) PRIMARY KEY AUTO_INCREMENT,
	`typeProfil` varchar(30) not Null
);

CREATE TABLE `pieces`
(
	`idPiece` int(10) PRIMARY KEY AUTO_INCREMENT,
	`nomPiece` VARCHAR(50) DEFAULT NULL,
	`quantite` int(10) DEFAULT NULL,
	`prixHT` decimal(10,2) not Null,
	`idFiche` int(10) DEFAULT NULL
);

CREATE TABLE `commandePieces`
(
	`idCommandeP` int(10) PRIMARY KEY AUTO_INCREMENT,
	`valide` boolean not Null,
	`quantite` int(10) DEFAULT NULL,
	`prixHT` decimal(10,2) not Null,
	`idPiece` int(10) DEFAULT NULL
);

CREATE TABLE `stockPieces`
(
	`idStockPieces` int(10) PRIMARY KEY AUTO_INCREMENT,
	`quantite` int(10) DEFAULT NULL
);
CREATE TABLE `r_piece_stock`
(
	`idStockPieces` int(10) not null,
	`idPiece` int(10) DEFAULT NULL,
	CONSTRAINT PK_r_piece_stock PRIMARY KEY (`idStockPieces`,`idPiece` )
);
	
CREATE TABLE `voitures`
(
	`idVoiture` int(10) PRIMARY KEY AUTO_INCREMENT,
	`marque` VARCHAR(50) DEFAULT NULL,
	`modele` VARCHAR(50) DEFAULT NULL,		
	`quantite` int(10) DEFAULT Null,
	`prixHT` decimal(10,2) DEFAULT Null,
	`idDevis` int(10) DEFAULT NULL
);

CREATE TABLE `r_voiture_stock`
(
	`idStockVoitures` int(10) DEFAULT null,
	`idVoiture` int(10) DEFAULT NULL,
	CONSTRAINT PK_r_voiture_stock PRIMARY KEY (`idStockVoitures`,`idVoiture` )
);

CREATE TABLE `stockVoitures`
(
	`idStockVoitures` int(10) PRIMARY KEY AUTO_INCREMENT,
	`quantite` int(10) not NULL	
);
CREATE TABLE `commandeVoitures`
(
	`idCommandeV` int(10) PRIMARY KEY AUTO_INCREMENT,
	`quantite` int(10) DEFAULT NULL,
	`prixHT` decimal(10,2) not Null,
	`idVoiture` int(10) DEFAULT NULL
);

ALTER TABLE `commandeVoitures`
	ADD FOREIGN KEY (`idVoiture`) REFERENCES `voitures` (`idVoiture`) ;	
	
ALTER TABLE `voitures`
	ADD FOREIGN KEY (`idDevis`) REFERENCES `devis` (`idDevis`) ;

ALTER TABLE `pieces`
	ADD FOREIGN KEY (`idFiche`) REFERENCES `fiche` (`idFiche`) ;
	
	
ALTER TABLE `client`
	ADD FOREIGN KEY (`idFiche`) REFERENCES `fiche` (`idFiche`) ;
ALTER TABLE `client`
	ADD FOREIGN KEY (`idDevis`) REFERENCES `devis` (`idDevis`) ;


ALTER TABLE `fiche`
	ADD FOREIGN KEY (`idFactureFiche`) REFERENCES `factureFiche` (`idFactureFiche`) ;

ALTER TABLE `tache`
	ADD FOREIGN KEY (`idFiche`) REFERENCES `fiche` (`idFiche`) ;

ALTER TABLE `users`
	ADD FOREIGN KEY (`idTache`) REFERENCES `tache` (`idTache`) ;
ALTER TABLE `users`
	ADD FOREIGN KEY (`idDevis`) REFERENCES `devis` (`idDevis`) ;
	
ALTER TABLE `commandePieces`
	ADD FOREIGN KEY (`idPiece`) REFERENCES `pieces` (`idPiece`) ; 

ALTER TABLE `devis`
	ADD FOREIGN KEY (`idFactureDevis`) REFERENCES `factureDevis` (`idFactureDevis`) ; 
ALTER TABLE `r_users_p`
	ADD FOREIGN KEY (`idUser`) REFERENCES `users`(`idUser`);
ALTER TABLE `r_users_p`
	ADD FOREIGN KEY (`idProfil`) REFERENCES `profil`(`idProfil`);

ALTER TABLE `r_piece_stock`
	ADD FOREIGN KEY (`idStockPieces`) REFERENCES `stockpieces`(`idStockPieces`);
ALTER TABLE `r_piece_stock`
	ADD FOREIGN KEY (`idPiece`) REFERENCES `pieces`(`idPiece`);

ALTER TABLE `r_voiture_stock`
	ADD FOREIGN KEY (`idStockVoitures`) REFERENCES `stockVoitures`(`idStockVoitures`);
ALTER TABLE  `r_voiture_stock`
	ADD FOREIGN KEY (`idVoiture`) REFERENCES `voitures`(`idVoiture`);	

COMMIT;