FROM openjdk:8-jre
COPY target/universal/*-1.0-SNAPSHOT.zip /svc.zip
RUN set -ex && \
    unzip -d svc svc.zip && \
    mv svc/*/* svc/ && \
    rm svc/bin/*.bat && \
    mv svc/bin/* svc/bin/start
EXPOSE 9000 9443
CMD /svc/bin/start -Dhttps.port=9443 -Dplay.crypto.secret=secret
