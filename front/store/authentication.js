export const state = () => ({
  isLoggedIn: false,
  currentUser: null,
  currentUserAvatar: null,
  isAdmin: false
})

export const getters = {
  isLoggedIn: (state) => state.isLoggedIn,
  currentUser: (state) => state.currentUser,
  currentUserAvatar: (state) => state.currentUserAvatar,
  isAdmin: (state) => state.isAdmin
}

export const mutations = {
  setIsLoggedIn(state, bool) {
    state.isLoggedIn = bool
  },
  setCurrentUser(state, user) {
    state.currentUser = user
  },
  setCurrentUserAvatar(state, avatar) {
    state.currentUserAvatar = avatar
  },
  setIsAdmin(state, bool) {
    state.isAdmin = bool
  }
}

export const actions = {
  async signUp({ commit }, authData) {
    await this.$axios
      .$post('/api/v1/auth', {
        name: authData.name,
        email: authData.email,
        password: authData.password,
        password_confirmation: authData.password_confirmation
      })
      .then((response) => {
        commit('setCurrentUser', response.data)
        commit('setIsLoggedIn', true)
        this.$router.push('/')
        commit('flashMessage/setText', '新規登録が完了しました', { root: true })
        commit('flashMessage/setType', 'success', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 5000)
        return response
      })
      .catch((error) => {
        commit(
          'flashMessage/setText',
          '新規登録できませんでした。入力内容に誤りがあります。',
          {
            root: true
          }
        )
        commit('flashMessage/setType', 'error', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 5000)
        return error
      })
  },
  async login({ commit }, authData) {
    await this.$axios
      .$post('/api/v1/auth/sign_in', {
        email: authData.email,
        password: authData.password
      })
      .then((response) => {
        commit('setCurrentUser', response.data)
        commit('setIsLoggedIn', true)
        this.$router.push('/')
        commit('flashMessage/setText', 'ログインしました', { root: true })
        commit('flashMessage/setType', 'success', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 5000)
        return response
      })
      .catch((error) => {
        commit(
          'flashMessage/setText',
          'ログインできませんでした。入力内容に誤りがあります。',
          {
            root: true
          }
        )
        commit('flashMessage/setType', 'error', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 5000)
        return error
      })
  },
  async getAvatar({ commit }, userId) {
    await this.$axios
      .$get(`api/v1/users/${userId}`)
      .then((response) => {
        commit('setCurrentUserAvatar', response.avatar_url)
        return response
      })
      .catch((error) => {
        return error
      })
  },
  async logout({ commit }) {
    await this.$axios
      .$delete('/api/v1/auth/sign_out')
      .then((response) => {
        commit('setCurrentUser', null)
        commit('setCurrentUserAvatar', null)
        commit('setIsLoggedIn', false)
        this.$router.push('/')
        commit('flashMessage/setText', 'ログアウトしました', {
          root: true
        })
        commit('flashMessage/setType', 'success', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 5000)
        return response
      })
      .catch((error) => {
        return error
      })
  }
}
