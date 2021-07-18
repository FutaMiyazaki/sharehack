<template>
  <v-row>
    <v-col cols="12" class="pb-0">
      <v-banner>フォロワー</v-banner>
    </v-col>
    <v-col cols="12" class="pt-0">
      <v-list>
        <UserInformation
          v-for="follower in followers"
          :key="follower.id"
          :user-id="follower.id"
          :user-avatar-url="follower.avatar_url"
          :user-name="follower.name"
        />
      </v-list>
    </v-col>
  </v-row>
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
        this.followers = response.data.followers
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
