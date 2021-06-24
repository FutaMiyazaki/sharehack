export const state = () => ({
  items: [],
  item: {}
})

export const getters = {
  items: (state) => state.items,
  item: (state) => state.item
}

export const mutations = {
  setItems(state, items) {
    state.items = items
  },
  setItem(state, item) {
    state.item = item
  }
}

export const actions = {
  async getItems({ commit }) {
    await this.$axios
      .$get('/api/v1/items')
      .then((response) => {
        commit('setItems', response)
        console.log('アイテム一覧の取得に成功')
        console.log(response)
      })
      .catch((error) => {
        console.log('アイテム一覧の取得に失敗')
        console.log(error)
      })
  }
}
