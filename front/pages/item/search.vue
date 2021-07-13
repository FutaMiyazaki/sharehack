<template>
  <v-container class="pt-0">
    <PageHeader :text="text" icon="mdi-magnify" />
    <v-row v-if="items.length">
      <v-col cols="12" sm="3" class="pb-0">
        <v-select
          v-model="selectedSortType"
          :items="sortType"
          label="並び替え順"
          @change="fetchItems"
        />
      </v-col>
    </v-row>
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <template v-if="items.length">
        <v-row>
          <v-col
            v-for="item in items"
            :key="`item-${item.id}`"
            cols="12"
            lg="3"
            md="4"
            sm="6"
          >
            <ItemCard :item="item" />
          </v-col>
        </v-row>
        <v-pagination
          v-if="totalPages != 1"
          v-model="showPages"
          :length="totalPages"
          circle
          class="my-5"
          @input="pageChange"
        />
      </template>
      <template v-else>
        <NoContentDisplay
          icon="mdi-emoticon-sad-outline"
          text="一致する検索結果はありませんでした。キーワードを変えて検索してみてください。"
        />
      </template>
    </template>
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'
import Loading from '~/components/layout/Loading.vue'
import ItemCard from '~/components/item/ItemCard.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'

export default {
  components: {
    PageHeader,
    Loading,
    ItemCard,
    NoContentDisplay
  },
  data() {
    return {
      loadShow: true,
      items: [],
      keyword: '',
      showPages: 1,
      totalPages: 0,
      totalCount: '',
      selectedSortType: '新着',
      sortType: ['新着', '人気']
    }
  },
  computed: {
    text() {
      return this.$route.query.keyword + 'の検索結果：' + this.totalCount + '件'
    }
  },
  watch: {
    $route(to, from) {
      this.loadShow = true
      this.$axios
        .get('api/v1/items/search', {
          params: {
            keyword: this.$route.query.keyword
          }
        })
        .then((response) => {
          this.totalCount = response.data.length
          this.totalPages = Math.ceil(this.totalCount / 12)
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
          this.loadShow = false
          this.selectedSortType = '新着'
          this.items = response.data
        })
        .catch((error) => {
          this.loadShow = false
          this.selectedSortType = '新着'
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
        this.loadShow = false
        this.items = response.data
      })
      .catch((error) => {
        this.loadShow = false
        return error
      })
  },
  methods: {
    pageChange(number) {
      this.$router.push({
        path: '/item/search',
        query: { keyword: this.$route.query.keyword, page: number }
      })
      window.scrollTo({
        top: 0,
        behavior: 'instant'
      })
    },
    async fetchItemsByPopular() {
      this.$router.push({
        path: '/item/search',
        query: { keyword: this.$route.query.keyword, page: 1 }
      })
      this.loadShow = true
      await this.$axios
        .get('api/v1/items/search_ranking', {
          params: {
            keyword: this.$route.query.keyword,
            page: 1
          }
        })
        .then((response) => {
          this.loadShow = false
          this.items = response.data
          this.showPages = 1
        })
        .catch((error) => {
          this.loadShow = false
          return error
        })
    },
    async fetchItemsByNew() {
      this.$router.push({
        path: '/item/search',
        query: { keyword: this.$route.query.keyword, page: 1 }
      })
      this.loadShow = true
      await this.$axios
        .get('api/v1/items/search', {
          params: {
            keyword: this.$route.query.keyword,
            page: 1
          }
        })
        .then((response) => {
          this.loadShow = false
          this.items = response.data
          this.showPages = 1
        })
        .catch((error) => {
          this.loadShow = false
          return error
        })
    },
    fetchItems(event) {
      switch (event) {
        case '新着':
          this.fetchItemsByNew()
          break
        case '人気':
          this.fetchItemsByPopular()
          break
      }
    }
  },
  head() {
    return {
      title: `${this.$route.query.keyword}の検索結果`
    }
  }
}
</script>
