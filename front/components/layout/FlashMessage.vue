<template>
  <v-alert v-model="status" border="left" :type="type" dismissible>
    {{ text }}
  </v-alert>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters({
      text: 'flashMessage/text',
      type: 'flashMessage/type',
      status: 'flashMessage/status'
    })
  }
}
</script>
