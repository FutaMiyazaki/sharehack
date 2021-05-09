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
        console.log('ログイン成功')
        return response
      })
      .catch((error) => {
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
        return response
      })
      .catch((error) => {
        console.log('ログアウト失敗')
        console.log(error)
        return error
      })
  }
}
