<template>
  <v-card outlined flat @click="toTagItems(tagId)">
    <v-card-subtitle>
      <v-icon left small>
        mdi-tag
      </v-icon>
      {{ tagName }}
    </v-card-subtitle>
  </v-card>
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
