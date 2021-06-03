<template>
  <v-snackbar v-model="status" absolute top right :color="type">
    <div class="font-weight-bold white--text text-center">
      {{ text }}
    </div>
  </v-snackbar>
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
