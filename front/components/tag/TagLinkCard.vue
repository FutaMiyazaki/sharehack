<template>
  <v-card flat>
    <v-row>
      <v-col cols="6"></v-col>
      <v-col cols="6">{{ tagName }}</v-col>
    </v-row>
  </v-card>
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
