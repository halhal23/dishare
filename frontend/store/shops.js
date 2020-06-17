export const state = () => ({
  shops: [],
  shop: {},
  currentPosition: {},
  isSearched: false //　検索したかどうか
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
    state.isSearched = shops == null ? false : true // shopsがnullでクリアされる場合は、falseにする。
  },
  setShopInfo: (state, shop) => {
    state.shop = shop
  },
  setCurrentPosition: (state, position) => {
    state.currentPosition = position
  },
}
