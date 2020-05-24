export default function({ $axios, redirect }) {
  $axios.setToken("access_token")

  // $axios.onRequest(config => {
  //   config.headers.client = window.localStorage.getItem("client")
  //   config.headers["access-token"] = window.localStorage.getItem("access-token")
  //   config.headers.uid = window.localStorage.getItem("uid")
  //   config.headers["token-type"] = window.localStorage.getItem("token-type")
  //   config.headers["content-type"] = 'application/json'
  // })

  $axios.onResponse(response => {
    $axios.setHeader("Access-Control-Allow-Origin", "*")
    // if (response.headers.client) {
    //   localStorage.setItem("access-token", response.headers["access-token"])
    //   localStorage.setItem("client", response.headers.client)
    //   localStorage.setItem("uid", response.headers.uid)
    //   localStorage.setItem("token-type", response.headers["token-type"])
    // } else {
    //   console.log('認証情報を発見できませんでした')
    // }
  })
}