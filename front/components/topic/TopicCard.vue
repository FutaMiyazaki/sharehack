<template>
  <v-card flat class="mb-5 rounded-lg" color="secondary">
    <v-card-subtitle class="pb-1 text-subtitle-2 black--text">
      所属トピック：
    </v-card-subtitle>
    <NuxtLink :to="nuxtLink">
      <v-card-title class="text-subtitle-1 py-0">
        {{ topic.title }}
      </v-card-title>
    </NuxtLink>
    <v-card-text class="text-caption pt-3">
      <p
        style="white-space:pre-wrap;"
        class="mb-0"
        v-text="topic.description"
      ></p>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    topic: {
      type: Object,
      require: true,
      default: () => ({
        id: '',
        title: '',
        description: ''
      })
    },
    link: {
      type: Boolean,
      required: false,
      default: true
    }
  },
  computed: {
    nuxtLink() {
      if (this.link) {
        const url = `/topic/${this.topic.id}`
        return url
      } else {
        return false
      }
    }
  }
}
</script>
