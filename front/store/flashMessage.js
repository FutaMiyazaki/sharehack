export const state = () => ({
  text: '',
  status: false
})

export const getters = {
  text: (state) => state.text,
  status: (state) => state.status
}

export const mutations = {
  setText(state, text) {
    state.text = text
  },
  setStatus(state, bool) {
    state.status = bool
  }
}

export const actions = {
  showMessage({ commit }, { text, status }) {
    commit('setText', text)
    commit('setStatus', status)
    setTimeout(() => {
      commit('setStatus', !status)
    }, 5000)
  }
}
