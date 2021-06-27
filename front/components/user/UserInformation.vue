<template>
  <nuxt-link :to="'/users/' + userId" class="text-decoration-none">
    <v-list-item dense>
      <v-list-item-icon v-if="!userAvatarUrl">
        <v-icon large>mdi-account</v-icon>
      </v-list-item-icon>
      <v-list-item-avatar v-else>
        <v-img alt="ユーザーのプロフィール画像" :src="userAvatarUrl" />
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title class="font-weight-bold">
          {{ userName }}
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
