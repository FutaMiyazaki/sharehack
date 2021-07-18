<template>
  <div>
    <v-btn
      v-show="!isFollowed && !loadShow"
      block
      rounded
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
          v-show="isFollowed && !loadShow"
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
        <v-card-title class="pt-1 justify-center text-subtitle-1">
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
            @click="deleteFollow"
          >
            フォロー解除
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <Loading v-show="loadShow" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Loading from '~/components/layout/Loading.vue'

export default {
  components: {
    Loading
  },
  props: {
    userId: {
      type: Number,
      required: true,
      default: 0
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
      userFollowers: this.followers,
      loadShow: false
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
    followers(newValue) {
      this.userFollowers = newValue
    }
  },
  methods: {
    async createFollow() {
      this.loadShow = true
      await this.$axios
        .$post('/api/v1/relationships', {
          user_id: this.currentUser?.id,
          follow_id: this.userId,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          this.loadShow = false
          this.userFollowers = response.followers
        })
        .catch((error) => {
          this.loadShow = false
          return error
        })
    },
    async deleteFollow() {
      this.loadShow = true
      await this.$axios
        .$delete(`api/v1/relationships/${this.userId}`, {
          params: {
            user_id: this.currentUser?.id,
            follow_id: this.userId,
            uid: localStorage.getItem('uid')
          }
        })
        .then((response) => {
          this.loadShow = false
          this.userFollowers = response.followers
          this.dialog = false
        })
        .catch((error) => {
          this.loadShow = false
          return error
        })
    }
  }
}
</script>
