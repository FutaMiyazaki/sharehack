export const state = () => ({
  text: '',
  type: '',
  status: false
})

export const getters = {
  text: (state) => state.text,
  type: (state) => state.type,
  status: (state) => state.status
}

export const mutations = {
  setText(state, text) {
    state.text = text
  },
  setType(state, type) {
    state.type = type
  },
  setStatus(state, bool) {
    state.status = bool
  }
}

export const actions = {
  showMessage({ commit }, { text, type, status }) {
    commit('setText', text)
    commit('setType', type)
    commit('setStatus', status)
    setTimeout(() => {
      commit('setStatus', !status)
    }, 2000)
  }
}
