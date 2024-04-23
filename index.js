import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import express from 'express'; // Import Express

const typeDefs = `#graphql
  type Book {
    title: String
    author: String
  }

  type Query {
    books: [Book]
  }
`;

const books = [
  {
    title: 'The Awakening',
    author: 'Kate Chopin',
  },
  {
    title: 'City of Glass',
    author: 'Paul Auster',
  },
];

const resolvers = {
  Query: {
    books: () => books,
  },
};

// Authentication middleware function
const authenticate = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ message: 'Authorization header is missing.' });
  }

  const encodedCredentials = authHeader.split(' ')[1];
  const credentials = Buffer.from(encodedCredentials, 'base64').toString();
  const [username, password] = credentials.split(':');

  // Check if credentials match
  if (username === 'admin' && password === 'admin') {
    return next(); // Proceed to next middleware or resolver
  } else {
    return res.status(401).json({ message: 'Invalid credentials.' });
  }
};

// Create an Express app
const app = express();

// Apply basic authentication middleware to all routes
app.use(authenticate);

// Create Apollo Server instance
const server = new ApolloServer({
  typeDefs,
  resolvers,
});

// Pass ApolloServer instance to startStandaloneServer function
startStandaloneServer(server, {
  app, // Use the Express app
  port: process.env.PORT || 4000,
}).then(({ url }) => {
  console.log(`🚀  Server ready at: ${url}`);
});
