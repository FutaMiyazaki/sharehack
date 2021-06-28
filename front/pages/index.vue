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
        v-for="tag in limitCount"
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
import { mapActions, mapGetters } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import ItemCard from '~/components/item/ItemCard.vue'

export default {
  components: {
    PageHeader,
    ItemCard
  },
  data() {
    return {
      tags: []
    }
  },
  computed: {
    ...mapGetters({ items: 'item/items' }),
    limitCount() {
      return this.tags.slice(0, 20)
    }
  },
  created() {
    this.getItems()
    this.$axios
      .get('api/v1/tags')
      .then((response) => {
        this.tags = response.data
        console.log(response)
      })
      .catch((error) => {
        return error
      })
  },
  methods: {
    ...mapActions({ getItems: 'item/getItems' })
  }
}
</script>
