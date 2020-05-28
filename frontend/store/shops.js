export const state = () => ({
  shops: [],
  shop: {},
  currentPosition: {},
  name: 'vuex shop'
})

export const getters = {
  shops: (state) => state.shops,
  shop: (state) => state.shop,
  currentPosition: (state) => state.currentPosition,
  name: (state) => state.name
}

export const mutations = {
  setShops: (state, shops) => {
    state.shops = shops
  },
  setShopInfo: (state, shop) => {
    state.shop = shop
  },
  setCurrentPosition: (state, position) => {
    state.currentPosition = position
  },
}
