<template>
  <v-container class="pt-0">
    <PageHeader :text="tagName" icon="mdi-tag" />
    <v-row>
      <v-col cols="12" sm="3" class="pb-0">
        <v-select
          v-model="selectedSortType"
          :items="sortType"
          label="並び替え順"
          @change="fetchItems"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col
        v-for="item in items"
        :key="item.id"
        cols="12"
        lg="3"
        md="4"
        sm="6"
        xs="12"
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
      tagName: '',
      items: [],
      showPages: 1,
      totalPages: 0,
      totalCount: '',
      selectedSortType: '新着',
      sortType: ['新着', '人気']
    }
  },
  computed: {},
  created() {
    this.$axios
      .get(`api/v1/tags/${this.$route.params.id}`)
      .then((response) => {
        this.tagName = response.data.name
        this.totalCount = response.data.items.length
        this.totalPages = Math.ceil(this.totalCount / 12)
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
      })
      .catch((error) => {
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
        })
        .catch((error) => {
          return error
        })
    },
    async fetchItemsByPopular() {
      this.$router.push({
        path: `/tag/${this.$route.params.id}`,
        query: { page: 1 }
      })
      await this.$axios
        .get(`api/v1/tags/${this.$route.params.id}/ranking`, {
          params: {
            page: 1
          }
        })
        .then((response) => {
          this.items = response.data
          this.showPages = 1
        })
        .catch((error) => {
          return error
        })
    },
    async fetchItemsByNew() {
      this.$router.push({
        path: `/tag/${this.$route.params.id}`,
        query: { page: 1 }
      })
      await this.$axios
        .get(`api/v1/tags/${this.$route.params.id}`, {
          params: {
            page: 1
          }
        })
        .then((response) => {
          this.items = response.data
          this.showPages = 1
        })
        .catch((error) => {
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
      title: `${this.tagName}の投稿一覧`
    }
  }
}
</script>
