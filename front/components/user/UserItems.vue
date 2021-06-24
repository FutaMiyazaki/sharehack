<template>
  <v-row>
    <v-col v-for="item in items" :key="item.id" :cols="6">
      <ItemCard :item="item" />
    </v-col>
  </v-row>
</template>

<script>
import ItemCard from '~/components/item/ItemCard.vue'
export default {
  components: {
    ItemCard
  },
  data() {
    return {
      items: []
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        this.items = response.data.items
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
