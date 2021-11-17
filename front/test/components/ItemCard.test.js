import Vuetify from 'vuetify'
import { mount, RouterLinkStub } from '@vue/test-utils'
import ItemCard from '@/components/item/ItemCard'

const vuetify = new Vuetify()

const wrapper = mount(ItemCard, {
  propsData: props,
  vuetify
})

describe('ItemCard', () => {
  const props = {
    item: {
      id: 1,
      name: '便利アイテム',
      user: {
        name: 'Miya'
      }
    }
  }

  test('アイテム名が表示されている', () => {
    expect(wrapper.text()).toBe(props.item.name)
  })

  test('ユーザー名が表示されている', () => {
    expect(wrapper.text()).toBe(props.item.user.name)
  })

  test('リンク先がアイテム詳細ページへのURLになっている', () => {
    expect(wrapper.find(RouterLinkStub).props().to).toBe(`/item/${props.item.id}`)
  })
})
