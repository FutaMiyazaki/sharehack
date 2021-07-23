<template>
  <v-row>
    <v-col cols="12">
      <v-banner>すべての投稿</v-banner>
    </v-col>
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <v-col v-for="item in items" :key="item.id" cols="12" sm="6">
        <v-hover v-slot="{ hover }">
          <v-card
            outlined
            :elevation="hover ? 16 : 0"
            :class="{ 'on-hover': hover }"
          >
            <nuxt-link :to="'/item/' + item.id">
              <v-img aspect-ratio="1" :src="item.image_url" />
            </nuxt-link>
            <v-card-title class="py-0">{{ item.name }}</v-card-title>
            <v-card-actions>
              <v-row class="px-1 py-2">
                <v-chip
                  v-for="tag in item.tags"
                  :key="`item-${item.id}-tag-${tag.id}`"
                  label
                  outlined
                  small
                  class="ma-1"
                  @click="toTagItems(tag.id)"
                >
                  <v-icon small class="mr-1">mdi-tag</v-icon>{{ tag.name }}
                </v-chip>
              </v-row>
            </v-card-actions>
          </v-card>
        </v-hover>
      </v-col>
      <template v-if="!items.length">
        <NoContentDisplay text="投稿はありません" />
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
      items: [],
      loadShow: true
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        this.loadShow = false
        this.items = response.data.items
      })
      .catch((error) => {
        this.loadShow = false
        return error
      })
  },
  methods: {
    toTagItems(tagId) {
      this.$router.push({
        path: `/tag/${tagId}`,
        query: { keyword: this.keyword, page: 1 }
      })
    }
  }
}
</script>
