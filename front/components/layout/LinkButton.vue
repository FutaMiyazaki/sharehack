<template>
  <v-btn
    text
    large
    rounded
    color="primary"
    :to="link"
    class="text-center font-weight-bold"
    >{{ text }}
    <v-icon v-if="icon">mdi-{{ icon }}</v-icon>
  </v-btn>
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
    },
    icon: {
      type: String,
      required: false,
      default: ''
    }
  }
}
</script>
