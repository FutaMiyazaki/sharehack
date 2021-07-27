<template>
  <v-row>
    <v-col cols="12" class="pb-0">
      <v-subheader class="black--text">フォロワー</v-subheader>
      <v-divider />
    </v-col>
    <v-col cols="12" class="pt-0">
      <v-list v-if="followers.length">
        <UserInformation
          v-for="follower in followers"
          :key="follower.id"
          :user-id="follower.id"
          :user-avatar-url="follower.avatar_url"
          :user-name="follower.name"
        />
      </v-list>
    </v-col>
    <template v-if="!followers.length">
      <v-col cols="12">
        <NoContentDisplay text="フォローされているユーザーはいません" />
      </v-col>
    </template>
  </v-row>
</template>

<script>
import UserInformation from '~/components/user/UserInformation.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'

export default {
  components: {
    UserInformation,
    NoContentDisplay
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
