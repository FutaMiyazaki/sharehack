<template>
  <v-row>
    <v-col cols="12">
      <v-subheader class="black--text">いいね! した投稿</v-subheader>
      <v-divider />
    </v-col>
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <v-col v-for="itemLike in itemLikes" :key="itemLike.id" cols="12" sm="6">
        <ItemCard :item="itemLike.item" />
      </v-col>
      <template v-if="!itemLikes.length">
        <v-col cols="12">
          <NoContentDisplay text="いいねした投稿はありません" />
        </v-col>
      </template>
    </template>
  </v-row>
</template>

<script>
import Loading from '~/components/layout/Loading.vue'
import ItemCard from '~/components/item/ItemCard.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'

export default {
  components: {
    Loading,
    ItemCard,
    NoContentDisplay
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
