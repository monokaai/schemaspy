\c my_database;

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    team_id INT,
    "日本語カラム" VARCHAR(50),
    CONSTRAINT fk_team_id FOREIGN KEY(team_id) REFERENCES teams(id)
);

CREATE INDEX idx1 ON users(id);
CREATE INDEX idx2 ON users(team_id);

CREATE VIEW my_view AS
SELECT
    u.id AS user_id,
    u.name AS user_name,
    u.age AS user_age,
    t.name AS team_name
FROM
    users u
    INNER JOIN teams t ON u.team_id = t.id;

COMMENT ON TABLE users IS 'ユーザーテーブル';
COMMENT ON COLUMN users."日本語カラム" IS '日本語のコメント';