# MongoDB Replica Set

Let's assume we would like to have a replica set with 3 nodes. We'll use Docker to create the nodes. We'll use `docker-compose` to create the nodes.

- Go to `/home/mongo`
- Create `docker-compose.yml` (Check compose file for the reference)
- Create `.env` file.

Env file needs to have following content.

```txt
MONGODB_ADMIN_USERNAME=admin
MONGODB_ADMIN_PASSWORD=superSimplePa55word
```

## Create key file

On the same directory `/home/mongo`, create a key file. 

```sh
openssl rand -base64 741 > replica.key
```

Then we'll reduce the permissions on the key, else MongoDB will complain that the permissions of the key are too open.

```sh
chmod 400 replica.key
```
Again chmod the file to change the owner of the file to 999:999.

```sh
sudo chown 999:999 replica.key
```

That's it. We are ready to create the replica set.

## Run containers

To start the containers, run the following command.

```sh
docker-compose up -d
```

## Access the container

To access the container, run the following command.

```sh
docker exec -it mongodb1 /bin/bash
```

Once inside the container, run the following command to access the MongoDB shell.

```sh
mongosh -u <username> -p <password> --authenticationDatabase admin
```

## Create replica set

Inside the MongoDB shell, run the following command to create a replica set.

```sh
use admin

rs.initiate()

rs.add("mongodb2:27017")
rs.add("mongodb3:27017")
```

## Create user for the database.

Let's create a user for the database.

```sh
use <database>
```
 
Then let's create a user for the database.

```js
db.createUser({
  user: "<username>",
  pwd: "<password>",
  roles: [ { role: "readWrite", db: "eCommerceX" } ]
})
``` 

**Note:** Replace `<username>` and `<password>` with the actual username and password. Replace `eCommerceX` with the actual database name.

Now we can quit the shell.

```sh
quit()
```

## Re-config the replica set

If we restart the containers, the replica set will be lost. To re-config the replica set, we need to run the following commands.

```sh
docker exec -it mongodb1 /bin/bash
```

Then run the following commands.

```sh
mongosh -u <username> -p <password> --authenticationDatabase admin
```

```sh
use admin

rs.initiate({
	_id: "rs0",
	members: [
		{ _id: 0, host: "mongodb1:27017" },
		{ _id: 1, host: "mongodb2:27017" },
		{ _id: 2, host: "mongodb3:27017" }
	]
})
```

## Connection string.

Let's test the connection using MongoDB Compass.

```sh
mongodb://<username>:<password>@<ip>:27017/eCommerceX?authSource=eCommerceX&replicaSet=rs0&retryWrites=true&directConnection=true
```

**Note:** Here, `?directConnection=true` flag seems to be required. Otherwise, it will not connect.

If username or password contains $ : / ? # [ ] @ chars the percentage encoded value should be used. For example, %40 for @, %2D for -, %7E for ~, %25 for %, %7B for {, %7D for }.

