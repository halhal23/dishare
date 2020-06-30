export const state = () => ({
  currentUser:  {},
  isLoggedIn: false,
})

export const getters = {
  currentUser: state => state.currentUser,
  isLoggedIn: state => state.isLoggedIn
}

export const mutations = {
  setCurrentUser(state, userData){
    state.currentUser = userData
  },
  setIsLoggedIn(state, bool){
    state.isLoggedIn = bool
  }
}

export const actions = {
  async signUp({ commit }, formData) {
    let form = new FormData()
    form.append("name", formData.name)
    form.append("email", formData.email)
    form.append("password", formData.password)
    form.append("password_confirmation", formData.password_confirmation)
    if (formData.imageFile !== null ){
      form.append("image", formData.imageFile)
    }
    await this.$axios.$post(process.env.browserBaseUrl + '/api/auth', form,{
      headers: {
          "Content-Type": "multipart/form-data"
      }
    })
      .then( res => {
        commit('setCurrentUser', res.data)
        commit('setIsLoggedIn', true)
        this.$router.push(`/users/mypage`)
        return res
      }, err => {
        return err
      })
  },
  async login({ commit }, formData){
    await this.$axios.$post(process.env.browserBaseUrl + '/api/auth/sign_in', {
      name: formData.name,
      password: formData.password,
      password_confirmation: formData.password
    }).then( res => {
        commit('setCurrentUser', res.data)
        commit('setIsLoggedIn', true)
        this.$router.push(`/posts`)
        return 'res'
      }, err => {
        console.log(err.response.data.errors[0])
        return err
      })
  },
  async logout({ commit }){
    await this.$axios.$delete(process.env.browserBaseUrl + '/api/auth/sign_out').then( res => {
      commit('setCurrentUser', {})
      commit('setIsLoggedIn', false)
      this.$router.push("/")
      return res
    }).catch( err => {
      return err
    })
  },
}