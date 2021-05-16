<template>
  <v-app>
    <TheHeader />
    <v-main style="background-color: #fbfbfb">
      <FlashMessage />
      <nuxt />
      <TheFooter />
    </v-main>
  </v-app>
</template>

<script>
import TheHeader from '~/components/layout/TheHeader.vue'
import TheFooter from '~/components/layout/TheFooter.vue'
import FlashMessage from '~/components/layout/FlashMessage.vue'

export default {
  components: {
    TheHeader,
    TheFooter,
    FlashMessage
  }
}
</script>
