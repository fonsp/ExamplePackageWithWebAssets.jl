// In an ES6 project, it is common to place all your remote imports in a single file, deps.js. See https://deno.land/manual/examples/manage_dependencies

// You can import JS libraries from the web using a service like esm.sh or skypack.dev. Be sure to pin two versions: the version of your package, and the version of the CDN service.
export { default as _ } from "https://cdn.esm.sh/v58/lodash-es@4.17.21/es2021/lodash-es.js"
