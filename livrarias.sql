CREATE DATABASE livrarias_db;
USE livrarias_db;

CREATE TABLE editora (
  Nome varchar(100) NOT NULL,
  CNPJ varchar(16) NOT NULL,
  PRIMARY KEY (CNPJ)
);

CREATE TABLE cliente (
  Nome varchar(100) NOT NULL,
  Sobrenome varchar(100) NOT NULL,
  CPF varchar(11) NOT NULL,
  Sexo char(1) NULL,
  PRIMARY KEY (CPF)
);

CREATE TABLE loja (
  CNPJ varchar(16) NOT NULL,
  Quantidade_funcionarios int NOT NULL,
  PRIMARY KEY (CNPJ)
);

CREATE TABLE funcionario (
  Nome varchar(100) NOT NULL,
  Sobrenome varchar(100) NOT NULL,
  CPF varchar(11) NOT NULL,
  CNPJ_loja varchar(16) NOT NULL,
  Sexo char(1) NOT NULL,
  PRIMARY KEY (CPF),
  KEY funcionario_FK (CNPJ_loja),
  CONSTRAINT funcionario_FK FOREIGN KEY (CNPJ_loja) REFERENCES loja (CNPJ) ON UPDATE CASCADE
);

CREATE TABLE livro (
  ISBN int NOT NULL,
  Nome varchar(100) NOT NULL,
  Autor varchar(100) NOT NULL,
  Genero varchar(100) NOT NULL,
  Editora varchar(16) NOT NULL,
  preco decimal(10,0) NOT NULL,
  Quantidade_estoque int NOT NULL,
  PRIMARY KEY (ISBN),
  KEY livro_FK (Editora),
  CONSTRAINT livro_FK FOREIGN KEY (Editora) REFERENCES editora (CNPJ) ON UPDATE CASCADE
);

