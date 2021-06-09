<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row class="mt-5">
      <v-col cols="12" sm="4">
        <UserProfile
          :user-name="user.name"
          :items-count="items.length"
          :user-id="user.id"
          :current-user="currentUser"
          selected-item="0"
        />
      </v-col>

      <v-col cols="12" sm="8">
        <v-row>
          <v-col v-for="item in items" :key="item.id" :cols="6">
            <v-card @click="toPost(item.id)">
              <v-img
                max-height="auto"
                max-width="100%"
                :src="item.image_url"
              ></v-img>
              <v-card-title>{{ item.name }}</v-card-title>
            </v-card>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'
import UserProfile from '~/components/user/UserProfile.vue'

export default {
  components: {
    PageHeader,
    UserProfile
  },
  data() {
    return {
      selectedItem: 0,
      text: '',
      user: {},
      items: [],
      currentUser: this.$store.getters['authentication/currentUser'].id
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        console.log('ユーザー情報の取得に成功')
        this.user = response.data
        this.items = this.user.items
        this.text = this.user.name + 'の投稿一覧'
        console.log(response)
      })
      .catch((error) => {
        console.log('ユーザー情報の取得に失敗')
        console.log(error)
      })
  },
  methods: {
    toPost(id) {
      this.$router.push(`/item/${id}`)
    },
    toSetting() {
      this.$router.push('/users/settings')
    }
  }
}
</script>
