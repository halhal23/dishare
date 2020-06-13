const Vuex = require('vuex')
const count = require('../../store/count.js')
const { createLocalVue } = require('@vue/test-utils')
const cloneDeep = require('lodash.clonedeep')

const localVue = createLocalVue()
localVue.use(Vuex)

describe('store/count.js', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(count))
  })

  describe('mutations', () => {
    test('countUp ミューテーションがコミットされると、countステートの値が+1される', () => {
      expect(store.getters['count']).toBe(0)
      store.commit('countUp')
      expect(store.getters['count']).toBe(1)
    })
  })
})