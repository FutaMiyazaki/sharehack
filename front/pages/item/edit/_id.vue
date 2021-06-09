<template>
  <v-container class="pt-0 pb-10">
    <PageHeader :text="text" />
    <validation-observer v-slot="{ invalid }">
      <v-form ref="form" lazy-validation class="mt-5">
        <validation-provider
          v-slot="{ errors }"
          rules="required|max:30"
          mode="lazy"
        >
          <v-text-field
            v-model="item.name"
            counter
            auto-grow
            outlined
            rows="1"
            background-color="secondary"
            prepend-icon="mdi-pencil"
            label="アイテム名"
            :error-messages="errors"
          />
        </validation-provider>
        <validation-provider v-slot="{ validate }" rules="required">
          <v-file-input
            outlined
            rows="1"
            background-color="secondary"
            :value="item.image"
            accept="image/*"
            truncate-length="25"
            prepend-icon="mdi-camera"
            label="画像をアップロードする"
            show-size
            @input="validate($event)"
            @change="setImage"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          rules="required|max:300"
          mode="lazy"
        >
          <v-textarea
            v-model="item.description"
            counter
            auto-grow
            outlined
            rows="1"
            background-color="secondary"
            prepend-icon="mdi-text-box"
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
            counter
            auto-grow
            outlined
            rows="1"
            background-color="secondary"
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
            counter
            auto-grow
            outlined
            rows="1"
            background-color="secondary"
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
        <v-card-actions class="justify-center pb-5">
          <template v-if="currentUserId != guestUserId">
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
              class="white--text font-weight-bold"
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
      currentUserId: this.$store.getters['authentication/currentUser'].id,
      guestUserId: '19',
      item: {
        name: '',
        image: null,
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
        console.log('アイテム情報の取得に成功')
        console.log(response)
      })
      .catch((error) => {
        console.log('アイテム情報の取得に失敗')
        console.log(error)
      })
  },
  methods: {
    setImage(e) {
      this.item.image = e
    },
    async updateItem() {
      const data = new FormData()
      const config = {
        headers: {
          'content-type': 'multipart/form-data'
        }
      }
      data.append('item[name]', this.item.name)
      data.append('item[image]', this.item.image)
      data.append('item[description]', this.item.description)
      data.append('item[link]', this.item.link)
      data.append('item[price]', this.item.price)
      data.append('item[user_id]', this.currentUserId)
      await this.$axios
        .patch(`api/v1/items/${this.$route.params.id}`, data, config)
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
      const data = new FormData()
      const config = {
        headers: {
          'content-type': 'multipart/form-data',
          uid: localStorage.getItem('uid')
        }
      }
      data.append('item[name]', this.item.name)
      data.append('item[image]', this.item.image)
      data.append('item[description]', this.item.description)
      data.append('item[link]', this.item.link)
      data.append('item[price]', this.item.price)
      await this.$axios
        .delete(`api/v1/items/${this.$route.params.id}`, this.item, config)
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
