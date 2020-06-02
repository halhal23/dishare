export const state = () => ({
  currentUser:  null,
  isLoggedIn: false,
})

export const getters = {
  currentUser: state => state.currentUser,
  isLoggedIn: state => state.isLoggedIn
}

export const mutations = {
  setCurrentUser(state, user){
    state.currentUser = user
  },
  setIsLoggedIn(state, bool){
    state.isLoggedIn = bool
  },
}

export const actions = {
  async signUp({ commit }, formData) {
    await this.$axios.$post(process.env.browserBaseUrl + '/api/auth', {
        name: formData.name,
        email: formData.email,
        password: formData.password,
        password_confirmation: formData.password_confirmation
    })
      .then( res => {
        console.log('新規登録成功' + ' /stores/auth.js')
        console.log('ログイン成功' + ' /stores/auth.js')
        console.log(res)
        commit('setCurrentUser', res.data)
        commit('setIsLoggedIn', true)
        this.$router.push("/posts")
        return res
      }, err => {
        console.log('ログイン失敗' + ' /stores/auth.js')
        console.log(err)
        return err
      })
  },
  async login({ commit }, formData){
    await this.$axios.$post(process.env.browserBaseUrl + '/api/auth/sign_in', {
      name: formData.name,
      email: formData.email,
      password: formData.password,
      password_confirmation: formData.password
    }).then( res => {
        console.log('ログインできたよ' + ' /stores/auth.js')
        console.log(res)
        commit('setCurrentUser', res.data)
        commit('setIsLoggedIn', true)
        this.$router.push("/posts")
        return res
      }, err => {
        console.log('ログイン失敗しちゃった。' + ' /stores/auth.js')
        console.log(err)
        return err
      })
  },
  async logout({ commit, store }){
    await this.$axios.$delete(process.env.browserBaseUrl + '/api/auth/sign_out').then( res => {
      console.log('ログアウト成功')
      commit('setCurrentUser', null)
      commit('setIsLoggedIn', false)
      this.$router.push("/")
      console.log(res)
      return res
    }).catch( err => {
      console.log('ログアウト失敗')
      console.log(err)
      return err
    })
  },
}