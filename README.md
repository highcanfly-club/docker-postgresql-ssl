# docker-postgresql-ssl
Alpine docker Postgresql 15 image with ssl

This is a basic Alpine image with PostgreSQL 15 included.  
But why another image ?  

Because it has a built in ssl support.  
At each restart the server certificate is recreated.  You can provide your own by passing environment variables:  
```sh
export POSTGRES_SSL_KEY=`cat server.key`
export POSTGRES_SSL_SRT=`cat server.crt`
```
Note that it is possible to import key and cert with a single line string by replacing \n by spaces.  
Example:  
-----BEGIN PRIVATE KEY----- MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC6VtJoI7dkG9Pl QkKPQKbVQ7g0+FiQEnNoHU0= -----END PRIVATE KEY-----

# deploy
Get image at highcanfly/postgresql-ssl:latest