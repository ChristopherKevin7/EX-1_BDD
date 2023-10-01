--Questão 1
-- Tabela Raça
CREATE TABLE Raça (
    RaçaID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descrição VARCHAR(500),
    Origem VARCHAR(150) NOT NULL,
	Perdido DateTime
);

--Tabela Habilidade
CREATE TABLE Habilidade(
	IDHabilidade INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nome VARCHAR(200) NOT NULL,
	MultiplicadorPoder INT
);

-- Tabela Classe
CREATE TABLE Classe (
    ClasseID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Características VARCHAR(1000),
	IDHabilidade INT NOT NULL,
	FOREIGN KEY (IDHabilidade) REFERENCES Habilidade(IDHabilidade)
);

-- Tabela Personagem
CREATE TABLE Personagem (
    PersonagemID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DateTime NOT NULL,
    RaçaID INT NOT NULL,
    ClasseID INT NOT NULL,
	Descricao VARCHAR(500),
    FOREIGN KEY (RaçaID) REFERENCES Raça(RaçaID),
    FOREIGN KEY (ClasseID) REFERENCES Classe(ClasseID)
);

--Questão 2
ALTER TABLE Personagem
ADD Poder INT NOT NULL;


--Questão 3
ALTER TABLE Classe
ALTER COLUMN Características VARCHAR(500);

--Questão 4
ALTER TABLE Raça
DROP COLUMN Perdido;

--Questão 5
-- Inserir dados na tabela Raça
INSERT INTO Raça (Nome, Descrição, Origem)
VALUES
    ('Dragarto', 'Raça versátil e adaptável', 'Mundo Terra'),
    ('Elfo', 'Raça longeva e habilidosa', 'Floresta Élfica'),
    ('Anão', 'Raça robusta e mestre em metalurgia', 'Montanhas de Ferro');

-- Inserir dados na tabela Classe
INSERT INTO Classe (Nome, Características, IDHabilidade)
VALUES
    ('Guerreiro', 'Especializado em combate corpo a corpo', 1),
    ('Mago', 'Manipula magia poderosa', 2),
    ('Ladrão', 'Mestre em furtividade e desarme de armadilhas', 3);

-- Inserir dados na tabela Personagem (observando as chaves estrangeiras)
INSERT INTO Personagem (Nome, DataNascimento, RaçaID, ClasseID, Poder)
VALUES
    ('Legolas', '1985-11-24T18:05:01', 2, 4, 70),
    ('Gimli', '1990-08-03T15:30:00', 3, 3, 75),
	('Aragorn', '2004-05-23T14:25:10', 1, 3, 85);

SELECT * FROM Raça
SELECT * FROM Classe
SELECT * FROM Habilidade
SELECT * FROM Personagem

INSERT INTO Habilidade (Nome, MultiplicadorPoder) VALUES 
	('Berserker', 3),
	('Sharingan', 3),
	('Mugen', 3);

--Questão 6
UPDATE Classe
SET Características = 'Características Gerais'
WHERE Características IS NULL;

--Qustão 7
DELETE FROM Personagem
WHERE YEAR(DataNascimento) BETWEEN 1970 AND 1990;

--Questão 8
SELECT * FROM Classe;

--Questão 9
SELECT Nome, DataNascimento, Poder
FROM Personagem
WHERE Poder BETWEEN 0 AND 75;

--Questão 10
SELECT Nome, Descrição, Origem
FROM Raça
WHERE Nome LIKE '%Orc%';



--AC2

--Questão 1

SELECT COUNT(*) AS Quantidade_de_Habilidades
From Habilidade;

--Questão 2

SELECT Classe.Nome AS NomeDaClasse, COUNT(Personagem.ClasseID) AS QuantidadeDePersonagens
FROM Classe
LEFT JOIN Personagem ON Classe.ClasseID = Personagem.ClasseID
GROUP BY Classe.Nome;

--Questão 3

SELECT Raça.Nome AS NomeDaRaça, COUNT(Personagem.RaçaID) AS QuantidadeDePersonagens
FROM Raça
LEFT JOIN Personagem ON Raça.RaçaID = Personagem.RaçaID
GROUP BY Raça.Nome;

--Questão 4

INSERT INTO Raça (Nome, Descrição, Origem)
VALUES
    ('Humano', 'Raça simples, sem vantagens e desvantagens fisicas', 'Mundo Terra');

INSERT INTO Personagem (Nome, DataNascimento, RaçaID, ClasseID, Poder)
VALUES
    ('Reinhard', '1994-11-24T18:05:01', 4, 2, 150);

SELECT Classe.Nome AS NomeDaClasse, AVG(Personagem.Poder) AS ValorMédioDePoder, SUM(Personagem.Poder) AS SomaDePoder
FROM Classe
INNER JOIN Personagem ON Classe.ClasseID = Personagem.ClasseID
GROUP BY Classe.Nome
HAVING AVG(Personagem.Poder) >= 100;

--Questão 5

SELECT
    P.Nome AS NomeDoPersonagem,
    P.DataNascimento,
    R.Nome AS NomeDaRaça,
    C.Nome AS NomeDaClasse,
    H.Nome AS NomeDaHabilidade
FROM
    Personagem AS P
INNER JOIN
    Raça AS R ON P.RaçaID = R.RaçaID
INNER JOIN
    Classe AS C ON P.ClasseID = C.ClasseID
INNER JOIN
    Habilidade AS H ON C.IDHabilidade = H.IDHabilidade;


