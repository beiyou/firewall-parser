--
-- Firewall::Parser Support Database
-- Written by Yanbin MA
--


-- Address Object and Address Group Object
DROP TABLE IF EXISTS `fp-address`;
CREATE TABLE `fp-address` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `string`    varchar(255) not null,
    `value`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fp-address_group`;
CREATE TABLE `fp-address_group` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `string`    varchar(255) not null,
    `value`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


-- Service Object and Service Group Object
DROP TABLE IF EXISTS `fp-service`;
CREATE TABLE `fp-service` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `string`    varchar(255) not null,
    `value`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fp-service_group`;
CREATE TABLE `fp-service_group` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `string`    varchar(255) not null,
    `value`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


-- Schedule Object
DROP TABLE IF EXISTS `fp-schedule`;
CREATE TABLE `fp-schedule` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `string`    varchar(255) not null,
    `value`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


-- Interface Object
DROP TABLE IF EXISTS `fp-interface`;
CREATE TABLE `fp-interface` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `string`    varchar(255) not null,
    `value`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


-- Policy Object
DROP TABLE IF EXISTS `fp-policy`;
CREATE TABLE `fp-policy` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `action`    varchar(255) not null,
    `src_if`    varchar(255),
    `dst_if`    varchar(255),
    `src_ip`    varchar(255),
    `dst_ip`    varchar(255),
    `service`   varchar(255),
    `schedule`  varchar(255),
    `status`    varchar(255),
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fp-policy_group`;
CREATE TABLE `fp-policy_group` (
    `id`        int(10) unsigned not null auto_increment,
    `tid`       int(10) unsigned not null,
    `string`    varchar(255) not null,
    `value`     text,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

