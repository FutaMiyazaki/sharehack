import createPersistedState from 'vuex-persistedstate'

export default ({ store }) => {
  window.onNuxtReady(() => {
    createPersistedState({
      // key: '任意のキー',
      path: ['authentication']
    })(store)
  })
}
