<template>
  <v-hover v-slot="{ hover }">
    <v-card
      outlined
      :elevation="hover ? 16 : 0"
      :class="{ 'on-hover': hover }"
      @click="toTagItems(tagId)"
    >
      <v-card-title class="text-caption black--text">
        <v-icon left small>
          mdi-tag
        </v-icon>
        {{ tagName }}
      </v-card-title>
    </v-card>
  </v-hover>
</template>

<script>
export default {
  props: {
    tagId: {
      type: Number,
      required: true
    },
    tagName: {
      type: String,
      required: true
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
