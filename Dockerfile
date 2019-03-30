FROM hasura/graphql-engine:v1.0.0-alpha41.cli-migrations as builder
COPY ./migrations /heroku-migrations
RUN export HASURA_GRAPHQL_DATABASE_URL=$DATABASE_URL

FROM hasura/graphql-engine:v1.0.0-alpha41 as production

# Disable the console
ENV HASURA_GRAPHQL_ENABLE_CONSOLE=false
ENV HASURA_GRAPHQL_ADMIN_SECRET=packt_secret

# Change $DATABASE_URL to your heroku postgres URL if you're not using
# the primary postgres instance in your app
CMD graphql-engine \
    --database-url $DATABASE_URL \
    serve \
    --server-port $PORT

## Comment the command above and use the command below to
## enable an access-key and an auth-hook
## Recommended that you set the access-key as a environment variable in heroku
#CMD graphql-engine \
#    --database-url $DATABASE_URL \
#    serve \
#    --server-port $PORT \
#    --access-key XXXXX \
#    --auth-hook https://myapp.com/hasura-webhook 
#
# Console can be enable/disabled by the env var HASURA_GRAPHQL_ENABLE_CONSOLE
