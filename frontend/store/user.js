export const state = () => ({
  current_user: null,
  isLoggedIn:  false
})

export const getters = {
  current_user: (state) => state.current_user,
  isLoggedIn: (state) => state.isLoggedIn,
}

export const mutations = {
  test(state){
    console.log('heho')
  },
  setCurrentUser(state, user){
    console.log('vuex store にcurrent user をセット')
    state.current_user = user
    state.isLoggedIn = true
    console.log(state)
  },
  removeCurrentUser(state){
    state.current_user = null
    state.isLoggedIn = false
  },
}

export const actions = {
  sign_up({ commit, router }, authData) {
    this.$axios.post(process.env.browserBaseUrl + "/api/auth/",{
          email: authData.email,
          password: authData.password,
          password_confirmation: authData.password_confirmation,
          name: authData.name
        }
        // 登録成功時処理
      ).then(res => {
        console.log('新規登録成功したよ')
        console.log(res)
        commit("", {
          user: response.data.data
        })
        
        this.$router.push("/posts")
      })
      // 登録失敗時処理
      .catch(err => {
        console.log('新規登録失敗したよ')
        console.log(err)
      })
  },
}