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
    <v-pagination
      v-if="totalPages != 1"
      v-model="showPages"
      :length="totalPages"
      class="my-5"
      @input="pageChange"
    />
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
      keyword: '',
      showPages: 1,
      totalPages: 0,
      totalCount: ''
    }
  },
  computed: {
    text() {
      return this.$route.query.keyword + 'の検索結果：' + this.totalCount + '件'
    }
  },
  watch: {
    $route(to, from) {
      this.$axios
        .get('api/v1/items/search', {
          params: {
            keyword: this.$route.query.keyword
          }
        })
        .then((response) => {
          this.totalCount = response.data.length
          this.totalPages = Math.ceil(this.totalCount / 12)
          console.log(this.totalCount)
        })
        .catch((error) => {
          return error
        })
      this.$axios
        .get('api/v1/items/search', {
          params: {
            keyword: this.$route.query.keyword,
            page: this.$route.query.page
          }
        })
        .then((response) => {
          this.items = response.data
        })
        .catch((error) => {
          return error
        })
    }
  },
  created() {
    this.$axios
      .get('api/v1/items/search', {
        params: {
          keyword: this.$route.query.keyword
        }
      })
      .then((response) => {
        this.totalCount = response.data.length
        this.totalPages = Math.ceil(this.totalCount / 12)
        console.log(this.totalCount)
      })
      .catch((error) => {
        return error
      })
    this.$axios
      .get('api/v1/items/search', {
        params: {
          keyword: this.$route.query.keyword,
          page: 1
        }
      })
      .then((response) => {
        this.items = response.data
        console.log(response)
      })
      .catch((error) => {
        return error
      })
  },
  methods: {
    pageChange(number) {
      this.$router.push({
        path: '/item/search',
        query: { keyword: this.$route.query.keyword, page: number }
      })
    }
  }
}
</script>
