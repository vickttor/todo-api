CREATE TABLE IF NOT EXISTS todos (
  id TEXT NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  isCompleted BOOLEAN NOT NULL,
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO todos (id, name, isCompleted)
VALUES ('72a92b52-a1a1-4a5c-9fe6-a02f1e4384e8', 'Buy groceries', FALSE),
       ('a2c6ffe8-9210-4342-9ea1-6cf378c247d7', 'Finish report', FALSE),
       ('8b6638ad-24cd-44ec-bef6-670b3ec27839', 'Clean the house', TRUE);