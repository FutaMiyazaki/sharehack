<template>
  <v-list-item
    nuxt
    :to="link"
    class="text-caption black--text text-center mb-0"
  >
    {{ text }}
  </v-list-item>
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
