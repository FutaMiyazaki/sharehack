<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <validation-observer v-slot="{ invalid }">
      <v-form ref="form" lazy-validation>
        <validation-provider
          v-slot="{ errors }"
          rules="required|max:30"
          mode="lazy"
        >
          <v-text-field
            v-model="name"
            prepend-icon="mdi-pencil"
            label="アイテム名"
            :error-messages="errors"
          />
        </validation-provider>
        <v-file-input
          truncate-length="25"
          prepend-icon="mdi-file-image"
          label="画像をアップロードする"
          @change="setImage"
        />
        <validation-provider
          v-slot="{ errors }"
          rules="required|max:300"
          mode="lazy"
        >
          <v-textarea
            v-model="description"
            prepend-icon="mdi-text-box"
            type="email"
            label="説明"
            :error-messages="errors"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          rules="regex:/\Ahttps:\/\/[^\n]+\Z/"
          mode="lazy"
        >
          <v-text-field
            v-model="link"
            prepend-icon="mdi-link"
            label="商品URL"
            :error-messages="errors"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          rules="required|integer"
          mode="lazy"
        >
          <v-text-field
            v-model.number="price"
            prepend-icon="mdi-currency-usd"
            label="参考価格"
            :error-messages="errors"
          />
        </validation-provider>
        <v-btn
          rounded
          width="40vw"
          color="primary"
          class="white--text font-weight-bold d-block mx-auto"
          :disabled="invalid"
          @click="createItem"
        >
          アイテムを投稿する
        </v-btn>
      </v-form>
    </validation-observer>
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'

export default {
  components: {
    PageHeader
  },
  data() {
    return {
      text: 'アイテムを投稿する',
      name: '',
      image: null,
      description: '',
      link: '',
      price: ''
    }
  },
  methods: {
    setImage(e) {
      this.image = e
      console.log(this.image)
    },
    async createItem() {
      const data = new FormData()
      const config = {
        headers: {
          'content-type': 'multipart/form-data'
        }
      }
      data.append('item[name]', this.name)
      data.append('item[image]', this.image)
      data.append('item[description]', this.description)
      data.append('item[link]', this.link)
      data.append('item[price]', this.price)
      data.append(
        'item[user_id]',
        this.$store.getters['authentication/currentUser'].id
      )
      data.append('item[uid]', localStorage.getItem('uid'))
      await this.$axios
        .post('api/v1/items', data, config)
        .then((response) => {
          console.log(response)
          this.$router.push(`/item/${response.data.id}`)
          this.$store.dispatch(
            'flashMessage/showMessage',
            {
              text: 'アイテムを投稿しました',
              type: 'success',
              status: true
            },
            { root: true }
          )
          console.log('アイテムの投稿に成功')
        })
        .catch((error) => {
          console.log('アイテムの投稿に失敗')
          console.log(error)
          return error
        })
    }
  }
}
</script>
