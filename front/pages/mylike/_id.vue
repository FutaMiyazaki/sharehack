<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row class="mt-5">
      <v-col cols="12" sm="4">
        <UserProfile
          :user-name="user.name"
          :items-count="itemLikes.length"
          :user-id="user.id"
          :current-user="currentUser"
          selected-item="1"
        />
      </v-col>

      <v-col cols="12" sm="8">
        <v-row>
          <v-col v-for="itemLike in itemLikes" :key="itemLike.id" :cols="6">
            <v-hover v-slot="{ hover }">
              <v-card
                :elevation="hover ? 16 : 2"
                :class="{ 'on-hover': hover }"
              >
                <v-img
                  max-height="auto"
                  max-width="100%"
                  :src="itemLike.item.image_url"
                ></v-img>
                <v-card-title class="px-2 py-0">{{
                  itemLike.item.name
                }}</v-card-title>
                <v-card-text class="px-2 py-0">
                  <v-row>
                    <v-col cols="10" align="left">
                      <p class="my-auto text--secondary">
                        {{ itemLike.item.user.name }}
                      </p>
                    </v-col>
                    <v-col cols="2" align="right">
                      <v-icon color="red darken-3">mdi-heart</v-icon>
                      {{ itemLike.item.item_likes.length }}
                    </v-col>
                  </v-row>
                </v-card-text>
                <v-card-actions>
                  <v-row class="px-1 py-2">
                    <v-chip
                      v-for="tag in itemLike.item.tags"
                      :key="tag.id"
                      outlined
                      color="primary"
                      class="ma-1"
                      :to="'/tag/' + tag.id"
                    >
                      #{{ tag.name }}
                    </v-chip>
                  </v-row>
                </v-card-actions>
              </v-card>
            </v-hover>
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
      selectedItem: 1,
      text: '',
      user: {},
      itemLikes: [],
      currentUser: this.$store.getters['authentication/currentUser'].id
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/like`)
      .then((response) => {
        console.log('情報の取得に成功')
        this.user = response.data
        this.itemLikes = this.user.item_likes
        this.text = this.user.name + 'のいいね一覧'
        console.log(response)
      })
      .catch((error) => {
        console.log('情報の取得に失敗')
        console.log(error)
      })
  },
  methods: {
    toSetting() {
      this.$router.push('/users/settings')
    }
  }
}
</script>
