const environment = process.env.NODE_ENV || 'development';
const envSet = require(`./env.${environment}.js`)


const config = {

  mode: 'universal',

  env: envSet,
  /*
  ** Headers of the page
  */
  head: {
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },
  /*
  ** Global CSS
  */
  css: [
    'element-ui/lib/theme-chalk/index.css',
    '~/assets/styles/common.css'
  ],
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
    '@/plugins/element-ui',
    { src: '~/plugins/axios.js', ssr: false },
    { src: "~plugins/vue2-google-maps.js" }
  ],
  /*
  ** Nuxt.js dev-modules
  */
  buildModules: [
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/proxy',
    '@nuxtjs/auth'
  ],
  /*
  ** Axios module configuration
  ** See https://axios.nuxtjs.org/options
  */
  axios: {
    proxy: true,
    host: 'localhost',
    port: 3000
  },
  proxy: {
    '/api': {
      target: 'https://api.gnavi.co.jp/RestSearchAPI/v3/',
      pathRewrite: {
        '^/api' : '/'
        }
      }
  },
  auth: {
    redirect: {
      login: '/', 
      logout: '/',
      callback: false,
      home: '/'
    },
    strategies: {
      local: {
        endpoints: {
          login: { url: 'http://localhost:3000' + '/api/auth/sign_in', method: 'post', propertyName: false },
          logout: { url: 'http://localhost:3000' + '/api/auth/sign_out', method: 'DELETE'},
          user: false
        }
      }
    }
  },
  /*
  ** Build configuration
  */
  build: {
    transpile: [/^element-ui/, /^vue2-google-maps($|\/)/],
    /*
    ** You can extend webpack config here
    */
    standalone: true,
    extend (config, ctx) {
    }
  }
}

export default config
