module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './lib/hyperui/**/*.{html.erb,rb}',
  ],
  corePlugins: {
    prefilight: false,
  },
  plugins: [
    require('@tailwindcss/container-queries'),
  ]
}
