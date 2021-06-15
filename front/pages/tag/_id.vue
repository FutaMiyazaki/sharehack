<template>
  <v-container class="pt-0">
    <PageHeader :text="'タグ「' + text + '」の投稿一覧'" icon="mdi-tag" />
    <v-row>
      <v-col v-for="item in items" :key="item.id" cols="12" sm="4">
        <v-hover v-slot="{ hover }">
          <v-card :elevation="hover ? 16 : 2" :class="{ 'on-hover': hover }">
            <nuxt-link :to="'/item/' + item.id">
              <v-img
                max-height="auto"
                max-width="100%"
                :src="item.image_url"
              ></v-img>
            </nuxt-link>
            <v-card-title class="px-2 py-0">{{ item.name }}</v-card-title>
            <v-card-text class="px-2 py-0">
              <v-row>
                <v-col cols="10" align="left">
                  <nuxt-link
                    :to="'/users/' + item.user.id"
                    class="text-decoration-none"
                  >
                    <p class="my-auto text--secondary">{{ item.user.name }}</p>
                  </nuxt-link>
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
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'

export default {
  components: {
    PageHeader
  },
  data() {
    return {
      text: '',
      items: []
    }
  },
  computed: {},
  created() {
    this.$axios
      .get(`api/v1/tags/${this.$route.params.id}`)
      .then((response) => {
        this.text = response.data.name
        this.items = response.data.items
        this.currentUserId = this.$store.getters[
          'authentication/currentUser'
        ].id
        console.log(response)
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
