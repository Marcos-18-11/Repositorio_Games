create dATABASE VIDEOGAME;
USE VIDEOGAME;

CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
name TEXT NOT NULL,
email TEXT NOT NULL,
nick TEXT NOT NULL,
login TEXT NOT NULL,
password TEXT NOT NULL,
birthdate date
);
CREATE TABLE avatars (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    game_id INT,
    appearance TEXT, -- Assuming appearance is stored as text
    level INT DEFAULT 1, -- Default level for new avatars
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, 
    FOREIGN KEY (game_id) REFERENCES games(id)
);

CREATE TABLE games (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(20) UNIQUE NOT NULL, -- Unique game code
    name VARCHAR(50) NOT NULL,
    description TEXT,
    rules TEXT
);


CREATE TABLE matches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT,
    name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Record creation time
    password VARCHAR(255), -- Optional password for private matches
    status ENUM('pending', 'in_progress', 'finished') DEFAULT 'pending', 
    creator_avatar_id INT,
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (creator_avatar_id) REFERENCES avatars(id)
);

CREATE TABLE match_participants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT,
    avatar_id INT,
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    FOREIGN KEY (avatar_id) REFERENCES avatars(id)
);

CREATE TABLE confrontations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT,
    avatar1_id INT,
    avatar2_id INT,
    result ENUM('win', 'loss', 'draw'),
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    FOREIGN KEY (avatar1_id) REFERENCES avatars(id),
    FOREIGN KEY (avatar2_id) REFERENCES avatars(id)
);

 
