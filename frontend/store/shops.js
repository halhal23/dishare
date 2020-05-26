export const state = () => ({
  shops: [],
  name: 'vuex shop'
})

export const getters = {
  shops: (state) => state.shops,
  name: (state) => state.name
}

export const mutations = {
  setShops: (state, shops) => {
    state.shops = shops
  }
}
