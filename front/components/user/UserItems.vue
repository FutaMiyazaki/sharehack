<template>
  <v-row justify="center">
    <v-col cols="12">
      <v-banner>すべての投稿</v-banner>
    </v-col>
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <template v-if="items.length">
        <v-col v-for="item in items" :key="item.id" cols="12" md="6">
          <v-hover v-slot="{ hover }">
            <v-card outlined :elevation="hover ? 8 : 0">
              <nuxt-link :to="'/item/' + item.id" class="text-decoration-none">
                <v-img aspect-ratio="1" :src="item.image_url" />
                <v-card-title class="pt-1 pb-0 text-subtitle-1 primary--text">
                  {{ item.name }}
                </v-card-title>
              </nuxt-link>
              <v-card-actions>
                <v-row class="pa-2">
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
              <v-card-text class="px-2 py-0">
                <v-list-item dense class="px-1">
                  <v-list-item-content class="text-caption text-no-wrap">
                    {{ $moment(item.created_at).format('YYYY/MM/DD HH:mm') }}
                  </v-list-item-content>
                  <v-icon color="red darken-3" class="mr-1">
                    mdi-heart
                  </v-icon>
                  <span class="subheading mr-2">{{
                    item.item_likes.length
                  }}</span>
                  <v-icon class="mr-1">
                    mdi-comment-outline
                  </v-icon>
                  <span class="subheading">{{
                    item.item_comments.length
                  }}</span>
                </v-list-item>
              </v-card-text>
            </v-card>
          </v-hover>
        </v-col>
        <v-pagination
          v-if="totalPages != 1"
          v-model="showPages"
          :length="totalPages"
          circle
          class="my-5"
          @input="pageChange"
        />
      </template>
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
      showPages: 1,
      totalPages: 0,
      totalCount: '',
      loadShow: true
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/show_items`)
      .then((response) => {
        this.totalCount = response.data.length
        this.totalPages = Math.ceil(this.totalCount / 12)
      })
      .catch((error) => {
        return error
      })

    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/show_items`, {
        params: {
          page: 1
        }
      })
      .then((response) => {
        this.loadShow = false
        this.items = response.data
      })
      .catch((error) => {
        this.loadShow = false
        return error
      })
  },
  methods: {
    async pageChange(number) {
      this.$router.push({
        path: `/users/${this.$route.params.id}`,
        query: { page: number }
      })
      window.scrollTo({
        top: 0,
        behavior: 'instant'
      })
      this.loadShow = true
      await this.$axios
        .get('/api/v1/items', {
          params: {
            page: number
          }
        })
        .then((response) => {
          this.loadShow = false
          this.items = response.data
        })
        .catch((error) => {
          this.loadShow = false
          return error
        })
    }
  }
}
</script>
