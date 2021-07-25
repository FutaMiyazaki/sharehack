<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row>
      <v-col cols="12" md="7">
        <v-img aspect-ratio="1" :src="item.image_url" />
        <v-row class="my-1">
          <v-col cols="7" align="left">
            <p class="my-auto text-subtitle-2">
              <span class="text-caption">
                {{ $moment(item.created_at).format('YYYY/MM/DD HH:mm') }}
              </span>
            </p>
          </v-col>
          <template v-if="isLoggedIn && currentUser.id == item.user.id">
            <v-col cols="5" align="right">
              <nuxt-link
                :to="{ name: 'item-edit-id', params: { id: item.id } }"
              >
                編集する
              </nuxt-link>
            </v-col>
          </template>
        </v-row>
      </v-col>
      <v-col cols="12" md="5">
        <v-row>
          <v-col cols="12" sm="7" align="left">
            <UserInformation
              :user-id="item.user.id"
              :user-avatar-url="item.user.avatar_url"
              :user-name="item.user.name"
            />
          </v-col>
          <v-col cols="12" sm="5" align="right">
            <template v-if="isLoggedIn && currentUser.id !== item.user.id">
              <FollowButton :followers="followers" :user-id="item.user.id" />
            </template>
            <template v-if="!isLoggedIn">
              <PleaseLoginDialog
                btn-color="primary"
                btn-icon="mdi-account-plus"
                btn-text="フォローする"
              />
            </template>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="6">
            <template v-if="isLoggedIn">
              <v-btn
                v-show="!isLiked && !likeLoadShow"
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
                v-show="isLiked && !likeLoadShow"
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
              <Loading v-show="likeLoadShow" />
            </template>
            <template v-if="!isLoggedIn">
              <PleaseLoginDialog
                btn-icon-color="red darken-3"
                btn-icon="mdi-heart"
                btn-text="いいね!"
                :like-count="likeCount"
              />
            </template>
          </v-col>
          <v-col v-if="item.link != ''" cols="12" sm="6">
            <ItemLinkButton :item-link="item.link" />
          </v-col>
        </v-row>
        <div class="my-5 pa-3 rounded-lg secondary">
          <p style="white-space:pre-wrap;" v-text="item.description"></p>
        </div>
        <template v-if="item.topic">
          <TopicCard :topic="item.topic" />
        </template>
        <v-row>
          <v-col
            v-for="tag in tags"
            :key="`tag-${tag.id}`"
            cols="12"
            md="6"
            class="py-1"
          >
            <TagLinkCard :tag-id="tag.id" :tag-name="tag.name" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" md="7">
        <v-row>
          <v-col cols="12">
            <v-banner icon="mdi-comment-multiple-outline">コメント</v-banner>
          </v-col>
          <template v-if="!comments.length">
            <NoContentDisplay icon="" text="まだコメントがありません" />
          </template>
          <v-col v-if="comments.length" cols="12">
            <div v-for="comment in comments" :key="comment.id" class="mb-5">
              <v-row>
                <v-col cols="12" class="px-0 pb-0">
                  <UserInformation
                    :user-id="comment.user.id"
                    :user-avatar-url="comment.user.avatar_url"
                    :user-name="comment.user.name"
                  />
                </v-col>
                <v-col cols="6" align="left" class="pt-0">
                  <span class="text-caption">
                    {{ $moment(comment.created_at).format('YYYY/MM/DD HH:mm') }}
                  </span>
                </v-col>
                <v-col cols="6" align="right" class="pt-0">
                  <v-dialog v-model="dialog" width="500">
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        v-if="isLoggedIn && currentUser.id == comment.user.id"
                        bottom
                        icon
                        rounded
                        color="warning"
                        v-bind="attrs"
                        v-on="on"
                      >
                        <v-icon color="warning">mdi-delete</v-icon>
                      </v-btn>
                    </template>
                    <v-card class="pa-2">
                      <v-card-actions class="px-2 py-0">
                        <v-icon class="ml-auto" @click="dialog = false">
                          mdi-close
                        </v-icon>
                      </v-card-actions>
                      <v-card-title
                        class="pt-1 justify-center text-subtitle-1 "
                      >
                        本当にコメントを削除しますか？
                      </v-card-title>
                      <v-divider class="mb-5" />
                      <v-card-text class="text-center text-subtitle-2">
                        ※この操作は取り消せません
                      </v-card-text>
                      <v-card-actions class="justify-center px-0">
                        <v-btn
                          rounded
                          depressed
                          class="font-weight-bold text-caption"
                          width="45%"
                          @click="dialog = false"
                        >
                          キャンセル
                        </v-btn>
                        <v-btn
                          rounded
                          color="warning"
                          class="white--text font-weight-bold text-caption"
                          width="45%"
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
                    label="コメントを入力する"
                    :error-messages="errors"
                  />
                </ValidationProvider>
                <v-row justify="center">
                  <v-col cols="12" sm="6">
                    <v-btn
                      v-if="!commentLoadShow"
                      block
                      rounded
                      color="primary"
                      class="white--text font-weight-bold d-block mx-auto"
                      :disabled="invalid"
                      @click="sendComment"
                    >
                      コメントする
                    </v-btn>
                    <Loading v-show="commentLoadShow" />
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
import FollowButton from '~/components/layout/FollowButton.vue'
import Loading from '~/components/layout/Loading.vue'
import PleaseLoginDialog from '~/components/layout/PleaseLoginDialog.vue'
import UserInformation from '~/components/user/UserInformation.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'
import ItemLinkButton from '~/components/item/ItemLinkButton.vue'
import TagLinkCard from '~/components/tag/TagLinkCard.vue'
import TopicCard from '~/components/topic/TopicCard.vue'

