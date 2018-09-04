-- Alunos: Breno Ladeira Ramos - 201120513
-- 	       Caio César Freitas Lara - 201310584
--         Eduardo Deslandes de Andrade - 201311032
--         Raquel Barbosa Romão - 201120863
-- Trabalho prático - Etapa 3 - Banco de Dados 1
-- Professor Denilson Alves Pereira
-- Professor Ramon Gomes Costa
-- Turma: 10  Semestre: 2015/1


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


CREATE SCHEMA IF NOT EXISTS `CompAirWays` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `CompAirWays` ;

-- -----------------------------------------------------
-- Table `mydb`.`Tripulante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Tripulante` (
  `CPF` BIGINT(20) NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Passageiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Passageiro` (
  `Tripulante_CPF_Passageiro` BIGINT(20) NOT NULL,
  `Numero_de_Cliente` INT  NOT NULL AUTO_INCREMENT,
  `Passaporte` VARCHAR(45) NULL,
  UNIQUE INDEX `Numero_de_Cliente_UNIQUE` (`Numero_de_Cliente` ASC),
  PRIMARY KEY (`Tripulante_CPF_Passageiro`),
  CONSTRAINT `fk_Passageiro_Tripulante1`
    FOREIGN KEY (`Tripulante_CPF_Passageiro`)
    REFERENCES `compairways`.`Tripulante` (`CPF`)
    ON DELETE CASCADE -- em caso de exclusão do tripulante, o passsageiro também deverá ser excluído
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Funcionario` (
  `Tripulante_CPF_Funcionario` BIGINT(20) NOT NULL,
  `Num_Funcionario` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `Data_Admissao` VARCHAR(10) NOT NULL,
  `Salario` FLOAT NOT NULL,
  PRIMARY KEY (`Tripulante_CPF_Funcionario`),
  UNIQUE INDEX `Num_Funcionário_UNIQUE` (`Num_Funcionario` ASC),
  INDEX `fk_Funcionário_Tripulante1_idx` (`Tripulante_CPF_Funcionario` ASC),
  CONSTRAINT `fk_Funcionario_Tripulante1`
    FOREIGN KEY (`Tripulante_CPF_Funcionario`)
    REFERENCES `compairways`.`Tripulante` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE) -- em caso de exclusão do tripulante, o funcionario também deverá ser excluído
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Piloto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Piloto` (
  `Funcionario_Tripulante_CPF` BIGINT(20) NOT NULL,
  `Brevê` INT NOT NULL,
  `Nível` VARCHAR(10) NOT NULL,
  `Horas_de_Voo` INT NOT NULL,
  UNIQUE INDEX `Brevê_UNIQUE` (`Brevê` ASC),
  PRIMARY KEY (`Funcionario_Tripulante_CPF`),
  CONSTRAINT `fk_Piloto_Funcionario1`
    FOREIGN KEY (`Funcionario_Tripulante_CPF`)
    REFERENCES `compairways`.`Funcionario` (`Tripulante_CPF_Funcionario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)  -- em caso de exclusão do funcionário, o piloto também deverá ser excluído
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Engenheiro_de_Voo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Engenheiro_de_Voo` (
  `Funcionario_Tripulante_CPF` BIGINT(20) NOT NULL,
  `CREA` INT NOT NULL,
  UNIQUE INDEX `CREA_UNIQUE` (`CREA` ASC),
  PRIMARY KEY (`Funcionario_Tripulante_CPF`),
  CONSTRAINT `fk_Engenheiro_de_Voo_Funcionario1`
    FOREIGN KEY (`Funcionario_Tripulante_CPF`)
    REFERENCES `compairways`.`Funcionario` (`Tripulante_CPF_Funcionario`)
    ON DELETE CASCADE -- em caso de exclusão do funcionário, o engenheiro também deverá ser excluído
    ON UPDATE CASCADE) 
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comissario_de_Bordo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Comissario_de_Bordo` (
  `Funcionario_Tripulante_CPF` BIGINT(20) NOT NULL,
  `Cargo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Funcionario_Tripulante_CPF`),
  CONSTRAINT `fk_Comissario_de_Bordo_Funcionario1`
    FOREIGN KEY (`Funcionario_Tripulante_CPF`)
    REFERENCES `compairways`.`Funcionario` (`Tripulante_CPF_Funcionario`)
    ON DELETE CASCADE  -- em caso de exclusão do funcionário, o comissário também deverá ser excluído
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`De_Solo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`De_Solo` (
  `Funcionario_Tripulante_CPF` BIGINT(20) NOT NULL,
  `Cargo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Funcionario_Tripulante_CPF`),
  CONSTRAINT `fk_De_Solo_Funcionario1`
    FOREIGN KEY (`Funcionario_Tripulante_CPF`)
    REFERENCES `compairways`.`Funcionario` (`Tripulante_CPF_Funcionario`)
    ON DELETE CASCADE -- em caso de exclusão do funcionário, o de solo também deverá ser excluído
    ON UPDATE CASCADE) 
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hangar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Hangar` (
  `Hangar_Numero_de_Identificacao` INT   NOT NULL AUTO_INCREMENT,
  `Localizacao` VARCHAR(20) NOT NULL,
  `Capacidade_Maxima` INT NOT NULL,
  `Status` ENUM('O', 'L', 'M') NOT NULL,
  PRIMARY KEY (`Hangar_Numero_de_Identificacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Avião`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compairways`.`Aviao` (
  `Prefixo` CHAR(6) NOT NULL,
  `Modelo` VARCHAR(15) NOT NULL,
  `Velocidade` INT NOT NULL,
  `Cap_Maxima` INT NOT NULL,
  `Hangar_Hangar_Numero_de_Identificacao` INT NULL,
  PRIMARY KEY (`Prefixo`),
  INDEX `fk_Aviao_Hangar1_idx` (`Hangar_Hangar_Numero_de_Identificacao` ASC),
  CONSTRAINT `fk_Aviao_Hangar1`
    FOREIGN KEY (`Hangar_Hangar_Numero_de_Identificacao`)
    REFERENCES `compairways`.`Hangar` (`Hangar_Numero_de_Identificacao`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `mydb`.`Aeroporto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Aeroporto` (
  `ICAO` CHAR(4) NOT NULL,
  `Localização` VARCHAR(15) NOT NULL,
  `SItuação` ENUM ('VFR', 'IFR', 'XXX') NOT NULL,
  PRIMARY KEY (`ICAO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Voo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compairways`.`Voo` (
  `Numero_de_Voo` INT NOT NULL,
  `Tipo` ENUM ('N', 'I') NOT NULL,
  `Data` DATE NOT NULL,
  `Hora` TIME NOT NULL,
  `Aviao_Prefixo` CHAR(6) NOT NULL,
  `Aeroporto_ICAO_Decolagem` CHAR(4) NOT NULL,
  `Aeroporto_ICAO_Pouso` CHAR(4) NOT NULL,
  PRIMARY KEY (`Numero_de_Voo`),
  INDEX `fk_Voo_Aeroporto1_idx` (`Aeroporto_ICAO_Decolagem` ASC),
  INDEX `fk_Voo_Aeroporto2_idx` (`Aeroporto_ICAO_Pouso` ASC),
  INDEX `fk_Voo_Aviao1_idx` (`Aviao_Prefixo` ASC),
  CONSTRAINT `fk_Voo_Aeroporto1`
    FOREIGN KEY (`Aeroporto_ICAO_Decolagem`)
    REFERENCES `compairways`.`Aeroporto` (`ICAO`),
  CONSTRAINT `fk_Voo_Aeroporto2`
    FOREIGN KEY (`Aeroporto_ICAO_Pouso`)
    REFERENCES `compairways`.`Aeroporto` (`ICAO`),
  CONSTRAINT `fk_Voo_Aviao1`
    FOREIGN KEY (`Aviao_Prefixo`)
    REFERENCES `compairways`.`Aviao` (`Prefixo`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `mydb`.`Pista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Pista` (
  `Aeroporto_ICAO` CHAR(4) NOT NULL,
  `Numero` INT NOT NULL,
  `Tamanho` INT NOT NULL,
  PRIMARY KEY (`Aeroporto_ICAO`, `Numero`),
  INDEX `fk_Pista_Aeroporto1_idx` (`Aeroporto_ICAO` ASC),
  CONSTRAINT `fk_Pista_Aeroporto1`
    FOREIGN KEY (`Aeroporto_ICAO`)
    REFERENCES `compairways`.`Aeroporto` (`ICAO`)) -- caso a pista esteja em um aeroporto que esteja sendo usado, esta não deverá ser excluída
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Portao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Portao` (
  `Aeroporto_ICAO` CHAR(4) NOT NULL,
  `Numero` INT NOT NULL,
  `Tipo` ENUM('E', 'D') NOT NULL,
  INDEX `fk_Portão_Aeroporto1_idx` (`Aeroporto_ICAO` ASC),
  PRIMARY KEY (`Aeroporto_ICAO`, `Numero`),
  CONSTRAINT `fk_Portão_Aeroporto1`
    FOREIGN KEY (`Aeroporto_ICAO`)
    REFERENCES `compairways`.`Aeroporto` (`ICAO`) -- caso o portao esteja em um aeroporto que esteja sendo usado, esta não deverá ser excluída
   )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Telefone` (
  `Numero_de_Telefone` BIGINT(20) NOT NULL,
  `Funcionario_Tripulante_CPF` BIGINT(20) NOT NULL,
  PRIMARY KEY (`Numero_de_Telefone`, `Funcionario_Tripulante_CPF`),
  INDEX `fk_Telefone_Funcionario1_idx` (`Funcionario_Tripulante_CPF` ASC),
  CONSTRAINT `fk_Telefone_Funcionário1`
    FOREIGN KEY (`Funcionario_Tripulante_CPF`)
    REFERENCES `compairways`.`Funcionario` (`Tripulante_CPF_Funcionario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE) -- caso um funcionário seja excluído seu número de telefone também será
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Possuem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompAirWays`.`Possuem` (
  `Voo_Numero_de_Voo` INT NOT NULL,
  `Tripulante_CPF` BIGINT(20) NOT NULL,
  PRIMARY KEY (`Voo_Numero_de_Voo`, `Tripulante_CPF`),
  INDEX `fk_Voo_has_Tripulante_Tripulante1_idx` (`Tripulante_CPF` ASC),
  INDEX `fk_Voo_has_Tripulante_Voo1_idx` (`Voo_Numero_de_Voo` ASC),
  CONSTRAINT `fk_Voo_has_Tripulante_Voo1`
    FOREIGN KEY (`Voo_Numero_de_Voo`)
    REFERENCES `compairways`.`Voo` (`Numero_de_Voo`), -- caso um voo contenha tripulantes, este voo não deverá ser excluido/alterado
  CONSTRAINT `fk_Voo_has_Tripulante_Tripulante1`
    FOREIGN KEY (`Tripulante_CPF`)
    REFERENCES `compairways`.`Tripulante` (`CPF`)) -- caso um tripulante esteja em um voo, ele não deverá ser excluido/alterado
ENGINE = InnoDB; 

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE TABLE Condicao_Metereologica (
	Cod_Condicao INT NOT NULL,
    Condicao_Observacoes VARCHAR(100) NOT NULL,
    Num_Voo INT NOT NULL,
    CONSTRAINT pk_codincao PRIMARY KEY (Cod_Condicao),
    CONSTRAINT fk_num_voo_condicao FOREIGN KEY (Num_Voo)
		REFERENCES Voo (Numero_de_Voo)
        ON DELETE CASCADE ON UPDATE CASCADE
		-- em caso de exclusão ou remoção do voo,a condicao metereologica também será exclúida ou alterada
);


-- b) Exemplos de ALTER TABLE

ALTER TABLE Comissario_de_Bordo
	ADD  Horas_de_voo INT NOT NULL;

ALTER TABLE Passageiro
	ADD Num_Passagem INT NOT NULL;
    
ALTER TABLE Passageiro
	DROP Num_Passagem;

DROP TABLE Condicao_Metereologica; -- Tabela excluída, fora do projeto, apenas para testes da função

-- c) inserções de dados em cada uma das tabelas

INSERT INTO Tripulante
VALUES (11917103664,'Caio');
INSERT INTO Tripulante
VALUES (11901303566,'Raquel Barbosa ');
INSERT INTO Tripulante
VALUES (11919993638,'Eduardo Deslandes');
INSERT INTO Tripulante
VALUES (11915703638,'Breno Ladeira');
INSERT INTO Tripulante
VALUES (1194403638,'Ramon Gomes');
INSERT INTO Tripulante
VALUES (11912103638,'Denilson Alves');
INSERT INTO Tripulante
VALUES (441915703638,'Bruno');
INSERT INTO Tripulante
VALUES (222222222222,'Ana Paula');
INSERT INTO Tripulante
VALUES (993533331999,'Neumar Malheiros');
INSERT INTO Tripulante
VALUES (11915706638,'Marluce');
INSERT INTO Tripulante
VALUES (11915737838,'Bermejo');
INSERT INTO Tripulante
VALUES (11915666638,'Zambalde');
INSERT INTO Tripulante
VALUES (55515666638,'Andre Pimenta');
INSERT INTO Tripulante
VALUES (15569906638,'Joaquim Quinteiro');
INSERT INTO Tripulante
VALUES (55577776638,'Rafael Winckler');
INSERT INTO Tripulante
VALUES (55566006614,'Alexandre Henrique');
INSERT INTO Tripulante
VALUES (55566006644,'Tulio Barreto');
INSERT INTO Tripulante
VALUES (55566006334,'Jamile Andrade');
INSERT INTO Tripulante
VALUES (55566006114,'Barack Obama');
INSERT INTO Tripulante
VALUES (55566004444,'Luiz Inácio da Silcva');
INSERT INTO Tripulante
VALUES (55566009994,'Luana Nayara');
INSERT INTO Tripulante
VALUES (55566006664,'Tais Oliveria');
INSERT INTO Tripulante
VALUES (555660065464,'Louise Cinquini');
INSERT INTO Tripulante
VALUES (555333205554,'Leticia Duarte');
INSERT INTO Tripulante
VALUES (55566666554,'Livia Lara');
INSERT INTO Tripulante
VALUES (11566005554,'Carolina Lima');
INSERT INTO Tripulante
VALUES (11566999554,'Carolina Duarte');
INSERT INTO Tripulante
VALUES (11566444554,'Ana Camila');
INSERT INTO Tripulante
VALUES (11566222554,'Paula Vilela');
INSERT INTO Tripulante
VALUES (11566111554,'Tuane Melo');
INSERT INTO Tripulante
VALUES (11553453554,'Tuane Jamile');
INSERT INTO Tripulante
VALUES (34566111554,'Josiane Pereira');
INSERT INTO Tripulante
VALUES (34786111554,'Karina Mendes');
INSERT INTO Tripulante
VALUES (34996111554,'Paulo Henrique');
INSERT INTO Tripulante
VALUES (34111111554,'Evelise Corbalen');
INSERT INTO Tripulante
VALUES (66996111554,'Renato Freitas');
INSERT INTO Tripulante
VALUES (11566444666,'Lara Alencar');
INSERT INTO Tripulante
VALUES (21446444666,'Bianca Morais');
INSERT INTO Tripulante
VALUES (11346444666,'Leticia Vilela');


INSERT INTO Funcionario
VALUES (11917103664, 4444,'02/09/1994', 3333.33);
INSERT INTO Funcionario
VALUES (11901303566,3444,'02/09/1996', 9485.33);
INSERT INTO Funcionario
VALUES (11919993638,54555,'02/09/1980', 9433.33);
INSERT INTO Funcionario
VALUES (11915703638, 545555,'02/09/2005', 7766.33);
INSERT INTO Funcionario
VALUES (1194403638,44555,'02/10/1994', 9434.33);
INSERT INTO Funcionario
VALUES (11912103638,34555,'02/10/2012', 100000.33);
INSERT INTO Funcionario
VALUES (441915703638,44995,'02/10/2013', 6666.00);
INSERT INTO Funcionario
VALUES (222222222222,23125,'02/12/1966', 5000.33);
INSERT INTO Funcionario
VALUES (993533331999,40905,'02/10/1990', 3500.00);
INSERT INTO Funcionario
VALUES (11915706638,12120,'02/10/2006', 200000.66);
INSERT INTO Funcionario
VALUES (11915737838,445550,'06/10/2011', 9434.33);
INSERT INTO Funcionario
VALUES (11915666638,445551,'01/09/1994', 9434.12);
INSERT INTO Funcionario
VALUES (55515666638,445552,'02/01/2015', 9000.33);
INSERT INTO Funcionario
VALUES (15569906638,445553,'02/10/1998', 7000.23);
INSERT INTO Funcionario
VALUES (55566006614,00001,'02/10/2012', 10222.33);
INSERT INTO Funcionario
VALUES (55566006644,34333,'02/10/2012', 10000.33);
INSERT INTO Funcionario
VALUES (55566006334,34222,'02/10/2012', 7500.33);
INSERT INTO Funcionario
VALUES (55566006114,34444,'02/10/2012', 1000.13);
INSERT INTO Funcionario
VALUES (55566009994,344555,'02/10/2012', 100000.33);
INSERT INTO Funcionario
VALUES (55566006664,34111,'02/10/2012', 100000.33);
INSERT INTO Funcionario
VALUES (555660065464,34000,'02/10/2012', 100000.33);
INSERT INTO Funcionario
VALUES (555333205554,34224,'02/10/2012', 100000.33);
INSERT INTO Funcionario
VALUES (11346444666,39924,'02/10/2012', 6000.33);

INSERT INTO Telefone
VALUES (3131841374,11917103664);
INSERT INTO Telefone
VALUES (3731841374,11917103664);
INSERT INTO Telefone
VALUES (3731841334,11901303566);
INSERT INTO Telefone
VALUES (3731833374,11919993638);
INSERT INTO Telefone
VALUES (3731833374,11915703638);
INSERT INTO Telefone
VALUES (2733341374,1194403638);

INSERT INTO Piloto
VALUES(11917103664,455332,'Piloto',4500);
INSERT INTO Piloto
VALUES(11901303566,459932,'Piloto',2250);
INSERT INTO Piloto
VALUES(11919993638,335332,'Co-Piloto',1700);
INSERT INTO Piloto
VALUES(11346444666,335832,'Co-Piloto',3000);
INSERT INTO Piloto
VALUES(11915703638,122332,'Co-Piloto',1200);
INSERT INTO Piloto
VALUES(1194403638,132332,'Reserva',700);
INSERT INTO Piloto
VALUES(555333205554,138966,'Reserva',400);

INSERT INTO Comissario_de_Bordo 
VALUES (11912103638,'Comis_chefe',7000);
INSERT INTO Comissario_de_Bordo 
VALUES (441915703638,'Enfermeiro',3000);
INSERT INTO Comissario_de_Bordo 
VALUES (222222222222,'Comissario',1500);
INSERT INTO Comissario_de_Bordo 
VALUES (993533331999,'Comis_Treinee',130);
INSERT INTO Comissario_de_Bordo 
VALUES (11915706638,'Comis_chefe',12000);

INSERT INTO Engenheiro_de_Voo
VALUES (11915737838,123456);
INSERT INTO Engenheiro_de_Voo
VALUES (11915666638,999456);
INSERT INTO Engenheiro_de_Voo
VALUES (55515666638,122256);
INSERT INTO Engenheiro_de_Voo
VALUES (15569906638,123956);
INSERT INTO Engenheiro_de_Voo
VALUES (55566006614,123000);

INSERT INTO De_Solo
VALUES (55566006644,'Mecânico');
INSERT INTO De_Solo
VALUES (55566006334,'Segurança');
INSERT INTO De_Solo
VALUES (55566006114,'Auxiliar-Pista');
INSERT INTO De_Solo
VALUES (55566009994,'Operador-Hangar');
INSERT INTO De_Solo
VALUES (55566006664,'Mecânico');
INSERT INTO De_Solo
VALUES (555660065464,'Faixineiro');

INSERT INTO Passageiro
VALUES (55566666554,123000,NULL);
INSERT INTO Passageiro
VALUES (11566005554,123999,55545678);
INSERT INTO Passageiro
VALUES (11566999554,333000,NULL);
INSERT INTO Passageiro
VALUES (11566444554,123600,NULL);
INSERT INTO Passageiro
VALUES (11566222554,123770,12345678);
INSERT INTO Passageiro
VALUES (11566111554,123330,NULL);
INSERT INTO Passageiro
VALUES (11553453554,123220,NULL);
INSERT INTO Passageiro
VALUES (34566111554,124440,12345699);


INSERT INTO Hangar
VALUES (4759, 'Belo Horizonte', 6, 'L');
INSERT INTO Hangar
VALUES (4459, 'Lavras', 2, 'M');
INSERT INTO Hangar
VALUES (4953, 'São Paulo', 10, 'L');
INSERT INTO Hangar
VALUES (3349, 'Rio de Janeiro', 12, 'O');
INSERT INTO Hangar
VALUES (2256, 'Fortaleza', 4, 'L');
INSERT INTO Hangar
VALUES (4760, 'Manaus', 6, 'L');
INSERT INTO Hangar
VALUES (4740, 'Florianopolis', 3, 'L');
INSERT INTO Hangar
VALUES (4040, 'Porto Alegre', 9, 'L');
INSERT INTO Hangar
VALUES (2740, 'Natal', 5, 'O');
INSERT INTO Hangar
VALUES (2746, 'Varginha', 1, 'L');
INSERT INTO Hangar
VALUES (2525, 'Campo Grande', 1, 'L');
INSERT INTO Hangar
VALUES (2222, 'Campo Grande', 1, 'L');


INSERT INTO Aviao
VALUES ('PT-XYZ','Airbus A330', 845, 250, NULL);
INSERT INTO Aviao
VALUES ('PT-KTS','Airbus A380', 1000, 540, NULL);
INSERT INTO Aviao
VALUES ('PR-KFS','Embraer E195', 950, 140, NULL);
INSERT INTO Aviao
VALUES ('PR-AFS','Embraer E175', 750, 80, 2256);
INSERT INTO Aviao
VALUES ('PP-ABC','Boeing 777', 1015, 350, NULL);
INSERT INTO Aviao
VALUES ('PP-AKC','Boeing 747', 1057, 600, 2256);
INSERT INTO Aviao
VALUES ('PT-ABC','ATR 72', 600, 60, 4953);
INSERT INTO Aviao
VALUES ('PR-XXX','Boeing 737', 1050, 200,4740);
INSERT INTO Aviao
VALUES ('PT-CAI','ATR 42', 600, 40, NULL);
INSERT INTO Aviao
VALUES ('PR-LUA','Boeing 737', 1050, 200,NULL);
INSERT INTO Aviao
VALUES ('PR-KCC','Cesna 172', 1050, 4,NULL);
INSERT INTO Aviao
VALUES ('PR-KCG','Cesna Cit', 1050, 12,4740);
INSERT INTO Aviao
VALUES ('PR-KCX','Embraer Legacy', 1050, 18,NULL);
INSERT INTO Aviao
VALUES ('PR-ACL','Embraer E190', 1000, 130,NULL);
INSERT INTO Aviao
VALUES ('PR-HCX','Boeing 727', 800, 260,3349);
INSERT INTO Aviao
VALUES ('PT-LLX','Airbus A320', 800, 260, NULL);
INSERT INTO Aviao
VALUES ('PT-LUA','Airbus A330', 800, 410, NULL);
INSERT INTO Aviao
VALUES ('PT-UIT','Airbus A321', 800, 200, 4040);


INSERT INTO Aeroporto
VALUES ('SBSP','São Paulo', 'IFR');
INSERT INTO Aeroporto
VALUES ('SBCF','Confins', 'VFR');
INSERT INTO Aeroporto
VALUES ('SBBH','Belo Horizonte', 'VFR');
INSERT INTO Aeroporto
VALUES ('SBRJ','Rio de Janeiro', 'IFR');
INSERT INTO Aeroporto
VALUES ('SSOL','Lavras', 'VFR');
INSERT INTO Aeroporto
VALUES ('SGAM','Manaus', 'VFR');
INSERT INTO Aeroporto
VALUES ('SBSC', 'Florianopolis','IFR');
INSERT INTO Aeroporto
VALUES ('SBBR', 'Brasilia','IFR');
INSERT INTO Aeroporto
VALUES ('SBVT', 'Vitoria','VFR');
INSERT INTO Aeroporto
VALUES ('SBPS', 'Porto Seguro','VFR');
INSERT INTO Aeroporto
VALUES ('SBMT', 'Campo Grande','IFR');
INSERT INTO Aeroporto
VALUES ('SBNY', 'Nova York','VFR');
INSERT INTO Aeroporto
VALUES ('SNMI', 'Miami','VFR');
INSERT INTO Aeroporto
VALUES ('SBLO', 'Londres','IFR');
INSERT INTO Aeroporto
VALUES ('SGPA', 'Paris','IFR');

INSERT INTO Pista 
VALUES ('SBBH',16,2000);
INSERT INTO Pista 
VALUES ('SBBH',18,2000);
INSERT INTO Pista 
VALUES ('SBSP',16,2055);
INSERT INTO Pista 
VALUES ('SSOL',18,2000);
INSERT INTO Pista 
VALUES ('SBRJ',02,6000);
INSERT INTO Pista 
VALUES ('SBSC',16,2500);
INSERT INTO Pista 
VALUES ('SGAM',16,2500);
INSERT INTO Pista 
VALUES ('SBVT',10,1970);

INSERT INTO Portao
VALUES ('SBBH',02,'D');
INSERT INTO Portao
VALUES ('SBRJ',02,'D');
INSERT INTO Portao
VALUES ('SSOL',05,'E');    
INSERT INTO Portao
VALUES ('SBBH',06,'E');
INSERT INTO Portao
VALUES ('SBRJ',03,'D');
INSERT INTO Portao
VALUES ('SGAM',01,'D');
INSERT INTO Portao
VALUES ('SBSC',12,'E');
    

INSERT INTO Voo
VALUES (125,'I','2015-06-06', '23:00:00', 'PT-XYZ','SBBH','SGPA');
INSERT INTO Voo
VALUES (129,'I','2015-07-24', '06:40:00', 'PT-KTS','SSOL','SBNY');
INSERT INTO Voo
VALUES (155,'N','2014-08-30', '18:20:00', 'PR-KFS','SBCF','SBRJ');
INSERT INTO Voo
VALUES (255,'N','2014-08-30', '18:30:00', 'PP-ABC','SBBR','SBRJ');
INSERT INTO Voo
VALUES (727,'N','2014-08-30', '13:00:00', 'PT-KTS','SBSP','SGAM'); 
INSERT INTO Voo
VALUES (127,'N','2014-08-30', '19:30:00', 'PT-KTS','SBSP','SBRJ'); 
INSERT INTO Voo
VALUES (299,'N','2014-08-30', '04:30:00', 'PT-KTS','SBSP','SSOL'); 
INSERT INTO Voo
VALUES (415,'I','2014-08-30', '04:30:00', 'PT-KTS','SBNY','SSOL'); 



INSERT INTO Possuem 
VALUES (127,11917103664);
INSERT INTO Possuem 
VALUES (127,11912103638);
INSERT INTO Possuem 
VALUES (125,222222222222);
INSERT INTO Possuem 
VALUES (255,55566006114);
INSERT INTO Possuem 
VALUES (727,555660065464);
INSERT INTO Possuem 
VALUES (727,55566006114);
INSERT INTO Possuem 
VALUES (155,993533331999);
INSERT INTO Possuem 
VALUES (129,55566006114);
INSERT INTO Possuem 
VALUES (125,55515666638);
INSERT INTO Possuem 
VALUES (125,11919993638);
INSERT INTO Possuem 
VALUES (125,11566999554);

-- d) atualização de dados em tabelas

UPDATE aeroporto
set situação='IFR'
where ICAO='SBVT'; -- alteração da situação de um aeroporto que não está em uso

UPDATE aviao
set cap_maxima=cap_Maxima*0.80
where aviao.Cap_Maxima>380; -- diminuição de 20 %  do máximo de passageiros em aeronaves com mais de 380 passageiros, visando maior conforto 

UPDATE pista
set pista.Tamanho=3000
where pista.Aeroporto_ICAO='SBVT' and pista.numero=10;

UPDATE funcionario
set funcionario.Salario=funcionario.Salario *1.30
where funcionario.Salario<5000;

UPDATE piloto
set piloto.Horas_de_Voo=piloto.Horas_de_Voo + 50
where piloto.Funcionario_Tripulante_CPF
in (select Funcionario_Tripulante_CPF from possuem where
  (piloto.Funcionario_Tripulante_CPF=possuem.Tripulante_CPF and  possuem.Voo_Numero_de_Voo>100));
-- alteração no número de horas de voo dos pilotos que voaram em voos de número acima de 100


-- e) exclusão de dados em tabelas

delete from pista
where Aeroporto_ICAO='SBVT' and Numero=10; -- exclusao de uma pista de um aeroporto que não esta sendo usado, sem excluir o aeroporto

delete from tripulante
where CPF=555333205554; -- exclusao de um tripulante que não participou de nenhum voo, por cascata também é excluido sua tupla de funcionario e piloto

delete from aviao
where prefixo='PR-XXX'; -- exclusão de um aviao que não está em uso

delete from hangar 
where Hangar_Numero_de_Identificacao=2525; -- exclusão de um hangar que não possui avioes guardados

delete from aviao
where (Cap_Maxima<100);  -- exclusao de avioes que possuam capacidade de passageiros inferior  a 100

delete from funcionario
where  (funcionario.salario>12000) and funcionario.Tripulante_CPF_Funcionario in 
(select funcionario.Tripulante_CPF_Funcionario from comissario_de_bordo where comissario_de_bordo.Funcionario_Tripulante_CPF=funcionario.Tripulante_CPF_Funcionario)
 LIMIT 2;  -- exclusão de no maximo 2 comissários  com salario superiores a 12 mil.

-- as operações a seguir não são permitidas: (estão comentadas para não atrapalhar a compilação do script)
-- delete from aeroporto
-- where ICAO='SBBH'; -- aeroporto com operações

-- delete from hangar 
-- Hangar_Numero_de_Identificacao=2256; -- hangar com avioes

-- delete from voo
-- where Numero_de_Voo=125; -- voo tripulado

-- delete from tripulante
-- where CPF=11917103664; -- tripulante em voo

--  f) Exemplos de, pelo menos, 12 consultas

-- 1  selecionar prefixo e  modelo dos avioes com capacidade maior que 300 passageiros
select prefixo, modelo from aviao
where (Cap_Maxima>300);

-- 2  selecionar todos os tripulantes do voo 255;
select Nome
from tripulante  Inner JOIN possuem on tripulante.CPF=possuem.Tripulante_CPF
where possuem.Voo_Numero_de_Voo=255;

-- 3 selecionar os funcionarios que trabalharam nos voos 255 ou 727
select Num_Funcionario
from funcionario INNER JOIN possuem on funcionario.Tripulante_CPF_Funcionario=possuem.Tripulante_CPF
where possuem.Voo_Numero_de_Voo=255 or possuem.Voo_Numero_de_Voo=727;

-- 4 selecionar o nome dos funcionarios por ordem crescente de salario
select Nome from tripulante inner join funcionario
where tripulante.CPF=funcionario.Tripulante_CPF_Funcionario
order by  salario;

--  5 selecionar todos os hangares que possuem capacidade maxima entre 2 e 10
select Localizacao from hangar 
where hangar.Capacidade_Maxima between 2 and 10;

-- 6 selecionar o nome de  todos os passageiros de voos internacionais ou seja que o número do passaporte não são nulos.
select Nome from passageiro inner join tripulante
where passageiro.Tripulante_CPF_Passageiro=tripulante.CPF and passageiro.Passaporte IS NOT NULL;

-- 7 agrupar quantos voos partirar de determinado aeroporto por ICAO
select count(numero_de_voo), aeroporto_icao_decolagem from voo 
group by aeroporto_icao_decolagem; 

--  8 selecionar todos os avioes que voaram nos voos 255, 299 ou estão em algum hangar

(select prefixo, modelo from aviao inner join voo
where (Numero_de_Voo=255 or Numero_de_Voo=299) and aviao.prefixo=voo.aviao_prefixo)
UNION
(select prefixo, modelo from aviao
where Hangar_Hangar_Numero_de_Identificacao IS NOT NULL);

-- 9 selecionar os tripulantes do voo 255 em que os nomes começam com a letra B
   select T.nome from tripulante as T, voo as V, possuem as P
   where  P.Voo_Numero_de_Voo = V.Numero_de_Voo and
	T.CPF = P.Tripulante_CPF and
    V.Numero_de_Voo = 255 and
    T.nome like 'B%';


-- 10 selecionar todos os aviões e os seus hangares, mostrando mesmo aqueles que não estão guardados	
	
    select prefixo,modelo,Hangar_Numero_de_Identificacao 
    from aviao left outer join hangar 
    on Hangar_Numero_de_Identificacao=Hangar_Hangar_Numero_de_Identificacao;

-- 11  selecionar todos os funcionários que possuem salário acima da média salarial
	SELECT Nome from funcionario inner join tripulante 
	on tripulante.cpf=Tripulante_CPF_Funcionario and funcionario.salario > ANY ( SELECT AVG(Salario) FROM FUNCIONARIO );

-- 12 selecionar um engenheiro que ganhe mais do que todos os pilotos
	select Nome,salario, CREA from funcionario, tripulante, engenheiro_de_voo
    where tripulante.CPF=funcionario.Tripulante_CPF_Funcionario and funcionario.Tripulante_CPF_Funcionario=engenheiro_de_voo.Funcionario_Tripulante_CPF
	and funcionario.salario > ALL (select MAX(funcionario.salario) from funcionario inner join piloto
									on funcionario.Tripulante_CPF_Funcionario=piloto.Funcionario_Tripulante_CPF);
                                    
-- 13 selecionar os  hangares que possuem avioes guardados
	select Hangar_Numero_de_Identificacao,localizacao from hangar
    where  exists (select * from aviao where aviao.Hangar_Hangar_Numero_de_Identificacao= hangar.Hangar_Numero_de_Identificacao);
-- selecionar quantos tripulantes possuem em cada voo

 -- g) exemplo de visões  
 
CREATE VIEW HORAS_VOOS AS
SELECT CPF, Nome,Horas_de_Voo
FROM Tripulante,Piloto
WHERE Tripulante.CPF=Funcionario_Tripulante_CPF
ORDER BY Horas_de_Voo DESC; 

-- visão sobre a hora de voo que cada piloto possui, podendo assim ter um ser ranking de experiência do piloto usando a seleção
-- Exemplo: -- Listar os 10 pilotos mais experiente da empresa

select  * from HORAS_VOOS
limit 5;


CREATE VIEW VOOS_INTERNACIONAIS AS
SELECT Numero_de_Voo, Prefixo, Modelo
FROM Voo, aviao
WHERE Tipo = 'I' AND Aviao.Prefixo=Aviao_Prefixo;

-- tabela de visão de voos internacaionais agrupada por aviao
-- Exemplo: agrupar avioes por modelo em voos internacionais

 select * from VOOS_INTERNACIONAIS
 group by modelo;


CREATE VIEW LISTA_TRIPULANTES AS
SELECT CPF, Nome ,Voo_Numero_de_Voo
FROM Tripulante,possuem
WHERE Tripulante.CPF=Possuem.Tripulante_CPF;

-- tabela que contem os tripulantes associados aos seus voos, podendo ser usada semelhante ao exemplo abaixo para obter a lista de determinado voo:
-- Exemplo lista de tripulantes do voo 255

select CPF, Nome
FROM lista_tripulantes
where Voo_Numero_de_Voo=255; 

-- i) criação de procedimentos 

delimiter $$

-- Verifica se a situação do aeroporto digitada está correta ou não

	IF (LENGTH(CPF) < 11) THEN
		SELECT 'CPF incorreto! Possui menos caracteres que o exigido' AS Msg;
	ELSE 
		SELECT 'CPF correto' AS Msg;
	end if;
END 

delimiter $$

-- Traduz o siginificado de cada situacao do hangar

CREATE PROCEDURE TipoSituacaoHargar (situacao ENUM ('L','M','O'))
BEGIN
	IF (situacao = 'L') THEN
		SELECT 'Livre/Disponível' As situacao;
	IF (situacao = 'M') THEN
		SELECT 'Em manutenção/Não disponível' As situacao;
	ELSE 
    SELECT 'Ocupado/Não disponível' as situacao; 
	END IF;
END;



delimiter $$

-- mostrar o ranking dos n funcionarios mais bem pagos

CREATE PROCEDURE SelecionarNMaisRicos(n int)
begin
	select Nome, Salario from tripulante,funcionario
	where tripulante.CPF=funcionario.Tripulante_CPF_Funcionario
	order by  salario desc
    limit n;
end

-- verficar se a situacao do aeroporto digitada é um situação válida

delimiter $$
CREATE PROCEDURE VerificarSituacaoAeroporto (situacao ENUM ('IFR', 'VFR', 'XXX'))
BEGIN
		while (situacao not in ('IFR', 'VFR', 'XXX')) then
        SELECT 'Situação inválida' As situacao;
    end while;
END
 delimiter $$

delimiter $$

-- Verifica se o CPF está correto ou não

CREATE PROCEDURE validarCPF (CPF BIGINT(20))
BEGIN
	IF (LENGTH(CPF) < 11) THEN
		SELECT 'CPF incorreto! Possui menos caracteres que o exigido' AS Msg;
	ELSE 
		SELECT 'CPF correto' AS Msg;
	end if;
END 

delimiter $$

-- Traduz o siginificado do tipo de Voo

CREATE PROCEDURE TipoVoo (Tipo ENUM ('N','I'))
BEGIN
	IF (Tipo = 'N') THEN
		SELECT 'Nacional' As tipo;
	ELSE 
		SELECT 'Internacional' AS tipo;
	END IF;
END;

delimiter $$

-- mostrar o ranking dos n funcionarios mais bem pagos

CREATE PROCEDURE SelecionarNMaisRicos(n int)
begin
	select Nome, Salario from tripulante,funcionario
	where tripulante.CPF=funcionario.Tripulante_CPF_Funcionario
	order by  salario desc
    limit n;
end
delimiter $$

-- j)  criação de novos triggers

DELIMITER $$
CREATE TRIGGER before_voo_insert
BEFORE INSERT ON Voo FOR EACH ROW
BEGIN
   DECLARE vNumVoos INT;
   DECLARE situacao_aero char(3);
   SELECT COUNT(Aviao_Prefixo)
   FROM Voo
   WHERE Prefixo = new.Aviao_Prefixo INTO vNumVoos;	
	
   IF (vNumVoos = 20) THEN
      SIGNAL SQLSTATE '45000' SET message_text = 'Avião necessita de manutenção, excesso de números de voos';
   END IF;
   
END;
$$ DELIMITER 

DELIMITER $$
CREATE TRIGGER before_aeroporto_update
BEFORE update ON aeroporto FOR EACH ROW
BEGIN
   IF (new.situação NOT IN ('VFR','IFR','XXX')) THEN
      SIGNAL SQLSTATE '45000' SET message_text = ' Situação inválida, insira IFR para instrumentos, VFR para visual, XXX para inoperante';
   END IF;
END;
$$ DELIMITER 

DELIMITER $$
CREATE TRIGGER after_tripulante_delete
after delete ON tripulante FOR EACH ROW
SIGNAL SQLSTATE '45000' SET message_text = 'Tripulante excluído com sucesso pois não está em nenhum voo';
$$ DELIMITER 

-- tabela usada para controlar as alterações das horas de voo dos pilotos.

create table auditoria_anac (
idAuditoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
CPF BIGINT,
Brevê INT,
Horas_voo int,
Horas_voo_novas int,
user VARCHAR(20) NOT NULL,
dataHora datetime NOT NULL
);


DELIMITER $$
create trigger after_update_horasvoo
after update on piloto
for each row
begin if
if new.Horas_de_Voo!=old.Horas_de_Voo then
insert into auditoria_anac
values (new.Funcionario_Tripulante_CPF, new.Brevê, old.Horas_de_Voo, new.Horas_de_Voo, ,user(), now());
end if
END DELIMITER $$


