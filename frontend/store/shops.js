export const state = () => ({
  shops: [],
  shop: {},
  name: 'vuex shop'
})

export const getters = {
  shops: (state) => state.shops,
  shop: (state) => state.shop,
  name: (state) => state.name
}

export const mutations = {
  setShops: (state, shops) => {
    state.shops = shops
  },
  setShopInfo: (state, shop) => {
    state.shop = shop
  }
}
