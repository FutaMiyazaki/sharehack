<template>
  <vue-loading
    type="spiningDubbles"
    color="#4169e1"
    :size="{ width: '30px', height: '30px' }"
  />
</template>

<script>
import { VueLoading } from 'vue-loading-template'

export default {
  components: {
    VueLoading
  }
}
</script>
