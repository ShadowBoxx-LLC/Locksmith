# Locksmith
A simple authorized_keys management system for Linux, written in Lapis!

## Installation and Configuration

### OpenResty and Lapis Installation

1. **Install OpenResty**
   - Follow the installation instructions on the [OpenResty website](https://openresty.org/en/installation.html).

2. **Install Lapis**
   - Use LuaRocks to install Lapis and bcrypt:
     ```bash
     luarocks install lapis
     ```

     ```bash
     luarocks install bcrypt
     ```

### MySQL Database Setup

1. **Install MySQL**
   - Follow your operating system's standard installation procedure to install MySQL.

2. **Create Database**
   - Log into MySQL:
     ```bash
     mysql -u root -p
     ```
   - Create a new database for the application and make it active:
     ```sql
     CREATE DATABASE locksmith;
     USE locksmith;
     ```
   - Create table user_keys:
     ```sql
     CREATE TABLE user_keys (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(255),
       pubkey TEXT,
       INDEX(username)
     );
     ```
   - Create table api_creds:
     ```sql
     CREATE TABLE api_creds (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(255) UNIQUE NOT NULL,
       token TEXT,
       INDEX(username)
     );
     ```
   - Create table auth_users:
     ```sql
     CREATE TABLE auth_users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(255) UNIQUE NOT NULL,
       password_hash VARCHAR(255) NOT NULL,
       INDEX(username)
     );
     ```
   
### Configuration File Setup

1. **Edit `config.lua` for MySQL**
   - Modify the `config.lua` file in your Lapis project to configure MySQL settings:
     ```lua
     local config = require("lapis.config")

     config("development", {
       mysql = {
         host = "127.0.0.1",
         user = "root",
         password = "yourpassword",
         database = "locksmith"
       }
     })
     ```
