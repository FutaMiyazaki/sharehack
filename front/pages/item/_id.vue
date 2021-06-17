<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row>
      <v-col cols="12" sm="7">
        <v-img max-height="auto" max-width="100%" :src="item.image_url"></v-img>
        <v-row class="my-1">
          <v-col cols="6" align="left">
            <p class="my-auto text-caption">
              {{ $moment(item.created_at).format('YYYY/MM/DD HH:mm') }}
            </p>
          </v-col>
          <template v-if="currentUserId == item.user.id">
            <v-col cols="6" align="right">
              <nuxt-link
                :to="{ name: 'item-edit-id', params: { id: item.id } }"
              >
                編集する
              </nuxt-link>
            </v-col>
          </template>
        </v-row>
      </v-col>
      <v-col cols="12" sm="5">
        <v-row>
          <v-col cols="6" align="left">
            <v-btn text color="primary" :to="'/users/' + item.user.id">
              <v-icon>mdi-account-circle</v-icon>
              <p class="my-auto">{{ item.user.name }}</p>
            </v-btn>
          </v-col>
          <v-col cols="6" align="right">
            <v-btn icon>
              <v-icon>mdi-account-plus-outline</v-icon>
            </v-btn>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="6">
            <template v-if="isLoggedIn">
              <v-btn
                v-show="!isLiked"
                block
                rounded
                depressed
                @click="likeItem"
              >
                <v-icon>mdi-heart-outline</v-icon>
                <p class="my-auto mx-2">いいね!</p>
                <span class="font-weight-bold">{{ likeCount }}</span>
              </v-btn>
              <v-btn
                v-show="isLiked"
                block
                rounded
                outlined
                color="red darken-3"
                @click="dislikeItem"
              >
                <v-icon>mdi-heart</v-icon>
                <p class="my-auto mx-2">いいね!</p>
                <span class="font-weight-bold">{{ likeCount }}</span>
              </v-btn>
            </template>
            <template v-if="!isLoggedIn">
              <v-dialog v-model="dialog" width="500">
                <template v-slot:activator="{ on, attrs }">
                  <v-btn block rounded depressed v-bind="attrs" v-on="on">
                    <v-icon color="red darken-3">mdi-heart</v-icon>
                    <p class="my-auto mx-2">いいね!</p>
                    <span class="font-weight-bold">{{ likeCount }}</span>
                  </v-btn>
                </template>
                <v-card class="py-2">
                  <v-btn icon absolute right @click="dialog = false">
                    ✕
                  </v-btn>
                  <v-card-title
                    class="mt-2 px-0 justify-center font-weight-bold "
                  >
                    いいねするには、ログインが必要です
                  </v-card-title>
                  <v-divider class="mb-5" />
                  <v-card-text class="justify-center text-center">
                    いいねするには、ログインが必要です
                  </v-card-text>
                  <v-card-actions class="justify-center">
                    <v-btn
                      block
                      rounded
                      color="accent"
                      class="white--text font-weight-bold"
                      to="/users/login"
                    >
                      ログイン
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </template>
          </v-col>
          <v-col v-if="item.link != ''" cols="12" sm="6">
            <a
              :href="item.link"
              target="_blank"
              rel="noopener noreferrer"
              class="text-decoration-none"
            >
              <v-btn outlined block color="primary">
                <v-icon class="mr-3">mdi-open-in-new</v-icon>
                <p class="my-auto">販売サイトへ</p>
              </v-btn>
            </a>
          </v-col>
        </v-row>
        <div class="my-5 pa-3 rounded-lg secondary">
          <p style="white-space:pre-wrap;" v-text="item.description"></p>
        </div>
        <v-chip
          v-for="tag in tags"
          :key="tag.id"
          class="ma-2"
          color="primary"
          label
          outlined
          :to="'/tag/' + tag.id"
        >
          #{{ tag.name }}
        </v-chip>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" sm="7">
        <v-row>
          <v-col v-if="comments.length" cols="12">
            <div v-for="comment in comments" :key="comment.id" class="mb-5">
              <v-row>
                <v-col cols="6" class="my-auto">
                  <nuxt-link
                    :to="'/users/' + comment.user.id"
                    class="text-decoration-none"
                  >
                    {{ comment.user.name }}
                  </nuxt-link>
                  <span class="ml-3 text-caption">
                    {{ $moment(comment.created_at).format('YYYY/MM/DD HH:mm') }}
                  </span>
                </v-col>
                <v-col cols="6" align="right">
                  <v-dialog v-model="dialog" width="500">
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        v-if="currentUserId == comment.user.id"
                        text
                        color="warning"
                        v-bind="attrs"
                        v-on="on"
                      >
                        コメントを削除する
                      </v-btn>
                    </template>
                    <v-card class="py-2">
                      <v-btn
                        icon
                        absolute
                        right
                        class="d-block"
                        @click="dialog = false"
                      >
                        ✕
                      </v-btn>
                      <v-card-title
                        class="mt-2 px-0 justify-center font-weight-bold "
                      >
                        本当にコメントを削除しますか？
                      </v-card-title>
                      <v-divider class="mb-5" />
                      <v-card-text class="justify-center text-center">
                        ※この操作は取り消せません
                      </v-card-text>
                      <v-card-actions class="justify-center">
                        <v-btn
                          color="warning"
                          rounded
                          outlined
                          class="white--text font-weight-bold"
                          width="100px"
                          @click="dialog = false"
                        >
                          キャンセル
                        </v-btn>
                        <v-btn
                          rounded
                          color="warning"
                          class="white--text font-weight-bold"
                          width="100px"
                          @click="deleteComment(comment.id)"
                        >
                          OK
                        </v-btn>
                      </v-card-actions>
                    </v-card>
                  </v-dialog>
                </v-col>
              </v-row>
              <v-card rounded flat color="secondary" class="pa-5">{{
                comment.content
              }}</v-card>
            </div>
          </v-col>
          <v-col cols="12">
            <ValidationObserver ref="observer" v-slot="{ invalid }">
              <v-form ref="form" lazy-validation class="mt-5">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required|max:255"
                  mode="lazy"
                >
                  <v-textarea
                    v-model="commentText"
                    counter
                    auto-grow
                    outlined
                    rows="1"
                    background-color="secondary"
                    prepend-icon="mdi-text-box"
                    label="コメントを入力する"
                    :error-messages="errors"
                  />
                </ValidationProvider>
                <v-btn
                  rounded
                  color="primary"
                  class="white--text font-weight-bold d-block mx-auto"
                  :disabled="invalid"
                  @click="createComment"
                >
                  コメントする
                </v-btn>
              </v-form>
            </ValidationObserver>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'

