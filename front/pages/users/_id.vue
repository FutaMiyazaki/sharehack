<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row class="mt-5">
      <v-col cols="12" md="4">
        <v-card flat class="mx-auto">
          <v-list>
            <v-list-item>
              <v-list-item-avatar class="mx-auto">
                <v-icon v-if="!user.avatar_url" large color="primary">
                  mdi-account-circle
                </v-icon>
                <v-img
                  v-else
                  alt="ユーザーのプロフィール画像"
                  max-height="auto"
                  max-width="100%"
                  :src="user.avatar_url"
                />
              </v-list-item-avatar>
            </v-list-item>
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title class="text-center">
                  {{ user.name }}
                </v-list-item-title>
                <v-list-item-subtitle class="mt-2 text-center">
                  {{ items.length }}件の投稿
                </v-list-item-subtitle>
                <v-divider class="my-5" />
                <v-row>
                  <v-col cols="4" class="text-center">
                    <span class="d-block">{{ followings.length }}</span>
                    <span class="text-caption">フォロー</span>
                  </v-col>
                  <v-col cols="4" class="text-center">
                    <span class="d-block">{{ followers.length }}</span>
                    <span class="text-caption">フォロワー</span>
                  </v-col>
                  <v-col cols="4" class="text-center">
                    <span class="d-block">{{ likes.length }}</span>
                    <span class="text-caption">いいね</span>
                  </v-col>
                </v-row>
                <div>
                  <Loading v-show="loadShow" />
                  <template
                    v-if="
                      !loadShow &&
                        isLoggedIn &&
                        currentUser &&
                        currentUser.id !== user.id
                    "
                  >
                    <v-divider class="mb-3" />
                    <v-btn
                      v-show="!isFollowed"
                      block
                      rounded
                      outlined
                      color="primary"
                      class="font-weight-bold"
                      @click="sendFollow"
                    >
                      <v-icon>mdi-account-plus</v-icon>
                      <p class="my-auto mx-2">フォローする</p>
                    </v-btn>
                    <v-dialog v-model="dialog" width="400">
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn
                          v-show="isFollowed"
                          block
                          rounded
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
                        <v-card-actions class="px-2 py-0">
                          <v-icon class="ml-auto" @click="dialog = false">
                            mdi-close
                          </v-icon>
                        </v-card-actions>
                        <v-card-title
                          class="pt-1 justify-center text-subtitle-1"
                        >
                          フォロー解除しますか？
                        </v-card-title>
                        <v-divider class="mb-5" />
                        <v-card-actions class="justify-center">
                          <v-btn
                            rounded
                            depressed
                            class="font-weight-bold"
                            width="45%"
                            @click="dialog = false"
                          >
                            キャンセル
                          </v-btn>
                          <v-btn
                            rounded
                            color="primary"
                            class="white--text font-weight-bold"
                            width="45%"
                            @click="sendUnfollow"
                          >
                            フォロー解除
                          </v-btn>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>
                  </template>
                  <template v-if="!isLoggedIn">
                    <PleaseLoginDialog
                      btn-color="primary"
                      btn-icon="mdi-account-plus"
                      btn-text="フォローする"
                    />
                  </template>
                  <v-btn
                    v-show="currentUser && currentUser.id == user.id"
                    block
                    rounded
                    outlined
                    color="primary"
                    to="/users/setting"
                    class="text-caption"
                  >
                    <v-icon left>mdi-cog</v-icon>
                    アカウントを編集
                  </v-btn>
                </div>
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <v-list nav dense rounded>
            <v-list-item-group v-model="selectedItem" color="primary">
              <v-list-item @click="currentComponent = 'UserItems'">
                <v-list-item-icon>
                  <v-icon>mdi-folder</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>すべての投稿</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-item @click="currentComponent = 'UserLikes'">
                <v-list-item-icon>
                  <v-icon>mdi-heart</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>いいねした投稿</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-item @click="currentComponent = 'UserTopics'">
                <v-list-item-icon>
                  <v-icon>mdi-chat</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>投稿したトピック</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-item @click="currentComponent = 'FollowingList'">
                <v-list-item-icon>
                  <v-icon>mdi-account-multiple-plus</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>フォロー</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-item @click="currentComponent = 'FollowerList'">
                <v-list-item-icon>
                  <v-icon>mdi-account-group</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>フォロワー</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-card>
      </v-col>
      <v-col cols="12" lg="8" md="8">
        <component :is="currentComponent" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import Loading from '~/components/layout/Loading.vue'
import UserItems from '~/components/user/UserItems.vue'
import UserLikes from '~/components/user/UserLikes.vue'
import UserTopics from '~/components/user/UserTopics.vue'
import FollowingList from '~/components/user/FollowingList.vue'
import FollowerList from '~/components/user/FollowerList.vue'
import PleaseLoginDialog from '~/components/layout/PleaseLoginDialog.vue'

export default {
  components: {
    PageHeader,
    Loading,
    UserItems,
    UserLikes,
    UserTopics,
    FollowingList,
    FollowerList,
    PleaseLoginDialog
  },
  data() {
    return {
      loadShow: true,
      selectedItem: 0,
      text: '',
      user: {},
      items: [],
      likes: [],
      followings: [],
      followers: [],
      currentComponent: 'UserItems',
      dialog: false
    }
  },
  validate({ params }) {
    return !isNaN(+params.id)
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn',
      currentUser: 'authentication/currentUser'
    }),
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
  watch: {
    followings(newValue) {
      this.followings = newValue
    },
    followers(newValue) {
      this.followers = newValue
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        this.loadShow = false
        this.user = response.data
        this.items = this.user.items
        this.likes = this.user.item_likes
        this.text = this.user.name + 'のマイページ'
        this.followings = this.user.followings
        this.followers = this.user.followers
      })
      .catch((error) => {
        return error
      })
  },
  methods: {
    async sendFollow() {
      await this.$axios
        .$post('/api/v1/relationships', {
          user_id: this.currentUser?.id,
          follow_id: this.user.id,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          this.followers = response.followers
        })
        .catch((error) => {
          return error
        })
    },
    async sendUnfollow() {
      await this.$axios
        .$delete(`api/v1/relationships/${this.user.id}`, {
          params: {
            user_id: this.currentUser?.id,
            follow_id: this.user.id,
            uid: localStorage.getItem('uid')
          }
        })
        .then((response) => {
          this.followers = response.followers
          this.dialog = false
        })
        .catch((error) => {
          return error
        })
    }
  },
  head() {
    return {
      title: this.user.name
    }
  }
}
</script>
