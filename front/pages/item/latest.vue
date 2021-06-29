<template>
  <v-container class="pt-0">
    <PageHeader text="新着の投稿" icon="mdi-rss" />
    <v-row>
      <v-col v-for="item in items" :key="item.id" cols="12" sm="4">
        <ItemCard :item="item" />
      </v-col>
    </v-row>
    <v-pagination
      v-if="totalPages != 1"
      v-model="showPages"
      :length="totalPages"
      @input="pageChange"
      class="my-5"
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
      text: '',
      items: [],
      showPages: 1,
      totalPages: 0,
      totalCount: ''
    }
  },
  computed: {},
  created() {
    this.$axios
      .get('api/v1/items')
      .then((response) => {
        this.totalCount = response.data.length
        this.totalPages = Math.ceil(this.totalCount / 12)
        console.log(this.totalCount)
      })
      .catch((error) => {
        return error
      })

    this.$axios
      .get('api/v1/items', {
        params: {
          page: this.$route.query.page
        }
      })
      .then((response) => {
        this.items = response.data
        console.log('取得成功!!!!!!!!!!')
        console.log(response)
      })
      .catch((error) => {
        console.log('取得失敗!!!!!!!!!!')
        return error
      })
  },
  methods: {
    async pageChange(number) {
      this.$router.push({ path: '/item/latest', query: { page: number } })
      await this.$axios
        .get('/api/v1/items', {
          params: {
            page: number
          }
        })
        .then((response) => {
          this.items = response.data
          console.log('取得成功!!!!!!!!!!')
          console.log(response)
        })
        .catch((error) => {
          console.log('取得失敗!!!!!!!!!!')
          return error
        })
    }
  }
}
</script>
