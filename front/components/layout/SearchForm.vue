<template>
  <v-text-field
    flat
    solo
    dense
    outlined
    hide-details
    append-outer-icon="mdi-magnify"
    label="検索"
    class="hidden-sm-and-down mx-auto"
    @click:append-outer="search"
  />
</template>

<script>
export default {
  data() {
    return {
      message: ''
    }
  },
  methods: {
    search() {
      console.log('aaaa')
    }
  }
}
</script>
