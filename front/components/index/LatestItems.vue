<template>
  <v-row>
    <v-col cols="12">
      <v-subheader class="black--text"> 最新の投稿</v-subheader>
      <v-divider />
    </v-col>
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <v-col
        v-for="item in items"
        :key="item.id"
        cols="12"
        lg="4"
        md="6"
        sm="6"
      >
        <ItemCard :item="item" />
      </v-col>
      <v-col cols="12">
        <v-row justify="center">
          <v-col cols="12" sm="6" class="text-center">
            <LinkButton
              link="/item/latest?page=1"
              text="もっと見る"
              icon="chevron-right"
            />
          </v-col>
        </v-row>
      </v-col>
    </template>
  </v-row>
</template>

<script>
import Loading from '~/components/layout/Loading.vue'
import ItemCard from '~/components/item/ItemCard.vue'
import LinkButton from '~/components/layout/LinkButton.vue'

export default {
  components: {
    Loading,
    ItemCard,
    LinkButton
  },
  data() {
    return {
      items: [],
      loadShow: true
    }
  },
  created() {
    this.$axios
      .get('api/v1/items/top')
      .then((response) => {
        this.loadShow = false
        this.items = response.data.slice(0, 6)
      })
      .catch((error) => {
        this.loadShow = false
        return error
      })
  }
}
</script>
