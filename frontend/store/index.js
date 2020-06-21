export const state = () => ({
  // クリックしたUserを詳細表示するためのデータ
  user: {}
})

export const mutations = {
  setUser: (state, userData) => {
    state.user = userData
  }
}