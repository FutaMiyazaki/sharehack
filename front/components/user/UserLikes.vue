<template>
  <v-row>
    <v-col v-for="itemLike in itemLikes" :key="itemLike.id" :cols="6">
      <ItemCard :item="itemLike.item" />
    </v-col>
    <v-col v-if="!itemLikes.length" class="white">
      <p class="text-center ma-0">まだ投稿はありません</p>
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
      itemLikes: []
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/like`)
      .then((response) => {
        this.itemLikes = response.data.item_likes
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
