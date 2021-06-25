<template>
  <nuxt-link :to="'/users/' + userId" class="text-decoration-none">
    <v-list-item class="grow">
      <!-- <template v-if="userAvatarUrl">
        <v-list-item-icon>
          <v-icon>mdi-account</v-icon>
        </v-list-item-icon>
      </template> -->
      <!-- <template v-else> -->
      <v-list-item-avatar>
        <v-img alt="プロフィール画像" :src="userAvatarUrl" />
      </v-list-item-avatar>
      <!-- </template> -->
      <v-list-item-content>
        <v-list-item-title>{{ userName }}</v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </nuxt-link>
</template>

<script>
export default {
  props: {
    userId: {
      type: Number,
      required: true
    },
    userAvatarUrl: {
      type: String,
      default: ''
    },
    userName: {
      type: String,
      required: true
    }
  }
}
</script>
