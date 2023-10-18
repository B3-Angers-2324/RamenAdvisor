# Steps to start the database in dev mode

## Requirements
- Docker installed and running
- The extension [MongoDB for VS Code](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode) installed in VS Code

## Steps
1. Open the terminal in the root of the project
2. Run the command `cd .devenv`
3. Run the command `docker-compose up -d`
4. Open the MongoDB extension in VS Code
5. Click on the button `Connect to MongoDB`
6. Click on the button for `Advanced Connection Settings`
7. Select `Username / Password`
8. Fill the fields with the following values:
    - Username: `root`
    - Password: `rootpassword`

### You're ready to go!