CREATE TABLE cliente_telefone (
  Codigo int NOT NULL AUTO_INCREMENT,
  Telefone varchar(12) NOT NULL,
  CPF_cliente varchar(11) NOT NULL,
  PRIMARY KEY (Codigo),
  UNIQUE KEY cliente_telefone_un (Telefone),
  KEY Cliente_telefone_FK (CPF_cliente),
  CONSTRAINT Cliente_telefone_FK FOREIGN KEY (CPF_cliente) REFERENCES cliente (CPF) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE editora_endereco (
  Rua varchar(100) NOT NULL,
  Bairro varchar(100) NOT NULL,
  Cidade varchar(100) NOT NULL,
  Estado varchar(100) NOT NULL,
  CEP varchar(100) DEFAULT NULL,
  CNPJ_editora varchar(16) NOT NULL,
  Codigo int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (Codigo),
  KEY Editora_endereco_FK (CNPJ_editora),
  CONSTRAINT Editora_endereco_FK FOREIGN KEY (CNPJ_editora) REFERENCES editora (CNPJ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE editora_telefone (
  Codigo int NOT NULL AUTO_INCREMENT,
  Telefone varchar(12) NOT NULL,
  CNPJ_editora varchar(16) NOT NULL,
  PRIMARY KEY (Codigo),
  UNIQUE KEY editora_telefone_un (Telefone),
  KEY editora_telefone_FK (CNPJ_editora),
  CONSTRAINT editora_telefone_FK FOREIGN KEY (CNPJ_editora) REFERENCES editora (CNPJ) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE editora_loja (
  CNPJ_editora varchar(16) NOT NULL,
  CNPJ_loja varchar(16) NOT NULL,
  PRIMARY KEY (CNPJ_editora,CNPJ_loja),
  KEY editora_loja_FK (CNPJ_loja),
  CONSTRAINT editora_loja_FK FOREIGN KEY (CNPJ_loja) REFERENCES loja (CNPJ) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT editora_loja_FK_1 FOREIGN KEY (CNPJ_editora) REFERENCES editora (CNPJ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE funcionario_endereco (
  Rua varchar(100) NOT NULL,
  Bairro varchar(100) NOT NULL,
  Cidade varchar(100) NOT NULL,
  Estado varchar(100) NOT NULL,
  CEP varchar(100) DEFAULT NULL,
  CPF_funcionario varchar(11) NOT NULL,
  Codigo int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (Codigo),
  KEY Funcionario_endereco_FK (CPF_funcionario),
  CONSTRAINT Funcionario_endereco_FK FOREIGN KEY (CPF_funcionario) REFERENCES funcionario (CPF) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE funcionario_telefone (
  Codigo int NOT NULL AUTO_INCREMENT,
  Telefone varchar(12) NOT NULL,
  CPF_funcionario varchar(11) NOT NULL,
  PRIMARY KEY (Codigo),
  UNIQUE KEY funcionario_telefone_un (Telefone),
  KEY Funcionario_telefone_FK (CPF_funcionario),
  CONSTRAINT Funcionario_telefone_FK FOREIGN KEY (CPF_funcionario) REFERENCES funcionario (CPF) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE livro_cliente_venda (
  ISBN_livro int NOT NULL,
  CPF_cliente varchar(11) NOT NULL,
  codigo int NOT NULL AUTO_INCREMENT,
  Quantidade_livros_comprados int NOT NULL,
  data_compra datetime NOT NULL,
  PRIMARY KEY (codigo),
  KEY livro_cliente_venda_FK (CPF_cliente),
  KEY livro_cliente_venda_FK_1 (ISBN_livro),
  CONSTRAINT livro_cliente_venda_FK FOREIGN KEY (CPF_cliente) REFERENCES cliente (CPF) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT livro_cliente_venda_FK_1 FOREIGN KEY (ISBN_livro) REFERENCES livro (ISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE livro_loja (
  CNPJ_loja varchar(16) NOT NULL,
  ISBN_livro int NOT NULL,
  PRIMARY KEY (CNPJ_loja,ISBN_livro),
  KEY livro_loja_FK_1 (ISBN_livro),
  CONSTRAINT livro_loja_FK FOREIGN KEY (CNPJ_loja) REFERENCES loja (CNPJ) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT livro_loja_FK_1 FOREIGN KEY (ISBN_livro) REFERENCES livro (ISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE loja_endereco (
  Rua varchar(100) NOT NULL,
  Bairro varchar(100) NOT NULL,
  Cidade varchar(100) NOT NULL,
  Estado varchar(100) NOT NULL,
  CEP varchar(100) DEFAULT NULL,
  CNPJ_loja varchar(16) NOT NULL,
  Codigo int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (Codigo),
  KEY Loja_endereco_FK (CNPJ_loja),
  CONSTRAINT Loja_endereco_FK FOREIGN KEY (CNPJ_loja) REFERENCES loja (CNPJ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE loja_telefone (
  Codigo int NOT NULL AUTO_INCREMENT,
  Telefone varchar(12) NOT NULL,
  CNPJ_loja varchar(16) NOT NULL,
  PRIMARY KEY (Codigo),
  UNIQUE KEY loja_telefone_un (Telefone),
  KEY loja_telefone_FK (CNPJ_loja),
  CONSTRAINT loja_telefone_FK FOREIGN KEY (CNPJ_loja) REFERENCES loja (CNPJ) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO livrarias_db.editora
(Nome, CNPJ)
values
('Suma de Letras', '95107611000140'),
('DarkSide', '13145534000158'),
('Arqueiro', '66113356000140'),
('Aleph', '47452466000191'),
('Companhia das letras', '23885335000130'),
('Alfaguara', '75243240000116'),
('Rocco', '17238775000100');

INSERT INTO livrarias_db.editora_endereco
(Rua, Bairro, Cidade, Estado, CEP, CNPJ_editora)
values
('Rua 4', 'Capibaribe', 'São Lourenço', 'PE', '85252520', '95107611000140'),
('Rua Machado', 'Penedo', 'Paulista', 'MA', '52525520', '13145534000158'),
('Rua Jansem', 'Pixete', 'Recife', 'SE', '52752000', '66113356000140'),
('Av. Ribeiro', 'Capibaribe', 'Recife', 'AL', '57275200', '47452466000191'),
('Rua Tito', 'Capibaribe', 'São Lourenço', 'PI', '57272410', '23885335000130'),
('Rua Lopes', 'Pendo', 'São Lourenço', 'BA', '75452220', '75243240000116'),
('Rua das Andorinhas', 'Muribara', 'Olinda', 'PE', '75275275', '17238775000100');

INSERT INTO livrarias_db.editora_telefone
(Telefone, CNPJ_editora)
values
('081995033539', '95107611000140'),
('081995033537', '95107611000140'),
('081995033538', '95107611000140'),
('081995453538', '66113356000140'),
('081991233538', '17238775000100'),
('081995087538', '17238775000100'),
('081997453538', '23885335000130'),
('081912033538', '23885335000130'),
('081995031338', '66113356000140'),
('081995039856', '66113356000140');

INSERT INTO livrarias_db.loja
(CNPJ, Quantidade_funcionarios)
values
('96585651000160', 50),
('02334519000131', 70),
('69178088000132', 25),
('49281144000152', 10),
('77036994000120', 87);

INSERT INTO livrarias_db.loja_endereco
(Rua, Bairro, Cidade, Estado, CEP, CNPJ_loja)
values
('Rua 45', 'Santo Amaro', 'Recife', 'PE', '54705286', '96585651000160'),
('Rua Alvaro', 'Rio Doce', 'Olinda', 'PE', '54705286', '02334519000131'),
('Rua treze de maio', 'Piedade', 'jaboatão', 'PE', '54705456', '69178088000132'),
('Rua das calçadas', 'Pau Amarelo', 'Paulista', 'PE', '54702566', '49281144000152'),
('Rua Machado de Assis', 'Capibaribe', 'São Lourenço', 'PE', '54789486', '77036994000120');

INSERT INTO livrarias_db.loja_telefone
(Telefone, CNPJ_loja)
values
('081995784521', '96585651000160'),
('081995012310', '96585651000160'),
('081995035646', '96585651000160'),
('081995231538', '77036994000120'),
('081995074538', '77036994000120'),
('081995033313', '69178088000132'),
('081995212148', '69178088000132'),
('081995078758', '02334519000131'),
('081995212128', '49281144000152'),
('081995787568', '49281144000152');

INSERT INTO livrarias_db.editora_loja
(CNPJ_editora, CNPJ_loja)
values
('95107611000140', '77036994000120'),
('23885335000130', '77036994000120'),
('95107611000140', '49281144000152'),
('23885335000130', '49281144000152'),
('95107611000140', '69178088000132'),
('23885335000130', '69178088000132'),
('95107611000140', '02334519000131'),
('23885335000130', '02334519000131');


INSERT INTO livrarias_db.livro
(ISBN, Nome, Autor, Genero, Editora, preco, Quantidade_estoque)
values
('8756123145621', 'O Simbolo perdido', 'Dan Brown', 'Ficção', '66113356000140', 10.6, 150),
('5649944936325', 'It: the thing', 'Stephen King', 'Terror', '95107611000140', 70.0, 410),
('5689789963582', 'Origem', 'Dan Brown', 'Ficção', '66113356000140', 80.0, 540),
('1245656498464', 'O Instituto', 'Stephen King', 'Terror', '95107611000140', 45.0, 2120),
('5644295639852', 'Duna', 'Frank Herbert', 'Ficção-científica', '47452466000191', 50.0, 480),
('5649821345693', 'Harry Potter', 'J. K. Rowling', 'Fantasia', '17238775000100', 20.0, 50),
('5649845012456', 'Inferno', 'Dan Brown', 'Ficção', '66113356000140', 30.0, 540),
('4564987496325', 'O Código da vinci', 'Dan Brown', 'Ficção', '66113356000140', 59.0, 60),
('5649810496587', 'Anjos e Demônios', 'Dan Brown', 'Ficção', '66113356000140', 59.0, 80),
('5649825045123', 'Ponto de impacto', 'Dan Brown', 'Ficção', '66113356000140', 59.0, 550),
('5649871146133', 'Fortaleza Digital', 'Dan Brown', 'Ficção', '66113356000140', 59.0, 2350),
('8978978912458', 'O homem de areia', 'Lars Kepler', 'Suspense', '75243240000116', 47.0, 540);

INSERT INTO livrarias_db.livro_loja
(CNPJ_loja, ISBN_livro)
values
('96585651000160', '8756123145621'),
('49281144000152', '8756123145621'),
('77036994000120', '5644295639852'),
('77036994000120', '5649825045123'),
('69178088000132', '8978978912458'),
('49281144000152', '5689789963582');

INSERT INTO livrarias_db.cliente
(Nome, Sobrenome, CPF, Sexo)
values
('Fernanda', 'Fernandes', '33331855472', 'F'),
('Ana', 'Ana', '71944271414', 'F'),
('Julio', 'Cesar', '49477261483', 'M'),
('Nara', 'Ribeiro', '77428599474', 'F'),
('Thamires', 'Oliveira', '89367977433', 'F'),
('Jean', 'Grijp', '09841449439', 'M'),
('Pedro', 'Barbosa', '19878718476', 'M'),
('Ana', 'Oliveira', '16864093468', 'F');

INSERT INTO livrarias_db.cliente 
(`Nome`,`Sobrenome`,`CPF`,`Sexo`) 
VALUES ("Edward","Mcleod",60707920598,"M"),("Zahir","Gonzalez",72658096415,"M"),("Kennedy","Cox",94887328545,"M"),("Dillon","Blake",40061260192,"F"),("Derek","Reynolds",25104963846,"M"),("Stewart","Curry",98539666549,"F"),("Erich","Landry",27159865840,"F"),("Declan","Collins",18447975294,"F"),("Grady","Browning",32576320476,"M"),("Boris","Roy",81788657539,"F"),("Nehru","Giles",23192642089,"M"),("Carter","Pennington",68686117768,"M"),("Lionel","Boone",68828537157,"M"),("Fletcher","Marquez",99207967518,"F"),("Dominic","Hurley",43748976772,"F"),("Drake","Sharpe",21391399242,"F"),("Yasir","Gentry",24109948427,"F"),("Clark","Garrett",81509776938,"F"),("Cooper","Hickman",34168045734,"F"),("Zachary","Preston",14900614096,"M"),("Tobias","Coffey",48054247809,"F"),("Coby","Patrick",11817453865,"F"),("Thaddeus","Miranda",33074565817,"F"),("Aidan","Newman",23296895584,"F"),("Tyler","Nunez",87564032202,"F"),("Gavin","Hampton",54888328292,"M"),("Mohammad","Moran",60941440934,"M"),("Ronan","Camacho",76187357976,"M"),("Jermaine","Acosta",94945108975,"M"),("Ferris","Goodwin",61876908973,"M"),("Mark","Meyer",66417997413,"F"),("Owen","Hester",24846161579,"F"),("Theodore","Guthrie",31372464800,"M"),("Harlan","Hodges",40228984829,"F"),("Len","Nixon",95196697761,"M"),("Ahmed","Herring",82138602086,"M"),("Amos","Moore",61906956824,"F"),("Colby","Serrano",72736392466,"M"),("Julian","Jennings",98731697417,"F"),("Rashad","Branch",81537503960,"M"),("Elmo","Velez",78595462244,"M"),("Quentin","Wilson",66158247034,"M"),("Kibo","Moreno",18024605275,"F"),("Hop","Rivers",20585207538,"F"),("Dalton","Sandoval",45830322025,"M"),("Felix","Monroe",68074197484,"F"),("Elijah","Higgins",72503168343,"M"),("Samuel","Strickland",65414668075,"F"),("John","Leonard",91069579366,"F"),("Cooper","Kemp",73263615047,"F"),("Lucian","Munoz",39021158433,"M"),("Hakeem","Rosario",10753752048,"F"),("Hoyt","Duffy",64135540833,"M"),("Malik","Buck",86902205629,"F"),("Ronan","Sharpe",62612261383,"F"),("Abdul","Estrada",28446673226,"F"),("Mohammad","Woodard",30503521318,"F"),("Colton","Ray",11072072505,"F"),("Melvin","Maldonado",51548986353,"M"),("Ciaran","Battle",12141154916,"M"),("Chancellor","Wynn",48213426555,"M"),("Todd","Hurst",83022825961,"M"),("Jeremy","Wilder",14017757352,"M"),("Bruno","Robertson",17558674175,"M"),("Leonard","Freeman",23800428140,"F"),("Graham","Palmer",61979801494,"F"),("Honorato","Gonzalez",76525490202,"F"),("Amir","Norton",67072166826,"M"),("Marsden","Wilson",55901545273,"M"),("Thor","Kirby",41200220398,"F"),("Kibo","Watkins",11660000499,"M"),("Orlando","David",91170148543,"F"),("Mason","Mcdaniel",86157762069,"F"),("Jin","Trujillo",70920479494,"F"),("Lionel","Patel",11448029423,"F"),("Thane","Patton",67860937682,"F"),("Ryan","Cardenas",12571495513,"M"),("Igor","Freeman",42597791611,"F"),("Igor","Calderon",67879128674,"M"),("George","Larsen",94303920852,"F"),("Kaseem","Yates",68878251859,"M"),("Cairo","Booker",14885878756,"M"),("Emmanuel","Mcconnell",86192979560,"F"),("Uriel","Carpenter",45108600157,"F"),("Lance","Bennett",78063582876,"F"),("Sylvester","Newman",83217413400,"F"),("Aaron","Brennan",72414772608,"M"),("Cullen","Velazquez",70460945532,"M"),("Jameson","Tyson",67287980105,"F"),("Kasimir","Parker",87686351958,"M"),("Moses","Martinez",35516808028,"M"),("Elton","Dixon",78928864668,"F"),("Dane","Garrison",87929987377,"M"),("Dylan","Johns",83741789587,"F"),("Driscoll","Garner",29998243236,"F"),("Daquan","Silva",48748361726,"M"),("Deacon","Britt",54007329422,"M"),("Harper","Hinton",59335953830,"F"),("Cadman","Simon",44517672330,"F"),("Malachi","Ray",31911023821,"F");


INSERT INTO livrarias_db.cliente_telefone
(Telefone, CPF_cliente)
values
('081995033538', '09841449439'),
('081999632338', '09841449439'),
('081948783538', '16864093468'),
('081995039688', '19878718476'),
('081999842538', '89367977433'),
('081995037438', '77428599474'),
('081995789138', '71944271414'),
('081995000008', '33331855472');

INSERT INTO livrarias_db.livro_cliente_venda
(ISBN_livro, CPF_cliente, Quantidade_livros_comprados, data_compra)
values
('8756123145621', '09841449439', 100, '2011-10-07 15:40:00'),
('8756123145621', '16864093468', 20, '2018-02-08 11:40:00'),
('8756123145621', '77428599474', 400, '2019-05-09 19:48:00'),
('8978978912458', '16864093468', 30, '2021-06-04 18:14:00'),
('8978978912458', '77428599474', 1, '2020-08-03 17:26:00'),
('5689789963582', '89367977433', 2, '2018-07-03 14:12:00'),
('5689789963582', '09841449439', 3, '2017-09-07 12:42:00'),
('5689789963582', '89367977433', 9, '2018-08-03 11:42:00'),
('5649825045123', '89367977433', 1, '2016-07-03 15:58:00'),
('5649825045123', '09841449439', 100, '2015-12-03 11:14:00'),
('5649825045123', '77428599474', 100, '2014-12-03 12:03:00'),
('5649825045123', '16864093468', 100, '2013-12-03 19:09:00');


select * from cliente
where Nome = "ana";

select * from livro_cliente_venda
where data_compra > '2016-07-03' and data_compra < '2019-05-10';

select CPF_cliente, data_compra from livro_cliente_venda
where Quantidade_livros_comprados > 10;

select Nome from livro
where Quantidade_estoque > 500;

select Nome, CPF from cliente
where Sexo = 'F';

select ISBN_livro from livro_cliente_venda
where CPF_cliente = '09841449439';

select CPF_cliente from livro_cliente_venda
where 
data_compra between '2016-07-03' and '2018-01-01';

select * from cliente
where CPF in ('09841449439', '77428599474', '16864093468', '89367977433');

delete from cliente
where CPF between '50000000000' and '60000000000';

update cliente set
Sobrenome = 'Gomes'
where CPF = '09841449439';

select * from cliente
where cpf = '09841449439';

select Telefone from cliente_telefone, livro_cliente_venda
where livro_cliente_venda.data_compra between '2016-07-03' and '2018-01-01';

select livro.ISBN, livro.Nome as livro_nome, cliente.Nome as cliente_nome
from livro, cliente, livro_cliente_venda
where livro_cliente_venda.data_compra between '2016-07-03' and '2018-01-01';

delete cliente_telefone.Telefone from cliente_telefone, livro_cliente_venda
where livro_cliente_venda.data_compra = '2016-07-03';

update livro set livro.preco = round(rand()*100, 2);


