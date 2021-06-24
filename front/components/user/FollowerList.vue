<template>
  <v-list subheader>
    <v-subheader>フォロワー</v-subheader>
    <v-divider />
    <v-list-item
      v-for="follower in followers"
      :key="follower.id"
      :to="'/users/' + follower.id"
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
        <v-list-item-title v-text="follower.name"></v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </v-list>
</template>

<script>
export default {
  data() {
    return {
      followers: []
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        this.followers = response.data.followers
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
