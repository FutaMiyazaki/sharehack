<template>
  <v-row>
    <v-col cols="12" class="pb-0">
      <v-banner>投稿したトピック</v-banner>
    </v-col>
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <v-col cols="12" class="pt-0">
        <v-card v-if="topics.length" flat>
          <v-list three-line>
            <v-list-item
              v-for="topic in topics"
              :key="topic.id"
              :to="'/topic/' + topic.id"
              nuxt
            >
              <v-list-item-content>
                <v-list-item-title
                  class="text-subtitle-2 text-decoration-underline blue--text text--lighten-2 mb-2"
                >
                  {{ topic.title }}
                </v-list-item-title>
                <v-list-item-subtitle class="text-caption black--text ml-4">
                  {{ topic.description }}
                </v-list-item-subtitle>
                <v-list-item-subtitle class="text-caption mt-2 ml-4">
                  {{ topic.items.length }}件の投稿
                </v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-card>
      </v-col>
      <template v-if="!topics.length">
        <NoContentDisplay text="トピックはありません" />
      </template>
    </template>
  </v-row>
</template>

<script>
import Loading from '~/components/layout/Loading.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'

export default {
  components: {
    Loading,
    NoContentDisplay
  },
  data() {
    return {
      user: {},
      topics: [],
      loadShow: true
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/topic`)
      .then((response) => {
        this.loadShow = false
        console.log(response)
        this.user = response.data
        this.topics = this.user.topics
      })
      .catch((error) => {
        this.loadShow = false
        return error
      })
  }
}
</script>
