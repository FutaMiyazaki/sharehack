<template>
  <nuxt-link :to="'/users/' + userId" class="text-decoration-none">
    <v-list-item dense>
      <v-list-item-avatar>
        <v-icon v-if="!userAvatarUrl" large color="primary">
          mdi-account-circle
        </v-icon>
        <v-img v-else alt="ユーザーのプロフィール画像" :src="userAvatarUrl" />
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title>
          <span class="d-inline-block text-truncate">
            {{ userName }}
          </span>
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </nuxt-link>
</template>

<script>
export default {
  props: {
    userId: {
      type: Number,
      required: true,
      default: 0
    },
    userAvatarUrl: {
      type: String,
      required: false,
      default: ''
    },
    userName: {
      type: String,
      required: true,
      default: ''
    }
  }
}
</script>
