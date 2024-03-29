const path = require('path');
const { Pool, Client } = require('pg');
const {ApolloServer,ApolloError} = require('apollo-server');
const { gql } = require('apollo-server');
require('dotenv').config()

const currentEnvPath = path.resolve('../');

const postgresconnectionUrl = process.env.postgresconnectionUrl
const pool = new Pool({
    connectionString:postgresconnectionUrl
});

const typeDefs = gql`
    type User {
        id: ID!
        email: String!
        token: String!
        username: String!
        createdAt: String
    }
    type Query{
        sample: String!
        checkDBConnection: String!
    }
`;


const resolvers = {
    Query: {
      sample() {
        console.log("validation of query");
        return "verified";
      },
      checkDBConnection() {
            pool.query('SELECT * FROM users ORDER BY id ASC', (error, results) => {
                if (error) {
                   throw new ApolloError("database pod connection issue");
                }
                console.log(results.row);
            });
            return "query success";
      }
    },
  };

const server = new ApolloServer({
    typeDefs,
    resolvers
})

const port = 4000 || process.env.PORT

const connect = ()=>{
    try{
      
        pool.on('error',(err,client)=>{
            throw new Error("psql client connection error");
        })
        pool.connect((err, client, done) => {
            if (err) throw err
            server.listen(port).then(data =>{
                console.log(`apollo server started on port ${port}`);
            }).catch(err =>{
                throw new Error("apollo server connection error");
            })
        })
    }catch(err){
        console.log(err);
        process.exit(1);        
    }
}

connect();
