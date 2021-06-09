<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row>
      <v-col cols="12" sm="7">
        <v-img max-height="auto" max-width="100%" :src="item.image_url"></v-img>
        <v-row>
          <v-col cols="6" align="left">
            <p class="my-auto">{{ item.created_at }}</p>
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
        <div class="my-5 pa-3 rounded-xl secondary">
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
    <v-row></v-row>
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
      likeList: []
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
        // const liked = this.likeList.some(function(like) {
        //   return like.user_id === this.currentUserId
        // })
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
        this.text = this.item.name
        this.currentUserId = this.$store.getters[
          'authentication/currentUser'
        ].id
        console.log('アイテム情報の取得に成功')
        console.log(response)
      })
      .catch((error) => {
        console.log('アイテム情報の取得に失敗')
        console.log(error)
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
          console.log('いいね成功しました！')
          this.likeList = response
          console.log(response)
        })
        .catch((error) => {
          console.log('いいね失敗しました！')
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
          console.log('いいねの取り消しに成功しました！')
          this.likeList = response.data
          console.log(response)
        })
        .catch((error) => {
          console.log('いいねの取り消しに失敗しました！')
          return error
        })
    }
  }
}
</script>
