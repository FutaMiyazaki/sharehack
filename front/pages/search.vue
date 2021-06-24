<template>
  <v-container class="pt-0">
    <PageHeader :text="text" icon="mdi-magnify" />
    <template v-if="!items.length">
      <v-row justify="center" align-content="center">
        <v-icon large class="d-block mb-3">mdi-emoticon-sad-outline</v-icon>
      </v-row>
      <p class="text-center subtitle-2 pb-2">
        一致する検索結果はありませんでした。<br />
        キーワードを変えて検索してみてください。
      </p>
    </template>
    <v-row>
      <v-col v-for="item in items" :key="`item-${item.id}`" cols="12" sm="4">
        <ItemCard :item="item" />
      </v-col>
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
      keyword: ''
    }
  },
  computed: {
    text() {
      return (
        this.$route.query.keyword + 'の検索結果：' + this.items.length + '件'
      )
    }
  },
  watch: {
    $route(to, from) {
      this.$axios
        .get('api/v1/items/search/', {
          params: {
            keyword: this.$route.query.keyword
          }
        })
        .then((response) => {
          this.items = response.data
          console.log(response)
        })
        .catch((error) => {
          return error
        })
    }
  },
  created() {
    this.$axios
      .get('api/v1/items/search/', {
        params: {
          keyword: this.$route.query.keyword
        }
      })
      .then((response) => {
        this.items = response.data
        console.log(response)
      })
      .catch((error) => {
        return error
      })
  }
  // methods: {}
}
</script>
