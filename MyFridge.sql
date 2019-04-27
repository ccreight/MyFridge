DROP DATABASE IF EXISTS MyFridge;
CREATE DATABASE MyFridge;
USE MyFridge; 

CREATE TABLE Users (
	userID INT(11) PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL
);
INSERT INTO Users(username,password) VALUES
('root','root'),('admin','root');
CREATE TABLE Fridge(
    fridgeID INT(11) PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    fridgeObject BLOB NOT NULL,
    FOREIGN KEY (username) REFERENCES Users(username)
);
CREATE TABLE CustomRecipes(
    customRecipeID INT(11) PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    customRecipesObject BLOB NOT NULL,
    FOREIGN KEY (username) REFERENCES Users(username)
);      
CREATE TABLE BookmarkedRecipes(
    bookmarkedRecipeID INT(11) PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    bookmarkedRecipesObject BLOB NOT NULL,
    FOREIGN KEY (username) REFERENCES Users(username)
);