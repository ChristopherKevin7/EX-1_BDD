--Quest�o 1
-- Tabela Ra�a
CREATE TABLE Ra�a (
    Ra�aID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descri��o VARCHAR(500),
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
    Caracter�sticas VARCHAR(1000),
	IDHabilidade INT NOT NULL,
	FOREIGN KEY (IDHabilidade) REFERENCES Habilidade(IDHabilidade)
);

-- Tabela Personagem
CREATE TABLE Personagem (
    PersonagemID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DateTime NOT NULL,
    Ra�aID INT NOT NULL,
    ClasseID INT NOT NULL,
	Descricao VARCHAR(500),
    FOREIGN KEY (Ra�aID) REFERENCES Ra�a(Ra�aID),
    FOREIGN KEY (ClasseID) REFERENCES Classe(ClasseID)
);

--Quest�o 2
ALTER TABLE Personagem
ADD Poder INT NOT NULL;


--Quest�o 3
ALTER TABLE Classe
ALTER COLUMN Caracter�sticas VARCHAR(500);

--Quest�o 4
ALTER TABLE Ra�a
DROP COLUMN Perdido;

--Quest�o 5
-- Inserir dados na tabela Ra�a
INSERT INTO Ra�a (Nome, Descri��o, Origem)
VALUES
    ('Dragarto', 'Ra�a vers�til e adapt�vel', 'Mundo Terra'),
    ('Elfo', 'Ra�a longeva e habilidosa', 'Floresta �lfica'),
    ('An�o', 'Ra�a robusta e mestre em metalurgia', 'Montanhas de Ferro');

-- Inserir dados na tabela Classe
INSERT INTO Classe (Nome, Caracter�sticas, IDHabilidade)
VALUES
    ('Guerreiro', 'Especializado em combate corpo a corpo', 1),
    ('Mago', 'Manipula magia poderosa', 2),
    ('Ladr�o', 'Mestre em furtividade e desarme de armadilhas', 3);

-- Inserir dados na tabela Personagem (observando as chaves estrangeiras)
INSERT INTO Personagem (Nome, DataNascimento, Ra�aID, ClasseID, Poder)
VALUES
    ('Legolas', '1985-11-24T18:05:01', 2, 4, 70),
    ('Gimli', '1990-08-03T15:30:00', 3, 3, 75),
	('Aragorn', '2004-05-23T14:25:10', 1, 3, 85);

SELECT * FROM Ra�a
SELECT * FROM Classe
SELECT * FROM Habilidade
SELECT * FROM Personagem

INSERT INTO Habilidade (Nome, MultiplicadorPoder) VALUES 
	('Berserker', 3),
	('Sharingan', 3),
	('Mugen', 3);

--Quest�o 6
UPDATE Classe
SET Caracter�sticas = 'Caracter�sticas Gerais'
WHERE Caracter�sticas IS NULL;

--Qust�o 7
DELETE FROM Personagem
WHERE YEAR(DataNascimento) BETWEEN 1970 AND 1990;

--Quest�o 8
SELECT * FROM Classe;

--Quest�o 9
SELECT Nome, DataNascimento, Poder
FROM Personagem
WHERE Poder BETWEEN 0 AND 75;

--Quest�o 10
SELECT Nome, Descri��o, Origem
FROM Ra�a
WHERE Nome LIKE '%Orc%';



--AC2

--Quest�o 1

SELECT COUNT(*) AS Quantidade_de_Habilidades
From Habilidade;

--Quest�o 2

SELECT Classe.Nome AS NomeDaClasse, COUNT(Personagem.ClasseID) AS QuantidadeDePersonagens
FROM Classe
LEFT JOIN Personagem ON Classe.ClasseID = Personagem.ClasseID
GROUP BY Classe.Nome;

--Quest�o 3

SELECT Ra�a.Nome AS NomeDaRa�a, COUNT(Personagem.Ra�aID) AS QuantidadeDePersonagens
FROM Ra�a
LEFT JOIN Personagem ON Ra�a.Ra�aID = Personagem.Ra�aID
GROUP BY Ra�a.Nome;

--Quest�o 4

INSERT INTO Ra�a (Nome, Descri��o, Origem)
VALUES
    ('Humano', 'Ra�a simples, sem vantagens e desvantagens fisicas', 'Mundo Terra');

INSERT INTO Personagem (Nome, DataNascimento, Ra�aID, ClasseID, Poder)
VALUES
    ('Reinhard', '1994-11-24T18:05:01', 4, 2, 150);

SELECT Classe.Nome AS NomeDaClasse, AVG(Personagem.Poder) AS ValorM�dioDePoder, SUM(Personagem.Poder) AS SomaDePoder
FROM Classe
INNER JOIN Personagem ON Classe.ClasseID = Personagem.ClasseID
GROUP BY Classe.Nome
HAVING AVG(Personagem.Poder) >= 100;

--Quest�o 5

SELECT
    P.Nome AS NomeDoPersonagem,
    P.DataNascimento,
    R.Nome AS NomeDaRa�a,
    C.Nome AS NomeDaClasse,
    H.Nome AS NomeDaHabilidade
FROM
    Personagem AS P
INNER JOIN
    Ra�a AS R ON P.Ra�aID = R.Ra�aID
INNER JOIN
    Classe AS C ON P.ClasseID = C.ClasseID
INNER JOIN
    Habilidade AS H ON C.IDHabilidade = H.IDHabilidade;


