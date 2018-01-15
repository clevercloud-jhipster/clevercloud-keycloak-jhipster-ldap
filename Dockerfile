FROM jboss/keycloak-postgres:3.4.0.Final
USER root
ENV JBOSS_HOME /opt/jboss/keycloak
COPY realm-config /opt/jboss/keycloak/realm-config
ADD truststore.ts $JBOSS_HOME/standalone/configuration/
RUN chown jboss:jboss $JBOSS_HOME/standalone/configuration/truststore.ts
USER jboss
RUN sed -i -e 's/<\/theme>/&\n	       <spi name="truststore">\n    <provider name="file" enabled="true">\n        <properties>\n            <property name="file" value="\/opt\/jboss\/keycloak\/standalone\/configuration\/truststore.ts"\/>\n            <property name="password" value="quantixx"\/>\n            <property name="hostname-verification-policy" value="ANY"\/>\n            <property name="disabled" value="false"\/>\n        <\/properties>\n    <\/provider>\n <\/spi>/' $JBOSS_HOME/standalone/configuration/standalone-ha.xml
RUN sed -i -e 's/<\/theme>/&\n	      <spi name="truststore">\n    <provider name="file" enabled="true">\n        <properties>\n            <property name="file" value="\/opt\/jboss\/keycloak\/standalone\/configuration\/truststore.ts"\/>\n            <property name="password" value="quantixx"\/>\n            <property name="hostname-verification-policy" value="ANY"\/>\n            <property name="disabled" value="false"\/>\n        <\/properties>\n    <\/provider>\n <\/spi>/' $JBOSS_HOME/standalone/configuration/standalone.xml

CMD ["-b", "0.0.0.0", "--server-config", "standalone-ha.xml", "-Dkeycloak.migration.action=import", "-Dkeycloak.migration.provider=dir", "-Dkeycloak.migration.dir=/opt/jboss/keycloak/realm-config", "-Dkeycloak.migration.strategy=OVERWRITE_EXISTING"]

