import createPersistedState from 'vuex-persistedstate'
 
export default ({ store }) => {
 
    window.onNuxtReady(() => {
        createPersistedState({
            key: 'dishare-key',
            storage: window.sessionStorage
        })(store)
    })
}