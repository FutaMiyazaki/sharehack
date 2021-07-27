<template>
  <v-row>
    <v-col cols="12" class="pb-0">
      <v-subheader class="black--text">フォロー</v-subheader>
      <v-divider />
    </v-col>
    <v-col cols="12" class="pt-0">
      <v-list v-if="followings.length">
        <UserInformation
          v-for="following in followings"
          :key="following.id"
          :user-id="following.id"
          :user-avatar-url="following.avatar_url"
          :user-name="following.name"
        />
      </v-list>
    </v-col>
    <template v-if="!followings.length">
      <v-col cols="12">
        <NoContentDisplay text="フォローしているユーザーはいません" />
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
      followings: []
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/show_followings`)
      .then((response) => {
        this.followings = response.data.followings
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
