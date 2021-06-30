<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row>
      <v-col cols="12" sm="7">
        <v-img aspect-ratio="1" :src="item.image_url" />
        <v-row class="my-1">
          <v-col cols="6" align="left">
            <p class="my-auto text-subtitle-2">
              <v-icon small>mdi-clock-outline</v-icon>
              {{ $moment(item.created_at).format('YYYY/MM/DD HH:mm') }}
            </p>
          </v-col>
          <template v-if="currentUser && currentUser.id == item.user.id">
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
          <v-col cols="12" sm="6" align="left">
            <UserInformation
              :user-id="item.user.id"
              :user-avatar-url="item.user.avatar_url"
              :user-name="item.user.name"
            />
          </v-col>
          <v-col cols="12" sm="6" align="right">
            <template
              v-if="
                isLoggedIn && currentUser && currentUser.id !== item.user.id
              "
            >
              <FollowButton :followers="followers" :user-id="item.user.id" />
            </template>
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
              <v-dialog v-model="likeDialog" width="500">
                <template v-slot:activator="{ on, attrs }">
                  <v-btn block rounded depressed v-bind="attrs" v-on="on">
                    <v-icon color="red darken-3">mdi-heart</v-icon>
                    <p class="my-auto mx-2">いいね!</p>
                    <span class="font-weight-bold">{{ likeCount }}</span>
                  </v-btn>
                </template>
                <v-card class="py-2">
                  <v-btn icon absolute right @click="likeDialog = false">
                    ✕
                  </v-btn>
                  <v-card-title
                    class="mt-2 px-0 pt-5 justify-center font-weight-bold "
                  >
                    いいね!には、ログインが必要です
                  </v-card-title>
                  <v-divider class="mb-5" />
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
          label
          outlined
          @click="toTagItems(tag.id)"
        >
          <v-icon small class="mr-1">mdi-tag</v-icon>{{ tag.name }}
        </v-chip>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" sm="7">
        <v-row>
          <v-col cols="12">
            <p v-if="!comments.length">この投稿にコメントはありません</p>
          </v-col>
          <v-col v-if="comments.length" cols="12">
            <div v-for="comment in comments" :key="comment.id" class="mb-5">
              <v-row>
                <v-col cols="9">
                  <UserInformation
                    :user-id="comment.user.id"
                    :user-avatar-url="comment.user.avatar_url"
                    :user-name="comment.user.name"
                  />
                  <div class="text-caption">
                    <v-icon small>mdi-clock-outline</v-icon>
                    {{ $moment(comment.created_at).format('YYYY/MM/DD HH:mm') }}
                  </div>
                </v-col>
                <v-col cols="3" align="right">
                  <v-dialog v-model="dialog" width="500">
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        v-if="currentUser && currentUser.id == comment.user.id"
                        text
                        rounded
                        color="warning"
                        v-bind="attrs"
                        v-on="on"
                      >
                        削除する
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
                          rounded
                          depressed
                          class="font-weight-bold"
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
          <v-col v-if="isLoggedIn" cols="12">
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
                <v-row justify="center">
                  <v-col cols="12" sm="6">
                    <v-btn
                      block
                      rounded
                      color="primary"
                      class="white--text font-weight-bold d-block mx-auto"
                      :disabled="invalid"
                      @click="createComment"
                    >
                      コメントする
                    </v-btn>
                  </v-col>
                </v-row>
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
import UserInformation from '~/components/user/UserInformation.vue'
import FollowButton from '~/components/layout/FollowButton.vue'

export default {
  components: {
    PageHeader,
    UserInformation,
    FollowButton
  },
  data() {
    return {
      dialog: false,
      likeDialog: false,
      text: '',
      item: {
        user: {}
      },
      userEmail: '',
      tags: [],
      likeList: [],
      followers: [],
      comments: [],
      commentText: ''
    }
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn',
      currentUser: 'authentication/currentUser'
    }),
    likeCount() {
      return this.likeList.length
    },
    isLiked() {
      if (this.likeList.length === 0) {
        return false
      } else {
        const liked = this.likeList.some(
          (like) => like.user_id === this.currentUser.id
        )
        return liked
      }
    },
    isFollowed() {
      if (this.followers.length === 0) {
        return false
      } else {
        const followed = this.followers.some(
          (follow) => follow.id === this.currentUser?.id
        )
        return followed
      }
    }
  },
  created() {
    this.$axios
      .get(`api/v1/items/${this.$route.params.id}`)
      .then((response) => {
        this.item = response.data
        this.tags = this.item.tags
        this.likeList = this.item.item_likes
        this.followers = this.item.user.followers
        this.comments = this.item.item_comments
        this.text = this.item.name
        console.log(response)
      })
      .catch((error) => {
        return error
      })
  },
  methods: {
    toTagItems(tagId) {
      this.$router.push({
        path: `/tag/${tagId}`,
        query: { keyword: this.keyword, page: 1 }
      })
    },
    async likeItem() {
      await this.$axios
        .$post('/api/v1/item_likes', {
          user_id: this.currentUser.id,
          item_id: this.item.id,
          uid: localStorage.getItem('uid')
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
            user_id: this.currentUser.id,
            item_id: this.item.id,
            uid: localStorage.getItem('uid')
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
          user_id: this.currentUser.id,
          item_id: this.item.id,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          this.comments = response.data
          this.commentText = ''
          this.$refs.observer.reset()
        })
        .catch((error) => {
          return error
        })
    },
    async deleteComment(commentId) {
      await this.$axios
        .delete(`api/v1/item_comments/${commentId}`, {
          params: {
            user_id: this.currentUser.id,
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
