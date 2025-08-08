create database sistema_agendamentos;

use sistema_agendamentos;

create table usuarios (
    codusu int not null auto_increment,
    nome varchar(100) not null,
    senha varchar(255) not null,
    tipo_acesso enum('admin', 'empresa', 'cliente') not null,
    primary key (codusu)
);

create table empresas (
    codEmp int not null auto_increment,
    nome varchar(150) not null,
    cnpj varchar(18) unique not null,
    email varchar(100) not null,
    telefone varchar(20),
    endereco varchar(255),
    logo LONGBLOB,
    codusu int not null,
    primary key(codEmp),
    foreign key (codusu) references usuarios(codusu)
);

create table clientes (
    codCli int not null auto_increment,
    nome varchar(100) not null,
    email varchar(100) not null,
    telefone varchar(20),
    cpf varchar(14) unique not null,
    endereco varchar(255),
    data_nascimento date,
    codusu int not null,
    primary key(codCli)
    foreign key (codusu) references usuarios(codusu)
);

create table servicos (
    codSer int not null auto_increment,
    nome varchar(150) not null,
    valor decimal(10,2) not null,
    descricao text,
    avaliacao decimal(3,2) default 0,
    foto LONGBLOB,
    codEmp int not null,
    primary key(codSer),
    foreign key (codEmp) references empresas(codEmp)
);

create table pagamentos (
    codPag int not null auto_increment,
    metodo varchar(50) not null,
    codCli int not null,
    valor_total decimal(10,2) not null,
    primary key(codPag),
    foreign key (codCli) references clientes(codCli)
);

create table agendamentos (
    codAge int not null auto_increment,
    servico int not null,
    data date not null,
    horario time not null,
    codCli int not null,
    codSer int not null,
    endereco VARCHAR(255) ,
    codPag int,
    primary key(codAge),
    foreign key (codSer) references servicos(codSer),
    foreign key (codCli) references clientes(codCli),
    foreign key (codPag) references pagamentos(codPag)
);