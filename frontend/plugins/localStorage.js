import createPersistedState from 'vuex-persistedstate'
 
export default ({ store }) => {
    window.onNuxtReady(() => {
        createPersistedState({
            key: 'dishare-key',
            path: [
              'auth'
            ],
        })(store)
    })
}