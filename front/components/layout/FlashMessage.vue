<template>
  <v-alert
    v-model="status"
    border="left"
    color="primary"
    tile
    dark
    class="mb-0 font-weight-bold"
  >
    {{ text }}
  </v-alert>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters({
      text: 'flashMessage/text',
      status: 'flashMessage/status'
    })
  }
}
</script>
