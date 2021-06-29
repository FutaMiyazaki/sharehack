<template>
  <v-hover v-slot="{ hover }">
    <v-card :elevation="hover ? 16 : 2" :class="{ 'on-hover': hover }">
      <v-card-actions class="pa-0">
        <v-list-item dense nuxt :to="'/users/' + item.user.id">
          <v-list-item-avatar>
            <v-icon v-if="!item.user.avatar_url" large>
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
          <v-row justify="end">
            <v-icon color="red darken-3" class="mr-1">
              mdi-heart
            </v-icon>
            <span class="subheading mr-2">{{ item.item_likes.length }}</span>
            <v-icon class="mr-1">
              mdi-comment-outline
            </v-icon>
            <span class="subheading mr-2">{{ item.item_comments.length }}</span>
          </v-row>
        </v-list-item>
      </v-card-actions>
      <nuxt-link
        :to="'/item/' + item.id"
        class="text-decoration-none black--text"
      >
        <v-img max-height="auto" max-width="100%" :src="item.image_url" />
        <v-card-title class="pt-1 pb-0">
          {{ item.name }}
        </v-card-title>
      </nuxt-link>
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
      <v-card-text class="pt-0 py-1">
        <v-icon small>mdi-clock-outline</v-icon>
        {{ $moment(item.created_at).format('YYYY/MM/DD HH:mm') }}
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
  }
}
</script>
