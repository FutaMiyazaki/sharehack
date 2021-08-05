<template>
  <v-list-item dense nuxt :to="link" class="text-center mb-0 px-0">
    <v-btn text block small class="font-weight-black black--text text-caption">
      {{ text }}
    </v-btn>
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
