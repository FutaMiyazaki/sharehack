<template>
  <v-list-item
    dense
    nuxt
    :to="link"
    class="text-caption black--text text-center mb-0 px-0"
  >
    <v-btn text block small class="font-weight-bold text-caption">
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
