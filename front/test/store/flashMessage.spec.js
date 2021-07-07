const Vuex = require('vuex')
const { createLocalVue } = require('@vue/test-utils')
const cloneDeep = require('lodash.clonedeep')
const messages = require('../../store/flashMessage')

const localVue = createLocalVue()
localVue.use(Vuex)

describe('フラッシュメッセージ', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(messages))
  })

  describe('actions', () => {
    test('フラッシュメッセージが表示されるか', async () => {
      const payload = {
        text: 'ログインに成功しました',
        type: 'success',
        status: 'true'
      }
      await store.dispatch('showMessage', payload)
      expect(store.getters.text).toEqual(payload.text)
    })
  })
})
