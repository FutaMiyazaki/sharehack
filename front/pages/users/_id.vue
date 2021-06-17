<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row class="mt-5">
      <v-col cols="12" sm="4">
        <UserProfile
          :user-name="user.name"
          :items-count="items.length"
          :user-id="user.id"
          :current-user-id="currentUser.id"
          selected-item="0"
        />
      </v-col>

      <v-col cols="12" sm="8">
        <v-row>
          <v-col v-for="item in items" :key="item.id" :cols="6">
            <v-hover v-slot="{ hover }">
              <v-card
                :elevation="hover ? 16 : 2"
                :class="{ 'on-hover': hover }"
              >
                <v-img
                  max-height="auto"
                  max-width="100%"
                  :src="item.image_url"
                ></v-img>
                <v-card-text class="px-2 py-0">
                  <v-row>
                    <v-col cols="10" align="left">
                      <p class="my-auto text--secondary text-h5">
                        {{ item.name }}
                      </p>
                    </v-col>
                    <v-col cols="2" align="right">
                      <v-icon color="red darken-3">mdi-heart</v-icon>
                      {{ item.item_likes.length }}
                    </v-col>
                  </v-row>
                </v-card-text>
                <v-card-actions>
                  <v-row class="px-1 py-2">
                    <v-chip
                      v-for="tag in item.tags"
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
import { mapGetters } from 'vuex'
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
      items: []
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
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
