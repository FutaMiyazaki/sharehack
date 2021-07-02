<template>
  <v-row>
    <v-col v-for="item in items" :key="item.id" :cols="6">
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
    <v-col v-if="!items.length" class="white">
      <p class="text-center">まだ投稿はありません</p>
    </v-col>
  </v-row>
</template>

<script>
export default {
  data() {
    return {
      items: []
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        this.items = response.data.items
      })
      .catch((error) => {
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
