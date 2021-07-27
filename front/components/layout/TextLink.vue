<template>
  <NuxtLink :to="link" class="text-decoration-none">
    <span class="text-subtitle-2">{{ text }}</span>
    <v-icon small color="primary" class="mb-1">mdi-chevron-right</v-icon>
  </NuxtLink>
</template>

<script>
export default {
  props: {
    link: {
      type: String,
      required: true
    },
    text: {
      type: String,
      required: true
    }
  }
}
</script>
