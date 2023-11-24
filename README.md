# Locksmith
A simple authorized_keys management system for Linux, written in Lapis!

## Installation and Configuration

### OpenResty and Lapis Installation

1. **Install OpenResty**
   - Follow the installation instructions on the [OpenResty website](https://openresty.org/en/installation.html).

2. **Install Lapis**
   - Use LuaRocks to install Lapis:
     ```bash
     luarocks install lapis
     ```

### MySQL Database Setup

1. **Install MySQL**
   - Follow your operating system's standard installation procedure to install MySQL.

2. **Create Database**
   - Log into MySQL:
     ```bash
     mysql -u root -p
     ```
   - Create a new database for the application:
     ```sql
     CREATE DATABASE locksmith;
     ```

### Lapis Project Initialization

1. **Create a New Lapis Project**
   - Navigate to your desired project directory.
   - Initialize a new Lapis project:
     ```bash
     lapis new --lua
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
