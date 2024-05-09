import { createSchema } from 'graphql-yoga';
import { Sequelize, DataTypes } from 'sequelize';

// Define the Sequelize connection
const sequelize = new Sequelize('yqylefucee5n6.database.windows.net', 'arpan', 'Pa$word#34', {
    host: 'your_server',
    dialect: 'mssql',
});

// Define the Book model
const Book = sequelize.define('Book', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    title: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    author: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    genre: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    publicationYear: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
});

// Define the context
interface Context {
    db: Sequelize;
}

function createContext(): Context {
    return { db: sequelize };
}

// GraphQL schema definition
const typeDefs = `
  type Query {
    books: [Book!]!
    book(id: Int!): Book
  }
  type Mutation {
    addBook(title: String!, author: String!, genre: String!, publicationYear: Int!): Book!
  }
 
  type Book {
    id: Int!
    title: String!
    author: String!
    genre: String!
    publicationYear: Int!
  }
`;

// Resolvers
const resolvers = {
    Query: {
        books: async (_parent: unknown, _args: {}, context: Context) => {
            return await context.db.models.Book.findAll();
        },
        book: async (_parent: unknown, { id }: { id: number }, context: Context) => {
            return await context.db.models.Book.findByPk(id);
        }
    },
    Mutation: {
        addBook: async (
            _parent: unknown,
            args: { title: string; author: string; genre: string; publicationYear: number },
            context: Context
        ) => {
            const newBook = await context.db.models.Book.create({
                title: args.title,
                author: args.author,
                genre: args.genre,
                publicationYear: args.publicationYear
            });
            return newBook;
        }
    }
};

// Create the GraphQL schema
export const schema = createSchema({
    resolvers: [resolvers],
    typeDefs: [typeDefs]
});
