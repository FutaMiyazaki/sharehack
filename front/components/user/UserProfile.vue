<template>
  <v-card class="mx-auto" tile>
    <v-list>
      <v-list-item>
        <v-list-item-avatar> </v-list-item-avatar>
      </v-list-item>
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="text-center">
            {{ userName }}
          </v-list-item-title>
          <v-list-item-subtitle class="text-center">
            {{ itemsCount }}件の投稿
          </v-list-item-subtitle>
          <v-divider class="my-5" />
          <v-row>
            <v-col cols="4">
              {{ userFollowings.length }}
              <span class=" mx-auto text-caption">フォロー</span>
            </v-col>
            <v-col cols="4">
              {{ userFollowers.length }}
              <span class="mx-auto text-caption">フォロワー</span>
            </v-col>
            <v-col cols="4">
              {{ likesCount }}
              <span class="mx-auto text-caption">いいね</span>
            </v-col>
          </v-row>
          <div>
            <template
              v-if="isLoggedIn && currentUser && currentUser.id !== userId"
            >
              <v-divider class="mb-3" />
              <v-btn
                v-show="!isFollowed"
                block
                outlined
                color="primary"
                class="font-weight-bold"
                @click="createFollow"
              >
                <v-icon>mdi-account-plus</v-icon>
                <p class="my-auto mx-2">フォローする</p>
              </v-btn>
              <v-dialog v-model="dialog" width="400">
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    v-show="isFollowed"
                    block
                    v-bind="attrs"
                    color="primary"
                    class="font-weight-bold"
                    v-on="on"
                  >
                    <v-icon>mdi-account-check</v-icon>
                    <p class="my-auto mx-2">フォロー中</p>
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
                  <v-card-title class="mt-2 justify-center font-weight-bold ">
                    フォロー解除しますか？
                  </v-card-title>
                  <v-divider class="mb-5" />
                  <v-card-actions class="justify-center">
                    <v-btn
                      rounded
                      depressed
                      class="font-weight-bold"
                      width="35%"
                      @click="dialog = false"
                    >
                      キャンセル
                    </v-btn>
                    <v-btn
                      rounded
                      color="primary"
                      class="white--text font-weight-bold"
                      width="35%"
                      @click="deleteFollow"
                    >
                      フォロー解除
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </template>

            <v-btn
              v-show="currentUser && currentUser.id == userId"
              outlined
              block
              color="primary"
              to="/users/setting"
            >
              <v-icon class="mr-3">mdi-cog</v-icon>
              <p class="my-auto">アカウントを編集する</p>
            </v-btn>
          </div>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <v-list nav dense>
      <v-list-item-group v-model="selectedItem" color="primary">
        <v-list-item :to="`/users/${userId}`">
          <v-list-item-icon>
            <v-icon>mdi-folder</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>すべての投稿</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item :to="`/mylike/${userId}`">
          <v-list-item-icon>
            <v-icon>mdi-heart</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>いいねした投稿</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  props: {
    userName: {
      type: String,
      required: true,
      default: ''
    },
    itemsCount: {
      type: Number,
      required: false,
      default: 0
    },
    likesCount: {
      type: Number,
      required: false,
      default: 0
    },
    userId: {
      type: Number,
      required: true,
      default: 0
    },
    selectedItem: {
      type: String,
      required: true,
      default: ''
    },
    followings: {
      type: Array,
      required: true,
      default: () => ({ id: '' })
    },
    followers: {
      type: Array,
      required: true,
      default: () => ({ id: '' })
    }
  },
  data() {
    return {
      dialog: false,
      userFollowings: this.followings,
      userFollowers: this.followers
    }
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn',
      currentUser: 'authentication/currentUser'
    }),
    isFollowed() {
      if (this.userFollowers.length === 0) {
        return false
      } else {
        const followed = this.userFollowers.some(
          (follow) => follow.id === this.currentUser?.id
        )
        return followed
      }
    }
  },
  watch: {
    followings(newValue) {
      this.userFollowings = newValue
    },
    followers(newValue) {
      this.userFollowers = newValue
    }
  },
  methods: {
    async createFollow() {
      await this.$axios
        .$post('/api/v1/relationships', {
          user_id: this.currentUser?.id,
          follow_id: this.userId,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          console.log('フォローに成功')
          console.log(response)
          this.userFollowers = response.followers
        })
        .catch((error) => {
          console.log('フォローに失敗')
          return error
        })
    },
    async deleteFollow() {
      await this.$axios
        .$delete(`api/v1/relationships/${this.userId}`, {
          params: {
            user_id: this.currentUser?.id,
            follow_id: this.userId,
            uid: localStorage.getItem('uid')
          }
        })
        .then((response) => {
          console.log('フォロー解除に成功')
          console.log(response)
          this.userFollowers = response.followers
          this.dialog = false
        })
        .catch((error) => {
          console.log('フォロー解除に失敗')
          return error
        })
    }
  }
}
</script>
