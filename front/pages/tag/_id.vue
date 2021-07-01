<template>
  <v-container class="pt-0">
    <PageHeader :text="'タグ「' + text + '」の投稿一覧'" icon="mdi-tag" />
    <v-row>
      <v-col v-for="item in items" :key="item.id" cols="12" sm="4">
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
      .get(`api/v1/tags/${this.$route.params.id}`)
      .then((response) => {
        this.text = response.data.name
        this.totalCount = response.data.items.length
        this.totalPages = Math.ceil(this.totalCount / 12)
        console.log(this.totalCount)
      })
      .catch((error) => {
        return error
      })

    this.$axios
      .get(`api/v1/tags/${this.$route.params.id}`, {
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
      this.$router.push({
        path: `/tag/${this.$route.params.id}`,
        query: { page: number }
      })
      await this.$axios
        .get(`api/v1/tags/${this.$route.params.id}`, {
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
  },
  head() {
    return {
      title: `${this.text}の投稿一覧`
    }
  }
}
</script>
