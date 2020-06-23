export default function({ $axios, redirect }) {
  $axios.onRequest(config => {
    config.headers.client = window.localStorage.getItem("client")
    config.headers["access-token"] = window.localStorage.getItem("access-token")
    config.headers.uid = window.localStorage.getItem("uid")
    config.headers["token-type"] = "Bearer"
    config.headers["expiry"] = window.localStorage.getItem("expiry")
    config.headers["content-type"] = 'application/json'
  })

  $axios.onResponse(response => {
    $axios.setHeader("Access-Control-Allow-Origin", "*")
    if (response.headers.client) {
      console.log('success')
      localStorage.setItem("access-token", response.headers["access-token"])
      localStorage.setItem("client", response.headers.client)
      localStorage.setItem("uid", response.headers.uid)
      localStorage.setItem("token-type", response.headers["token-type"])
      localStorage.setItem("expiry", response.headers["expiry"])
    }
  })
}