export default {
  components: {
    PageHeader,
    UserInformation,
    FollowButton,
    TagLinkCard,
    Loading,
    NoContentDisplay,
    ItemLinkButton,
    PleaseLoginDialog,
    TopicCard
  },
  data() {
    return {
      dialog: false,
      text: '',
      item: {
        user: {}
      },
      userEmail: '',
      tags: [],
      likeList: [],
      followers: [],
      comments: [],
      commentText: '',
      likeLoadShow: false,
      commentLoadShow: false
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
      this.likeLoadShow = true
      await this.$axios
        .$post('/api/v1/item_likes', {
          user_id: this.currentUser.id,
          item_id: this.item.id,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          this.likeLoadShow = false
          this.likeList = response
        })
        .catch((error) => {
          this.likeLoadShow = false
          return error
        })
    },
    async dislikeItem() {
      this.likeLoadShow = true
      await this.$axios
        .delete('/api/v1/item_likes', {
          params: {
            user_id: this.currentUser.id,
            item_id: this.item.id,
            uid: localStorage.getItem('uid')
          }
        })
        .then((response) => {
          this.likeLoadShow = false
          this.likeList = response.data
        })
        .catch((error) => {
          this.likeLoadShow = false
          return error
        })
    },
    async sendComment() {
      this.commentLoadShow = true
      await this.$axios
        .post('/api/v1/item_comments', {
          content: this.commentText,
          user_id: this.currentUser.id,
          item_id: this.item.id,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          this.commentLoadShow = false
          this.comments = response.data
          this.commentText = ''
          this.$refs.observer.reset()
        })
        .catch((error) => {
          this.commentLoadShow = false
          return error
        })
    },
    async deleteComment(commentId) {
      this.commentLoadShow = true
      await this.$axios
        .delete(`api/v1/item_comments/${commentId}`, {
          params: {
            user_id: this.currentUser.id,
            item_id: this.item.id,
            uid: localStorage.getItem('uid')
          }
        })
        .then((response) => {
          this.commentLoadShow = false
          this.comments = response.data
          this.dialog = false
          this.$refs.observer.reset()
        })
        .catch((error) => {
          this.commentLoadShow = false
          return error
        })
    }
  },
  head() {
    return {
      title: this.item.name
    }
  }
}
</script>
