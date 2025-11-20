# CS 262 Monopoly Web Service

This is the data service application for the  
[CS 262 sample Monopoly project](https://github.com/calvin-cs262-organization/monopoly-project),  
which is deployed here:

- <https://cs262-egbefbd4aae2h0df.canadacentral-01.azurewebsites.net>  
  (This URL may vary from year to year.)

Based on this URL, the service implements the following endpoints:

- `/` — a hello message  
- `/players` — the full list of players  
- `/players/:id` — the single player with the given ID (e.g., `/players/1`)

Also, it gives the following responses:

- `/players/-1` — all invalid IDs like this one return a not-found error  
- `/blob` — all undefined endpoints like this one return a cannot-get error.

It is based on the  
[standard Azure App Service tutorial for Node.js](https://learn.microsoft.com/en-us/azure/app-service/quickstart-nodejs?tabs=linux&pivots=development-environment-cli).

The database is relational with the schema specified in the `sql/` sub-directory  
and is hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/).  
The database server, user and password are stored as Azure application settings so that they  
aren’t exposed in this (public) repo.

We implement this sample service as a separate repo to simplify Azure integration;  
it’s easier to auto-deploy a separate repo to Azure. For your team project’s  
data service, configure your Azure App Service to auto-deploy from the master/main branch  
of your service repo. See the settings for this in the “Deployment Center”  
on your Azure service dashboard.

---

## **New Endpoints Added for Homework 3**

As required by Homework 3, three new game-related endpoints were added so the mobile client can retrieve games, view game details, and delete games on both the service and the client.

### **GET /games**  

Returns a list of all Monopoly games (game ID, timestamp, and status).

### **GET /games/:id**  

Returns the players who participated in the specified game along with their scores.

### **DELETE /games/:id**  

Deletes the specified game, including related rows in `PlayerGame` and `Ownership`, using a PostgreSQL transaction.  
Returns the deleted ID or a not-found error.

---
