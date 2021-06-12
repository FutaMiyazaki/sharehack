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
          <v-col cols="6">
            <v-btn v-show="!isLiked" rounded block @click="likeItem">
              <v-icon class="mr-3" color="primary">mdi-heart-outline</v-icon>
              <p class="my-auto">いいね{{ likeCount }}</p>
            </v-btn>
            <v-btn v-show="isLiked" rounded block @click="dislikeItem">
              <v-icon class="mr-3" color="primary">mdi-heart</v-icon>
              <p class="my-auto">いいね{{ likeCount }}</p>
            </v-btn>
          </v-col>
          <v-col cols="6">
            <v-btn rounded block>
              <v-icon class="mr-3">mdi-folder-plus-outline</v-icon>
              <p class="my-auto">保存する</p>
            </v-btn>
          </v-col>
        </v-row>
        <div class="my-5 pa-3 rounded-lg secondary">
          <p style="white-space:pre-wrap;" v-text="item.description"></p>
        </div>
        <div>
          <a :href="item.link" target="_blank" rel="noopener noreferrer"
            >商品URL</a
          >
          <p>※新しいタブで開きます</p>
        </div>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" sm="7">
        <v-row>
          <v-col cols="12">
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
                  <v-btn
                    v-if="currentUserId == comment.user.id"
                    text
                    color="warning"
                    @click="deleteComment(comment.id)"
                    >コメントを削除する</v-btn
                  >
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
import PageHeader from '~/components/layout/PageHeader.vue'

export default {
  components: {
    PageHeader
  },
  data() {
    return {
      text: '',
      item: {
        user: {}
      },
      currentUserId: '',
      userEmail: '',
      likeList: [],
      comments: [],
      commentText: ''
    }
  },
  computed: {
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
    // if (this.$store.getters['authentication/currentUser'].uid !== null) {
    //   this.userEmail = this.$store.getters['authentication/currentUser'].uid
    // }
    this.$axios
      .get(`api/v1/items/${this.$route.params.id}`)
      .then((response) => {
        this.item = response.data
        this.likeList = response.data.item_likes
        this.comments = response.data.item_comments
        this.text = this.item.name
        this.currentUserId = this.$store.getters[
          'authentication/currentUser'
        ].id
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
          this.$refs.observer.reset()
        })
        .catch((error) => {
          return error
        })
    }
  }
}
</script>
