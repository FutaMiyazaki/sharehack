<template>
  <v-container class="pt-0 pb-10">
    <PageHeader :text="text" />
    <ValidationObserver v-slot="{ invalid }">
      <v-form ref="form" lazy-validation class="mt-5">
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel label-title="アイテム名を記入" />
          </v-col>
          <v-col cols="12" sm="8">
            <ValidationProvider
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
            </ValidationProvider>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel
              label-title="画像をアップロードする"
              label-text="画像形式：JPEG/PNG"
              label-sub-text="容量：10MB以内"
            />
          </v-col>
          <v-col cols="12" sm="8">
            <ValidationProvider v-slot="{ validate }" rules="required">
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
            </ValidationProvider>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel label-title="説明を記入する" label-text="300文字以内" />
          </v-col>
          <v-col cols="12" sm="8">
            <ValidationProvider
              v-slot="{ errors }"
              rules="required|max:300"
              mode="lazy"
            >
              <v-textarea
                v-model="item.description"
                counter
                auto-grow
                outlined
                rows="3"
                background-color="secondary"
                prepend-icon="mdi-text-box"
                label="説明"
                :error-messages="errors"
              />
            </ValidationProvider>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel label-title="商品URLを追加する" :display="false" />
          </v-col>
          <v-col cols="12" sm="8">
            <ValidationProvider
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
            </ValidationProvider>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4"
            ><FormLabel label-title="参考価格を追加する" :display="false"
          /></v-col>
          <v-col cols="12" sm="8">
            <ValidationProvider
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
            </ValidationProvider>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel label-title="タグ" label-text="5つまで追加できます" />
          </v-col>
          <v-col cols="12" sm="8">
            <validation-provider
              v-slot="{ errors }"
              rules="required"
              mode="lazy"
            >
              <v-combobox
                v-model="tags"
                :items="tagLists"
                :search-input.sync="search"
                hide-selected
                hint="自身でタグを作成することもできます"
                label="タグを追加する"
                auto-grow
                outlined
                chips
                deletable-chips
                item-color="primary"
                prepend-icon="mdi-tag"
                multiple
                persistent-hint
                small-chips
                :error-messages="errors"
              >
                <template v-slot:no-data>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>
                        <strong>{{ search }}</strong
                        >に一致するタグは見つかりません。自分で入力することも可能です。
                      </v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                </template>
              </v-combobox>
            </validation-provider>
          </v-col>
        </v-row>
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
    </ValidationObserver>
    <v-divider class="my-8" />
    <v-dialog v-model="dialog" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-btn text color="red lighten-2" v-bind="attrs" v-on="on">
          投稿を削除する
        </v-btn>
      </template>

      <v-card class="py-2">
        <v-btn icon absolute right @click="dialog = false">
          ✕
        </v-btn>
        <v-card-title class="mt-2 px-0 justify-center font-weight-bold ">
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
import FormLabel from '~/components/layout/FormLabel.vue'

export default {
  components: {
    PageHeader,
    FormLabel
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
        price: '',
        tags: '',
        tagLists: [],
        search: null
      }
    }
  },
  watch: {
    tags(val) {
      if (val.length > 5) {
        this.$nextTick(() => this.tags.pop())
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
    this.$axios
      .get('api/v1/tags')
      .then((response) => {
        const tagData = response.data
        this.tagLists = tagData.map(function(tagData) {
          return tagData.name
        })
      })
      .catch((error) => {
        return error
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
      data.append('item[tags]', this.tags)
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
          this.$router.push(`/users/${this.currentUserId}`)
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
