# CleverCloud Keycloak Image

This project allow you to run the latest Keycloak release in HA mode using Postgresql as database and allowing you to import your own truststore. Don't forget to push it and to change the password in the Dockerfile.


## Extract TrustStore from Keystore


shell> keytool -export -alias replserver -file client.cer -keystore keystore.jks
Enter keystore password:  
Certificate stored in file <client.cer>

shell> keytool -import -v -trustcacerts -alias replserver -file client.cer -keystore truststore.ts 
