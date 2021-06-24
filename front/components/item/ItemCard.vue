<template>
  <v-hover v-slot="{ hover }">
    <v-card :elevation="hover ? 16 : 2" :class="{ 'on-hover': hover }">
      <nuxt-link :to="'/item/' + item.id">
        <v-img max-height="auto" max-width="100%" :src="item.image_url"></v-img>
      </nuxt-link>
      <v-card-title class="px-2 py-0">{{ item.name }}</v-card-title>
      <v-card-text class="px-2 py-0">
        <nuxt-link
          v-if="'user' in item"
          :to="'/users/' + item.user.id"
          class="text-decoration-none"
        >
          <p class="my-auto text--secondary">
            {{ item.user.name }}
          </p>
        </nuxt-link>
      </v-card-text>
      <v-card-text class="px-2 py-0">
        <v-icon color="red darken-3">mdi-heart</v-icon>
        {{ item.item_likes.length }}
        <v-icon color="primary" class="ml-2">mdi-comment-outline</v-icon>
        {{ item.item_comments.length }}
      </v-card-text>
      <v-card-actions>
        <v-row class="px-1 py-2">
          <v-chip
            v-for="tag in item.tags"
            :key="`item-${item.id}-tag-${tag.id}`"
            label
            outlined
            small
            class="ma-1"
            :to="'/tag/' + tag.id"
          >
            <v-icon small class="mr-1">mdi-tag</v-icon>{{ tag.name }}
          </v-chip>
        </v-row>
      </v-card-actions>
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
  }
}
</script>
