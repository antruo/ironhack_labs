# MySQL Finance Dataset Lab

This is using a dockerized MySQL database with all tables loaded.
Have a look at the attached [PDF](berka.pdf) for more information on the tables and their relations.

## Requirements:
Docker.

Alternatively, you can use the mysql dump file to load the dataset into your existing MySQL database yourself.

## Setting up the database:
First, clone this repo!

## A. Using the mysql dump file:
If you already have an up and running MySQL server on your localhost, you can simply download the mysql dump file (`/initdb/mysql_dump.sql`) and run it yourself. The file creates a database `bank` with all tables and records.

## B. Using Docker:

If you don't have MySQL running locally follow these instructions. Make sure Docker is running. 

We are using the official mysql docker image with a handful of additional settings. From the root of the repo, run this in your command line to get the container running:

```bash
docker run -p 3306:3306 --name mysql_finance -v "$(pwd)"/initdb:/initdb -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql --secure-file-priv=""
```

On success, it should print the container id. You can also manually check if your container is running, like so:

```bash
docker ps -a
```

You should find a line with your container id and status `Up`.

Next up, we want to initlaize the database by loading the datasets. Execute the mounted shell script like so (this might take a couple of minutes):

```bash
docker exec -it mysql_finance bash -c "./initdb/init_db.sh"
```

It should print `Database initialized` on success. Once you see that, you're good to go!

## How to connect to the database:
If you just followed the instructions, then your container should be up and running. In this case, you can either access the database through the mysql shell or connect to it through any database client that supports MySQL.

### MySQL Command Line Client
To access the mysql cl client, run the command below (the password is **ironhack**):

```bash
docker exec -it mysql_finance mysql -u ironhack -p
```

This should bring you right to the mysql command prompt. Try running a sample query like this:

```bash
mysql> SELECT * FROM bank.account LIMIT 10;
```

Exit through Ctrl+d.

### 3rd party database clients (e.g.: sequel Pro)
Use the following credentials to connect to your dockerized database:

```
Host: localhost (or 127.0.0.1)
Username: ironhack
Password: ironhack
Port: 3306
```

## FAQ:
- Do changes I run on the database persist (e.g. new tables, deletes, etc.)?
    + As long as you are running the same container, changes persist. They get lost as soon as you are running a new container, for instance, when pulling a newer mysql image.

- Is my dockerized database constantly running?
    + Usually, yes. You can manually pause or stop it through `docker pause mysql_finance` or `docker stop mysql_finance` and just simply restart it through `docker restart mysql_finance`
    + You can always check the state of your container through `docker ps -a`. Make sure it's up and running whenever you want to use it!

- My client says it is unable to connect!
    + See above. Is your container running? If not, restart it.
    + If this isn't solving it, ...

## Known bugs:

- The database initiation script might fail. In this case, the safest option is to remove the container and start over:
    + First, stop the running container `docker stop mysql_finance`
    + Now remove it `docker rm mysql_finance`
    + Follow instructions from above again (starting from `docker run ...`)

- In the docker run command from above, we are mapping the mysql standard port to the same one, which can cause conflicts if you have another mysql server running simultaneously. Either shut it down or change the port mapping.

## Contribute:
Besides coming up with Lab exercises, there are many other TODOs. If you want to contribute, please submit your changes through a PR and a detailed description of your changes. Things to work on:
- Creating exercises using the data
- Improve table schemas
    + Define relationships (Foreign Keys, Primary Keys)
    + Create indexes
    + Add useful constraints (unique, not null, etc.)
- Cast columns storing dates from `ÌNT` to `DATE` or `TIMESTAMP` types
- Create consistennt `NULL`s. Some of them might currently be represented as empty spaces, `" "`, or otherwise
- Instructions on how to add a volume to have a persistent database
