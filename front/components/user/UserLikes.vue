<template>
  <v-row>
    <v-col cols="12">
      <v-banner>いいねした投稿</v-banner>
    </v-col>
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <v-col v-for="itemLike in itemLikes" :key="itemLike.id" cols="12" sm="6">
        <ItemCard :item="itemLike.item" />
      </v-col>
      <v-col v-if="!itemLikes.length" class="white">
        <p class="text-center ma-0">まだ投稿はありません</p>
      </v-col>
    </template>
  </v-row>
</template>

<script>
import Loading from '~/components/layout/Loading.vue'
import ItemCard from '~/components/item/ItemCard.vue'

export default {
  components: {
    Loading,
    ItemCard
  },
  data() {
    return {
      itemLikes: [],
      loadShow: true
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/like`)
      .then((response) => {
        this.loadShow = false
        this.itemLikes = response.data.item_likes
      })
      .catch((error) => {
        this.loadShow = false
        return error
      })
  }
}
</script>
