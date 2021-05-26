<template>
  <v-container class="pt-0 pb-10">
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
            v-model="item.price"
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
          @click="updateItem"
        >
          変更を保存する
        </v-btn>
      </v-form>
    </validation-observer>
    <v-divider class="my-8" />
    <v-dialog v-model="dialog" width="400px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn text color="red lighten-2" v-bind="attrs" v-on="on">
          投稿を削除する
        </v-btn>
      </template>

      <v-card>
        <v-card-title class="justify-center font-weight-bold">
          本当にこの投稿を削除しますか？
        </v-card-title>
        <v-divider class="mb-5" />
        <v-card-text class="justify-center font-weight-bold text-center">
          ※この操作は取り消せません
        </v-card-text>
        <v-card-actions class="justify-center">
          <template v-if="userEmail != guest">
            <v-btn rounded outlined width="100px" @click="dialog = false">
              キャンセル
            </v-btn>
            <v-btn
              rounded
              color="red"
              class="white--text font-weight-bold"
              width="100px"
              @click="deleteItem"
            >
              削除する
            </v-btn>
          </template>
          <template v-else>
            <v-btn
              rounded
              color="red"
              class="white--text"
              @click="dialog = false"
            >
              ゲストユーザーは投稿を削除できません
            </v-btn>
          </template>
        </v-card-actions>
      </v-card>
    </v-dialog>
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
      text: 'アイテム編集',
      dialog: false,
      userEmail: this.$store.getters['authentication/currentUser'].uid,
      guest: 'guest@sharehack.com',
      item: {
        name: '',
        description: '',
        link: '',
        price: ''
      }
    }
  },
  created() {
    this.$axios
      .get(`api/v1/items/${this.$route.params.id}`)
      .then((response) => {
        this.item = response.data
        console.log(response)
        console.log(this.item)
        console.log('アイテム情報の取得に成功')
      })
      .catch((error) => {
        console.log('アイテム情報の取得に失敗')
        console.log(error)
      })
  },
  methods: {
    async updateItem() {
      await this.$axios
        .patch(`api/v1/items/${this.$route.params.id}`, this.item, {
          headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client')
          }
        })
        .then((response) => {
          console.log(response)
          this.$router.push(`/item/${this.item.id}`)
          this.$store.dispatch(
            'flashMessage/showMessage',
            {
              text: '変更を保存しました',
              type: 'success',
              status: true
            },
            { root: true }
          )
          console.log('アイテムの編集に成功')
        })
        .catch((error) => {
          console.log('アイテムの編集に失敗')
          console.log(error)
          return error
        })
    },
    async deleteItem() {
      await this.$axios
        .delete(`api/v1/items/${this.$route.params.id}`, this.item, {
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
              text: 'アイテムを削除しました',
              type: 'success',
              status: true
            },
            { root: true }
          )
          this.$router.push('/')
          console.log('アイテムの削除に成功')
        })
        .catch((error) => {
          console.log('アイテムの削除に失敗')
          console.log(error)
          return error
        })
    }
  }
}
</script>
