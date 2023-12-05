module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './node_modules/preline/dist/*.js'
  ],
  
  plugins: [
    require("daisyui"),
    require('preline/plugin'),
    require('@tailwindcss/forms'),
  ],

  theme: {
    extend: {
      fontFamily: {
        'sans': ['Russo One', 'DotGothic16', 'sans-serif'], // 英数字用Russo One、日本語用DotGothic16       
      }
    }
  }

}
