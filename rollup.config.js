import resolve from "@rollup/plugin-node-resolve"

export default {
  input: "app/javascript/editorjs/index.js",
  output: {
    file: "app/assets/javascripts/editorjs-rails.js",
    format: "esm"
  },
  plugins: [
    resolve()
  ]
}
