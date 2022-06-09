// You can structure your project using ES6 modules. This is how you import a local javascript file:
import { greet } from "./greeting.js"
// You can also import libraries online, see deps.js
import { _ } from "./deps.js"

export function write_greeting(node, input_data) {
    // node.innerText = greet(input_data)
    node.innerText = greet(_.upperFirst(input_data))
}
