export default function({ $axios }) {
  $axios.onRequest((config) => {
    config.headers.client = localStorage.getItem('client')
    config.headers['access-token'] = localStorage.getItem('access-token')
    config.headers.uid = localStorage.getItem('uid')
    config.headers['token-type'] = localStorage.getItem('token-type')
    config.headers.expiry = localStorage.getItem('expiry')
    console.log('↓ axios onRequest config')
    console.log(config)
  })

  $axios.onResponse((response) => {
    console.log('↓ onResponse response')
    console.log(response.headers)
    if (response.headers.client) {
      console.log('認証情報あり  /plugins/axios.js')
      localStorage.setItem('access-token', response.headers['access-token'])
      localStorage.setItem('client', response.headers.client)
      localStorage.setItem('uid', response.headers.uid)
      localStorage.setItem('token-type', response.headers['token-type'])
      localStorage.setItem('expiry', response.headers.expiry)
    } else {
      console.log('認証情報を発見できませんでした')
    }
    console.log('-------- end /plugins/axios.js------------')
  })
}
