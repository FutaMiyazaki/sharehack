<template>
  <v-hover v-slot="{ hover }">
    <v-card outlined :elevation="hover ? 8 : 0">
      <v-card-actions class="pa-0">
        <v-list-item dense nuxt :to="'/users/' + item.user.id" class="px-2">
          <v-list-item-avatar>
            <v-icon v-if="!item.user.avatar_url" large color="primary">
              mdi-account-circle
            </v-icon>
            <v-img
              v-else
              alt="ユーザーのプロフィール画像"
              :src="item.user.avatar_url"
            />
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title>{{ item.user.name }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-card-actions>
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
            {{ tag.name }}
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
          <span class="subheading mr-2">{{ item.item_likes.length }}</span>
          <v-icon class="mr-1">
            mdi-comment-outline
          </v-icon>
          <span class="subheading">{{ item.item_comments.length }}</span>
        </v-list-item>
      </v-card-text>
    </v-card>
  </v-hover>
</template>

<script>
export default {
  props: {
    item: {
      type: Object,
      require: true,
      default: () => ({
        id: '',
        name: '',
        image_url: '',
        user: {},
        item_likes: {},
        item_comments: {},
        tags: {}
      })
    }
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
