<template>
  <v-container class="pt-0">
    <PageHeader text="最新の投稿" icon="mdi-rss" />
    <v-row>
      <v-col v-for="item in items" :key="`item-${item.id}`" cols="12" sm="4">
        <ItemCard :item="item" />
      </v-col>
      <v-btn block to="/item/latest?page=1">もっと見る</v-btn>
    </v-row>
    <PageHeader text="タグから探す" icon="mdi-tag-multiple" class="mt-6" />
    <v-row>
      <v-chip
        v-for="tag in tags"
        :key="`tag-${tag.id}`"
        class="ma-2"
        label
        outlined
        :to="'/tag/' + tag.id"
      >
        <v-icon small class="mr-1">mdi-tag</v-icon>{{ tag.name }}
      </v-chip>
    </v-row>
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'
import ItemCard from '~/components/item/ItemCard.vue'

export default {
  components: {
    PageHeader,
    ItemCard
  },
  data() {
    return {
      items: [],
      tags: []
    }
  },
  created() {
    this.$axios
      .get('api/v1/items/top')
      .then((response) => {
        this.items = response.data
        console.log('取得成功!!!!!!!!!!')
        console.log(response)
      })
      .catch((error) => {
        console.log('取得失敗!!!!!!!!!!')
        return error
      })
    this.$axios
      .get('api/v1/tags')
      .then((response) => {
        this.tags = response.data
        console.log(response)
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
