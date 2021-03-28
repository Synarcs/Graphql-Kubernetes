# docker build -t vedangparasnis/apollographql:latest .
# docker tag vedangparasnis/apollographql:latest
# docker push vedangparasnis/apollographql:latest 


docker build -t  apollographql/service . 
docker tag apollographql/service artifacts-scm.dstcorp.net/docker-local/lyric/apollo-service
docker login artifacts-scm.dstcorp.net
docker push artifacts-scm.dstcorp.net/docker-local/lyric/apollo-service


