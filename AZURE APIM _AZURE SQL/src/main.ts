//console.log("Hello World!")
//import { execute, parse } from 'graphql'
//import { schema } from './schema'
 
//async function main() {
//	  const myQuery = parse(/* GraphQL */ `
//				    query {
//					          hello
//						      }
//						        `)
//							 
//							  const result = await execute({
//								      schema,
//								          document: myQuery
//									    })
//									     
//									      console.log(result)
//}
 
//main()

import { createServer } from 'node:http'
import { createYoga } from 'graphql-yoga'
import { createContext } from './context'
import { schema } from './schema'


function main() {
  const yoga = createYoga({ schema, context: createContext })
  const server = createServer(yoga)
  server.listen(4000, () => {
    console.info('Server is running on http://localhost:4000/graphql')
  })
}
 
main()