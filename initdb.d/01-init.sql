DROP DATABASE IF EXISTS my_database;
CREATE DATABASE IF NOT EXISTS my_database;
USE my_database;


CREATE TABLE `teams` (
    `id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(50)
) ;
CREATE INDEX `idx` ON `teams`(`id`);

CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(50),
    `age` INT,
    `team_id` INT,
    `日本語カラム` VARCHAR(50) COMMENT '日本語のコメント',
    CONSTRAINT `fk_team_id` FOREIGN KEY(`team_id`) REFERENCES `teams`(`id`)
) COMMENT = 'ユーザーテーブル';
CREATE INDEX `idx1` ON `users`(`id`);
CREATE INDEX `idx2` ON `users`(`team_id`);

CREATE VIEW `my_view`(
    `user_id`,
    `user_name`,
    `user_age`,
    `team_name`
) AS
SELECT
    u.id,
    u.name,
    u.age,
    t.name
FROM
    `users` u
    INNER JOIN
        `teams` t
    ON  u.team_id = t.id
;
