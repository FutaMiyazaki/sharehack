import { mount } from '@vue/test-utils'
import PageHeader from '~/components/layout/PageHeader.vue'

describe('PageHeader', () => {
  test('コンポーネントが存在する', () => {
    // Logoコンポーネントをマウントする
    const wrapper = mount(PageHeader)
    // expect()の中身がtrueだったらテスト合格
    expect(wrapper.exists()).toBeTruthy()
  })
})
