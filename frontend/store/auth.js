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
    let form = new FormData()
    form.append("name", formData.name)
    form.append("email", formData.email)
    form.append("password", formData.password)
    form.append("password_confirmation", formData.password_confirmation)
    if (formData.imageFile !== null ){
      console.log('image not null')
      form.append("image", formData.imageFile)
    }
    console.log(formData)
    await this.$axios.$post(process.env.browserBaseUrl + '/api/auth', form,{
      headers: {
          "Content-Type": "multipart/form-data"
      }
    })
      .then( res => {
        console.log('新規登録成功' + ' /stores/auth.js')
        console.log('ログイン成功' + ' /stores/auth.js')
        console.log(res)
        commit('setCurrentUser', res.data)
        commit('setIsLoggedIn', true)
        this.$router.push("/users/mypage")
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
        this.$router.push("/users/mypage")
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