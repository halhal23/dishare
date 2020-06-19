export const state = () => ({
  // クリックしたUserを詳細表示するためのデータ
  user: {
    email: '',
    followers: [],
    followings: [],
    id: 2,
    image: { url: '' },
    name: '',
    posts: [] 
  }
})

export const mutations = {
  setUser: (state, userData) => {
    state.user = userData
  }
}