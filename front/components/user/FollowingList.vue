<template>
  <v-list subheader>
    <v-subheader>フォロー中のユーザー</v-subheader>
    <v-divider />
    <v-list-item
      v-for="following in followings"
      :key="following.id"
      :to="'/users/' + following.id"
    >
      <v-list-item-icon>
        <v-icon>mdi-account-circle</v-icon>
      </v-list-item-icon>
      <!-- <v-list-item-avatar>
        <v-img
          :alt="`${chat.title} avatar`"
          :src="chat.avatar"
        ></v-img>
      </v-list-item-avatar> -->
      <v-list-item-content>
        <v-list-item-title v-text="following.name"></v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </v-list>
</template>

<script>
export default {
  data() {
    return {
      followings: []
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        this.followings = response.data.followings
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
