<template>
  <div class="page-header py-4 mb-5">
    <p class="mb-0 font-weight-bold">{{ text }}</p>
  </div>
</template>

<script>
export default {
  props: {
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
