# Redis

Deploy redis using docker compose file. Refer to the [docker-compose.yml](./docker-compose.yml) file.

Note: Keep in mind the `REDIS_PASSWORD` is a secret and should be stored in a `.env` file.

## Create a new redis user with ACL admin.

Access the container using docker exec command. 

```sh
docker exec -it cmpa-redis redis-cli -a <redis-password>
```

`-a` flag is used to pass the password to the redis-cli.
```

`-a` flag is used to pass the password to the redis-cli.

Once you are inside the redis container, you can create a new users by running the following command.

```sh
acl setuser joedeo on >EasyP4sswd +@all -@dangerous ~*
```

Done. You have created a new user with the name `joedeo` and password `EasyP4sswd`.

## Access redis-cli using the new user.

You can access the redis-cli using the new user by running the following command.

```sh
redis-cli -u joedeo -a EasyP4sswd
```

`-u` flag is used to pass the username and `-a` flag is used to pass the password.

## References



