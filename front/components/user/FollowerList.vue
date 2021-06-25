<template>
  <v-list subheader>
    <v-subheader>フォロワー</v-subheader>
    <v-divider />
    <UserInformation
      v-for="follower in followers"
      :key="follower.id"
      :user-id="follower.id"
      :user-avatar-url="follower.avatar_url"
      :user-name="follower.name"
    />
  </v-list>
</template>

<script>
import UserInformation from '~/components/user/UserInformation.vue'

export default {
  components: {
    UserInformation
  },
  data() {
    return {
      followers: []
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/show_followers`)
      .then((response) => {
        console.log(response)
        this.followers = response.data.followers
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
