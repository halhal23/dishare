const state = () => ({
  count: 0
})

const getters = {
  count: (state) =>  state.count 
}

const mutations = {
  countUp(state){
    state.count++
  }
}

const actions = {
  increment({ commit }){
    commit('countUp')
  }
}

module.exports = {
  state,
  getters,
  mutations,
  actions
}