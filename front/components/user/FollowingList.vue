<template>
  <v-row>
    <v-col cols="12" class="pb-0">
      <v-banner>フォロー</v-banner>
    </v-col>
    <v-col cols="12" class="pt-0">
      <v-list>
        <UserInformation
          v-for="following in followings"
          :key="following.id"
          :user-id="following.id"
          :user-avatar-url="following.avatar_url"
          :user-name="following.name"
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
