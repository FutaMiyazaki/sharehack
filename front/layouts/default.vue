<template>
  <v-app>
    <the-header />
    <v-main style="background-color: #fbfbfb">
      <nuxt />
      <the-footer />
    </v-main>
  </v-app>
</template>

<script>
import TheHeader from '~/components/layout/TheHeader.vue'
import TheFooter from '~/components/layout/TheFooter.vue'

export default {
  components: {
    TheHeader,
    TheFooter
  }
}
</script>
