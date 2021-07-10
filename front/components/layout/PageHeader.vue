<template>
  <div class="page-header py-4 mb-5">
    <v-icon class="pb-1">{{ icon }}</v-icon>
    <span class="d-inline font-weight-bold">{{ text }}</span>
  </div>
</template>

<script>
export default {
  props: {
    icon: {
      type: String,
      required: false,
      default: ''
    },
    text: {
      type: String,
      required: true
    }
  }
}
</script>

<style scoped>
.page-header {
  background: #eeeeee;
  margin: 0 calc(50% - 50vw);
  padding: 0 calc(50vw - 50%);
  width: 100vw;
}
</style>
