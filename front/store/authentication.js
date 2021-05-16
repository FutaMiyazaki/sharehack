export const state = () => ({
  isLoggedIn: false,
  currentUser: null,
  isAdmin: false
})

export const getters = {
  isLoggedIn: (state) => state.isLoggedIn,
  currentUser: (state) => state.currentUser,
  isAdmin: (state) => state.isAdmin
}

export const mutations = {
  setIsLoggedIn(state, bool) {
    state.isLoggedIn = bool
  },
  setCurrentUser(state, user) {
    state.currentUser = user
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
        console.log(response)
        commit('setCurrentUser', response.data)
        commit('setIsLoggedIn', true)
        this.$router.push('/')
        commit('flashMessage/setText', '新規登録しました。', { root: true })
        commit('flashMessage/setType', 'success', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 2000)
        console.log('新規登録成功')
        return response
      })
      .catch((error) => {
        console.log(error)
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
        console.log(response)
        commit('setCurrentUser', response.data)
        commit('setIsLoggedIn', true)
        this.$router.push('/')
        commit('flashMessage/setText', 'ログインしました。', { root: true })
        commit('flashMessage/setType', 'success', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 2000)
        console.log('ログイン成功')
        return response
      })
      .catch((error) => {
        commit(
          'flashMessage/setText',
          'ログインできませんでした。入力内容に誤りがあります',
          {
            root: true
          }
        )
        commit('flashMessage/setType', 'error', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 2000)
        console.log('ログイン失敗')
        console.log(error)
        return error
      })
  },
  async logout({ commit }) {
    await this.$axios
      .$delete('/api/v1/auth/sign_out')
      .then((response) => {
        commit('setCurrentUser', null)
        commit('setIsLoggedIn', false)
        this.$router.push('/')
        commit('flashMessage/setText', 'ログアウトしました。', {
          root: true
        })
        commit('flashMessage/setType', 'success', { root: true })
        commit('flashMessage/setStatus', true, { root: true })
        setTimeout(() => {
          commit('flashMessage/setStatus', false, { root: true })
        }, 2000)
        return response
      })
      .catch((error) => {
        console.log('ログアウト失敗')
        console.log(error)
        return error
      })
  }
}
