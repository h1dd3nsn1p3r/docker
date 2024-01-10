db.createUser(
  {
    user: "anujsubedi",
    pwd: "anujsubedi",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
  }
)
