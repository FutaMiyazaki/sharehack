<template>
  <v-container class="pt-0">
    <PageHeader :text="pageHeaderText" icon="mdi-clock-outline" />
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <template v-if="items.length">
        <v-row>
          <v-col
            v-for="item in items"
            :key="item.id"
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
      <template v-if="!items.length && afterSearch">
        <v-col cols="12">
          <NoContentDisplay
            icon="mdi-emoticon-sad-outline"
            text="表示する投稿がありません"
          />
        </v-col>
      </template>
    </template>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
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
      pageHeaderText: 'タイムライン',
      loadShow: true,
      afterSearch: false,
      items: [],
      showPages: 1,
      totalPages: 0,
      totalCount: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
  },
  created() {
    this.$axios
      .get('api/v1/items/timeline', {
        params: {
          user_id: this.currentUser.id
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
      .get('api/v1/items/timeline', {
        params: {
          user_id: this.currentUser.id,
          page: this.$route.query.page
        }
      })
      .then((response) => {
        this.afterSearch = true
        this.loadShow = false
        this.items = response.data
      })
      .catch((error) => {
        this.afterSearch = true
        this.loadShow = false
        return error
      })
  },
  methods: {
    async pageChange(number) {
      this.$router.push({ path: '/item/timeline', query: { page: number } })
      window.scrollTo({
        top: 0,
        behavior: 'instant'
      })
      this.loadShow = true
      await this.$axios
        .get('/api/v1/items/timeline', {
          params: {
            user_id: this.currentUser.id,
            page: number
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
    }
  },
  head() {
    return {
      title: 'タイムライン'
    }
  }
}
</script>
