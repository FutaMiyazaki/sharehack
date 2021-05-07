module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
    es6: true
  },
  parserOptions: {
    parser: 'babel-eslint'
  },
  extends: [
    '@nuxtjs',
    'prettier',
    'prettier/vue',
    'plugin:prettier/recommended',
    'plugin:nuxt/recommended'
  ],
  plugins: [
    'prettier'
  ],
  overrides: [
    {
      files: ["*.vue"],
      processor: "vue/.vue"
    }
  ],
  // add your custom rules here
  rules: {
    'no-console': 'off', // 追記
    'vue/comment-directive': 0 // 追記
  }
}
