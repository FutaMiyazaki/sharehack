<template>
  <v-container class="pt-0 pb-10">
    <PageHeader :text="text" />
    <ValidationObserver v-slot="{ invalid }">
      <v-form ref="form" lazy-validation class="mt-5">
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel label-title="アイテム名を変更" />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <TextField
              v-model="item.name"
              rules="required|max:30"
              label="アイテム名"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel
              label-title="画像を変更"
              label-text="画像形式：JPEG/PNG"
              label-sub-text="容量：5MB以内"
            />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <p class="mb-3 text-caption red--text">
              ※新たに画像をアップロードしない場合は変更されません
            </p>
            <ValidationProvider v-slot="{ errors, validate }" rules="size:5000">
              <v-file-input
                v-model="previewImage"
                prepend-icon=""
                outlined
                rows="1"
                background-color="secondary"
                :value="item.image"
                accept="image/*"
                truncate-length="25"
                label="画像をアップロードする"
                :error-messages="errors"
                show-size
                @input="validate($event)"
                @change="setImage"
              />
            </ValidationProvider>
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
            <FormLabel label-title="説明を変更" label-text="300文字以内" />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <TextArea
              v-model="item.description"
              rules="required|max:300"
              label="説明"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel
              label-title="商品URLを変更"
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
                v-model="item.link"
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
            <FormLabel label-title="タグ" label-text="6つまで追加できます" />
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
                label="タグを追加する"
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
              @click="updateItem"
            >
              変更を保存する
            </v-btn>
            <Loading v-show="loadShow" />
          </v-col>
        </v-row>
      </v-form>
    </ValidationObserver>
    <v-divider class="my-8" />
    <v-dialog v-model="dialog" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-row justify="center">
          <v-col cols="12" sm="4" class="text-center">
            <v-btn text rounded color="warning" v-bind="attrs" v-on="on">
              投稿を削除する
            </v-btn>
          </v-col>
        </v-row>
      </template>
      <v-card class="py-2">
        <v-card-actions class="px-2 py-0">
          <v-icon class="ml-auto" @click="dialog = false">
            mdi-close
          </v-icon>
        </v-card-actions>
        <v-card-title class="pt-1 justify-center text-subtitle-1">
          本当にこの投稿を削除しますか？
        </v-card-title>
        <v-divider class="mb-5" />
        <v-card-text class="text-center text-subtitle-2">
          ※この操作は取り消せません
        </v-card-text>
        <v-card-actions class="justify-center pb-5">
          <template v-if="currentUser && currentUser.email != guestUserEmail">
            <v-btn
              rounded
              depressed
              class="font-weight-bold"
              width="100px"
              @click="dialog = false"
            >
              キャンセル
            </v-btn>
            <v-btn
              v-if="!loadShow"
              rounded
              color="red"
              class="white--text font-weight-bold"
              width="100px"
              @click="deleteItem"
            >
              削除する
            </v-btn>
            <Loading v-show="loadShow" />
          </template>
          <template v-else>
            <p
              color="warning"
              class="text-center red--text text-decoration-underline"
              @click="dialog = false"
            >
              ゲストユーザーのため削除できません
            </p>
          </template>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-row justify="center">
      <v-col cols="12" sm="4" class="text-center">
        <LinkButton
          :link="'/item/' + item.id"
          text="投稿ページに戻る"
          icon="chevron-right"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import FormLabel from '~/components/layout/FormLabel.vue'
import TextField from '~/components/input/TextField.vue'
import TextArea from '~/components/input/TextArea.vue'
import Loading from '~/components/layout/Loading.vue'
import LinkButton from '~/components/layout/LinkButton.vue'

export default {
  components: {
    PageHeader,
    FormLabel,
    TextField,
    TextArea,
    Loading,
    LinkButton
  },
  middleware: 'unAuthenticated',
  validate({ params }) {
    return !isNaN(+params.id)
  },
  data() {
    return {
      text: 'アイテム編集',
      dialog: false,
      guestUserEmail: 'guest@sharehack.com',
      item: {
        name: '',
        image: null,
        description: '',
        link: ''
      },
      previewImage: null,
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
      .get(`api/v1/items/${this.$route.params.id}`)
      .then((response) => {
        this.item = response.data
        for (let i = 0; i < this.item.tags.length; i++) {
          this.tags += this.item.tags[i].name + ','
        }
        this.tags = this.tags.slice(0, -1)
        this.tags = this.tags.split(',')
      })
      .catch((error) => {
        return error
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
    ...mapActions({
      showMessage: 'flashMessage/showMessage'
    }),
    setImage(e) {
      this.item.image = e
    },
    async updateItem() {
      this.loadShow = true
      const data = new FormData()
      const config = {
        headers: {
          'content-type': 'multipart/form-data'
        }
      }
      data.append('item[name]', this.item.name)
      data.append('item[description]', this.item.description)
      data.append('item[link]', this.item.link)
      data.append('item[tags]', this.tags)
      data.append('item[user_id]', this.currentUser.id)
      data.append('item[uid]', localStorage.getItem('uid'))
      if (this.item.image) {
        data.append('item[picture]', this.item.image)
      }
      await this.$axios
        .patch(`api/v1/items/${this.$route.params.id}`, data, config)
        .then((response) => {
          this.loadShow = false
          this.$router.push(`/item/${response.data.id}`)
          this.showMessage({
            text: '編集に成功しました',
            type: 'success',
            status: true
          })
        })
        .catch((error) => {
          this.loadShow = false
          this.showMessage({
            text: '編集に失敗しました',
            type: 'error',
            status: true
          })
          return error
        })
    },
    async deleteItem() {
      this.loadShow = true
      await this.$axios
        .delete(`api/v1/items/${this.$route.params.id}`, {
          params: {
            user_id: this.currentUser.id,
            uid: localStorage.getItem('uid')
          }
        })
        .then((response) => {
          this.loadShow = false
          this.$router.push(`/users/${this.currentUser.id}`)
          this.showMessage({
            text: '投稿を削除しました',
            status: true
          })
        })
        .catch((error) => {
          this.loadShow = false
          this.showMessage({
            text: '削除に失敗しました',
            status: true
          })
          return error
        })
    }
  },
  head() {
    return {
      title: '投稿を編集する'
    }
  }
}
</script>