export default {
  components: {
    PageHeader
  },
  data() {
    return {
      dialog: false,
      text: '',
      item: {
        user: {}
      },
      currentUserId: '',
      userEmail: '',
      tags: [],
      likeList: [],
      comments: [],
      commentText: ''
    }
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn'
    }),
    likeCount() {
      return this.likeList.length
    },
    isLiked() {
      if (this.likeList.length === 0) {
        return false
      } else {
        const liked = this.likeList.some(
          (like) => like.user_id === this.currentUserId
        )
        return liked
      }
    }
  },
  created() {
    this.$axios
      .get(`api/v1/items/${this.$route.params.id}`)
      .then((response) => {
        this.item = response.data
        this.tags = response.data.tags
        this.likeList = response.data.item_likes
        this.comments = response.data.item_comments
        this.text = this.item.name
        this.currentUserId = this.$store.getters[
          'authentication/currentUser'
        ].id
        console.log(this.tags)
      })
      .catch((error) => {
        return error
      })
  },
  methods: {
    async likeItem() {
      await this.$axios
        .$post('/api/v1/item_likes', {
          user_id: this.currentUserId,
          item_id: this.item.id
        })
        .then((response) => {
          this.likeList = response
          console.log(response)
        })
        .catch((error) => {
          return error
        })
    },
    async dislikeItem() {
      await this.$axios
        .delete('/api/v1/item_likes', {
          params: {
            user_id: this.currentUserId,
            item_id: this.item.id
          }
        })
        .then((response) => {
          this.likeList = response.data
          console.log(response)
        })
        .catch((error) => {
          return error
        })
    },
    async createComment() {
      await this.$axios
        .post('/api/v1/item_comments', {
          content: this.commentText,
          user_id: this.currentUserId,
          item_id: this.item.id,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          this.comments = response.data
          this.commentText = ''
        })
        .catch((error) => {
          return error
        })
    },
    async deleteComment(commentId) {
      await this.$axios
        .delete(`api/v1/item_comments/${commentId}`, {
          params: {
            user_id: this.currentUserId,
            item_id: this.item.id,
            uid: localStorage.getItem('uid')
          }
        })
        .then((response) => {
          this.comments = response.data
          this.dialog = false
          this.$refs.observer.reset()
        })
        .catch((error) => {
          return error
        })
    }
  }
}
</script>
