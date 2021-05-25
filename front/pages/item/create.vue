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
            v-model="item.name"
            prepend-icon="mdi-pencil"
            label="アイテム名"
            :error-messages="errors"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          rules="required|max:300"
          mode="lazy"
        >
          <v-textarea
            v-model="item.description"
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
            v-model="item.link"
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
            v-model.number="item.price"
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
      item: {
        name: '',
        description: '',
        link: '',
        price: '',
        user_id: this.$store.getters['authentication/currentUser'].id
      }
    }
  },
  methods: {
    async createItem() {
      await this.$axios
        .post('api/v1/items', this.item, {
          headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client')
          }
        })
        .then((response) => {
          console.log(response)
          this.$store.dispatch(
            'flashMessage/showMessage',
            {
              text: 'アイテムを投稿しました',
              type: 'success',
              status: true
            },
            { root: true }
          )
          this.$router.push('/')
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
