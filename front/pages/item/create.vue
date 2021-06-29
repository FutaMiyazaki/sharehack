<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <validation-observer v-slot="{ invalid }">
      <v-form ref="form" lazy-validation class="mt-5">
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel label-title="アイテム名を記入" />
          </v-col>
          <v-col cols="12" sm="8">
            <TextField
              v-model="name"
              rules="required|max:20"
              icon="mdi-pencil"
              label="アイテム名"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel
              label-title="画像をアップロードする"
              label-text="画像形式：JPEG/PNG"
              label-sub-text="容量：5MB以内"
            />
          </v-col>
          <v-col cols="12" sm="8">
            <validation-provider
              v-slot="{ errors, validate }"
              rules="required|size:5000"
            >
              <v-file-input
                outlined
                rows="1"
                background-color="secondary"
                :value="image"
                accept="image/*"
                truncate-length="25"
                prepend-icon="mdi-camera"
                label="画像をアップロードする"
                :error-messages="errors"
                show-size
                @input="validate($event)"
                @change="setImage"
              />
            </validation-provider>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel label-title="説明を記入する" label-text="300文字以内" />
          </v-col>
          <v-col cols="12" sm="8">
            <TextArea
              v-model="description"
              rules="required|max:300"
              icon="mdi-text-box"
              label="説明"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4">
            <FormLabel label-title="商品URLを追加する" :display="false" />
          </v-col>
          <v-col cols="12" sm="8">
            <TextField
              v-model.trim="link"
              type="url"
              icon="mdi-link"
              label="商品URL"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4"
            ><FormLabel label-title="参考価格を追加する" :display="false"
          /></v-col>
          <v-col cols="12" sm="8">
            <TextField
              v-model.number="price"
              type="number"
              rules="integer"
              icon="mdi-currency-usd"
              label="参考価格"
            />
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
        <v-row justify="center">
          <v-col cols="12" sm="4">
            <v-btn
              block
              rounded
              color="primary"
              class="white--text font-weight-bold d-block mx-auto"
              :disabled="invalid"
              @click="createItem"
            >
              アイテムを投稿する
            </v-btn>
          </v-col>
        </v-row>
      </v-form>
    </validation-observer>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import FormLabel from '~/components/layout/FormLabel.vue'
import TextField from '~/components/input/TextField.vue'
import TextArea from '~/components/input/TextArea.vue'

export default {
  components: {
    PageHeader,
    FormLabel,
    TextField,
    TextArea
  },
  data() {
    return {
      text: 'アイテムを投稿する',
      name: '',
      image: null,
      description: '',
      link: '',
      price: '',
      tags: '',
      tagLists: [],
      search: null
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
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
    ...mapActions({
      showMessage: 'flashMessage/showMessage'
    }),
    setImage(e) {
      this.image = e
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
      data.append('item[tags]', this.tags)
      data.append('item[user_id]', this.currentUser.id)
      await this.$axios
        .post('api/v1/items', data, config)
        .then((response) => {
          console.log(response)
          this.$router.push(`/item/${response.data.id}`)
          this.showMessage({
            text: '投稿に成功しました。',
            type: 'success',
            status: true
          })
        })
        .catch((error) => {
          this.showMessage({
            text: '投稿に失敗しました。',
            type: 'error',
            status: true
          })
          return error
        })
    }
  }
}
</script>
