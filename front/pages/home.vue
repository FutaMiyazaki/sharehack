<template>
  <div>
    <nav>
      <nuxt-link to="/testpage">testpage</nuxt-link>
    </nav>
    <h2>Home</h2>
    <button @click="toTestpages">testpageに行く</button>
  </div>
</template>

<script>
export default {
  methods: {
    toTestpages() {
      this.$router.push('testpage')
    }
  }
}
</script>
