<template>
  <v-list subheader>
    <v-subheader>フォロー中のユーザー</v-subheader>
    <v-divider />
    <UserInformation
      v-for="following in followings"
      :key="following.id"
      :user-id="following.id"
      :user-avatar-url="following.avatar_url"
      :user-name="following.name"
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
      followings: []
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/show_followings`)
      .then((response) => {
        console.log(response)
        this.followings = response.data.followings
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
