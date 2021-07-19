<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <validation-observer v-slot="{ invalid }">
      <v-form ref="form" lazy-validation class="mt-5">
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel label-title="アイテム名を入力" />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <TextField
              v-model="name"
              rules="required|max:20"
              label="アイテム名"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel
              label-title="画像をアップロード"
              label-text="画像形式：JPEG/PNG"
              label-sub-text="容量：5MB以内"
            />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <validation-provider
              v-slot="{ errors, validate }"
              rules="required|size:5000"
            >
              <v-file-input
                v-model="previewImage"
                prepend-icon=""
                outlined
                rows="1"
                background-color="secondary"
                :value="image"
                accept="image/*"
                truncate-length="25"
                label="画像をアップロード"
                :error-messages="errors"
                show-size
                @input="validate($event)"
                @change="setImage"
              />
            </validation-provider>
            <v-img
              v-if="previewImageUrl"
              aspect-ratio="1"
              alt="投稿画像のプレビュー表示"
              :src="previewImageUrl"
              class="mb-5"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel label-title="コメントを入力" label-text="300文字以内" />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <TextArea
              v-model="description"
              rules="required|max:300"
              label="コメント"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel
              label-title="商品URLを入力"
              :display="false"
              label-text="Amazonなどの商品URLを入力できます"
            />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <validation-provider
              v-slot="{ errors }"
              :rules="{ regex: /https?:\/\/[\w/:%#\$&\?\(\)~\.=\+\-]+/ }"
              mode="lazy"
            >
              <v-text-field
                v-model="link"
                type="url"
                outlined
                rows="1"
                background-color="secondary"
                label="商品URL"
                :error-messages="errors"
              />
            </validation-provider>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel
              label-title="タグを入力"
              label-text="6つまで追加できます"
            />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <validation-provider
              v-slot="{ errors }"
              rules="required|max:15"
              mode="lazy"
            >
              <v-combobox
                v-model="tags"
                :items="tagLists"
                :search-input.sync="search"
                hide-selected
                hint="自身でタグを作成することもできます"
                label="タグ"
                auto-grow
                outlined
                chips
                deletable-chips
                item-color="primary"
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
              v-if="!loadShow"
              block
              rounded
              color="primary"
              class="white--text font-weight-bold d-block mx-auto"
              :disabled="invalid"
              @click="sendItem"
            >
              アイテムを投稿する
            </v-btn>
            <Loading v-show="loadShow" />
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
import Loading from '~/components/layout/Loading.vue'

export default {
  components: {
    PageHeader,
    FormLabel,
    TextField,
    TextArea,
    Loading
  },
  middleware: 'unAuthenticated',
  data() {
    return {
      text: 'アイテムを投稿する',
      name: '',
      image: null,
      previewImage: null,
      description: '',
      link: '',
      tags: '',
      tagLists: [],
      search: null,
      loadShow: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    }),
    previewImageUrl() {
      if (this.previewImage === null) {
        return false
      } else {
        return URL.createObjectURL(this.previewImage)
      }
    }
  },
  watch: {
    tags(val) {
      if (val.length > 6) {
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
    async sendItem() {
      this.loadShow = true
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
      data.append('item[tags]', this.tags)
      data.append('item[user_id]', this.currentUser.id)
      data.append('item[uid]', localStorage.getItem('uid'))
      await this.$axios
        .post('api/v1/items', data, config)
        .then((response) => {
          this.loadShow = false
          this.$router.push(`/item/${response.data.id}`)
          this.showMessage({
            text: '投稿に成功しました',
            status: true
          })
        })
        .catch((error) => {
          this.loadShow = false
          this.showMessage({
            text: '投稿に失敗しました',
            status: true
          })
          return error
        })
    }
  },
  head() {
    return {
      title: '新規投稿'
    }
  }
}
</script>
