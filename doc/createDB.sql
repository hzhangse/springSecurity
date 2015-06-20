drop database if exists springsecurity;

create database springsecurity;

use springsecurity;

create table users (
      username varchar(50) not null,
      password varchar(50) not null,
      enabled integer not null,
      name varchar(50) not null,
      manager_id varchar(50),
      salary DECIMAL,
      primary key (username),
      constraint fk_users_manager foreign key(manager_id) references users(username)
);


create table reports (
	  id bigint auto_increment NOT NULL primary key, 
	  title varchar(50) not null,
	  content Text 
);


create table authorities (
      username varchar(50) not null,
      authority varchar(50) not null,
      constraint fk_authorities_users foreign key(username) references users(username)
);



/**
 * 生成用户的 acl id
 */
CREATE TABLE acl_sid (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	principal BOOLEAN NOT NULL,
	sid VARCHAR(100) NOT NULL,
	UNIQUE KEY unique_acl_sid (sid, principal)
) ENGINE=InnoDB;

/**
 * 生成授权对象所属类的class id
 */
CREATE TABLE acl_class (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	class VARCHAR(100) NOT NULL,
	UNIQUE KEY uk_acl_class (class)
) ENGINE=InnoDB;


	
CREATE TABLE acl_object_identity (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	object_id_class BIGINT UNSIGNED NOT NULL,/* 授权对象所属类对应的id*/
	object_id_identity BIGINT NOT NULL, /* 授权对象表里对应的对象id，在这里指report表对应的id*/
	parent_object BIGINT UNSIGNED,
	owner_sid BIGINT UNSIGNED,          /* 授权对象owner id*/
	entries_inheriting BOOLEAN NOT NULL,
	UNIQUE KEY uk_acl_object_identity (object_id_class, object_id_identity),
	CONSTRAINT fk_acl_object_identity_parent FOREIGN KEY (parent_object) REFERENCES acl_object_identity (id),
	CONSTRAINT fk_acl_object_identity_class FOREIGN KEY (object_id_class) REFERENCES acl_class (id),
	CONSTRAINT fk_acl_object_identity_owner FOREIGN KEY (owner_sid) REFERENCES acl_sid (id)
) ENGINE=InnoDB;
	
	
CREATE TABLE acl_entry (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	acl_object_identity BIGINT UNSIGNED NOT NULL,
	ace_order INTEGER NOT NULL,
	sid BIGINT UNSIGNED NOT NULL,
	mask INTEGER UNSIGNED NOT NULL,
	granting BOOLEAN NOT NULL,
	audit_success BOOLEAN NOT NULL,
	audit_failure BOOLEAN NOT NULL,
	UNIQUE KEY unique_acl_entry (acl_object_identity, ace_order),
	CONSTRAINT fk_acl_entry_object FOREIGN KEY (acl_object_identity) REFERENCES acl_object_identity (id),
	CONSTRAINT fk_acl_entry_acl FOREIGN KEY (sid) REFERENCES acl_sid (id)
) ENGINE=InnoDB;


insert into users(username, password, enabled, name, salary) values ('hzhangse', 'hzhangse', 1, 'ZhangHong', 6000);
insert into users(username, password, enabled, name, salary, manager_id) values ('mary', 'mary', 1, 'Mary', 6000, 'hzhangse');
insert into users(username, password, enabled, name, salary, manager_id) values ('bob', 'bob', 1, 'Bob', 5500, 'mary');
insert into users(username, password, enabled, name, salary, manager_id) values ('alex', 'alex', 1, 'Alex', 5000, 'bob');
insert into users(username, password, enabled, name, salary, manager_id) values ('dale', 'dale', 1, 'Dale', 6000, 'bob');


insert into authorities(username, authority) values ('hzhangse', 'ROLE_MANAGER'); 
insert into authorities(username, authority) values ('hzhangse', 'ROLE_PRESIDENT'); 
insert into authorities(username, authority) values ('hzhangse', 'ROLE_USER'); 
insert into authorities(username, authority) values ('alex', 'ROLE_USER'); 
insert into authorities(username, authority) values ('bob', 'ROLE_USER'); 
insert into authorities(username, authority) values ('mary', 'ROLE_USER'); 
insert into authorities(username, authority) values ('bob', 'ROLE_MANAGER'); 
insert into authorities(username, authority) values ('mary', 'ROLE_MANAGER'); 
insert into authorities(username, authority) values ('mary', 'ROLE_PRESIDENT'); 
insert into authorities(username, authority) values ('dale', 'ROLE_USER'); 