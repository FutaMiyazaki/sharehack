<template>
  <NuxtLink :to="'/users/' + user.id" class="text-decoration-none">
    <v-list-item dense class="px-0">
      <v-list-item-avatar>
        <template v-if="user.picture.url">
          <v-img alt="ユーザーのプロフィール画像" :src="user.picture.url" />
        </template>
        <template v-else>
          <v-icon large color="primary">
            mdi-account-circle
          </v-icon>
        </template>
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title>
          <span class="d-inline-block text-truncate">
            {{ user.name }}
          </span>
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </NuxtLink>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
      default: () => ({
        id: '',
        picture: {
          url: ''
        },
        name: ''
      })
    }
  }
}
</script>
