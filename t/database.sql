--
-- Firewall::Parser Support Database
-- Written by Yanbin MA
--


-- Address Object and Address Group Object
DROP TABLE IF EXISTS `fp-address`;
CREATE TABLE `fp-address` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `STRING`    varchar(255) not null,
    `VALUE`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fp-address_group`;
CREATE TABLE `fp-address_group` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `STRING`    varchar(255) not null,
    `VALUE`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


-- Service Object and Service Group Object
DROP TABLE IF EXISTS `fp-service`;
CREATE TABLE `fp-service` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `STRING`    varchar(255) not null,
    `VALUE`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fp-service_group`;
CREATE TABLE `fp-service_group` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `STRING`    varchar(255) not null,
    `VALUE`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


-- Schedule Object
DROP TABLE IF EXISTS `fp-schedule`;
CREATE TABLE `fp-schedule` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `STRING`    varchar(255) not null,
    `VALUE`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


-- Interface Object
DROP TABLE IF EXISTS `fp-interface`;
CREATE TABLE `fp-interface` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `STRING`    varchar(255) not null,
    `VALUE`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


-- Policy Object
DROP TABLE IF EXISTS `fp-policy`;
CREATE TABLE `fp-policy` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `ACTION`    varchar(255) not null,
    `SRC_IF`    varchar(255),
    `DST_IF`    varchar(255),
    `SRC_IP`    varchar(255),
    `DST_IP`    varchar(255),
    `SERVICE`   varchar(255),
    `SCHEDULE`  varchar(255),
    `STATUS`    varchar(255),
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fp-policy_group`;
CREATE TABLE `fp-policy_group` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `STRING`    varchar(255) not null,
    `VALUE`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

