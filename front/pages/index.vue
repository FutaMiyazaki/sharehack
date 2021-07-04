<template>
  <v-container class="pt-0">
    <PageHeader text="最新の投稿" icon="mdi-rss" />
    <v-row>
      <v-col v-for="item in items" :key="`item-${item.id}`" cols="12" sm="4">
        <ItemCard :item="item" />
      </v-col>
    </v-row>
    <v-row justify="center" class="mt-5">
      <v-col cols="12" sm="4">
        <v-btn
          block
          large
          rounded
          color="primary"
          to="/item/latest?page=1"
          class="font-weight-bold"
          >もっと見る
        </v-btn>
      </v-col>
    </v-row>
    <PageHeader text="タグから探す" icon="mdi-tag-multiple" class="mt-6" />
    <v-row>
      <v-chip
        v-for="tag in tags"
        :key="`tag-${tag.id}`"
        label
        outlined
        class="ma-2"
        @click="toTagItems(tag.id)"
      >
        <v-icon small class="mr-1">mdi-tag</v-icon>{{ tag.name }}
      </v-chip>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
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
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn',
      currentUser: 'authentication/currentUser',
      currentUserAvatar: 'authentication/currentUserAvatar'
    })
  },
  created() {
    this.$axios
      .get('api/v1/items/top')
      .then((response) => {
        this.items = response.data
      })
      .catch((error) => {
        return error
      })
    this.$axios
      .get('api/v1/tags')
      .then((response) => {
        this.tags = response.data
      })
      .catch((error) => {
        return error
      })
    if (this.isLoggedIn && !this.currentUserAvatar) {
      this.getAvatar(this.currentUser?.id)
    }
  },
  methods: {
    ...mapActions({
      getAvatar: 'authentication/getAvatar'
    }),
    toTagItems(tagId) {
      this.$router.push({
        path: `/tag/${tagId}`,
        query: { keyword: this.keyword, page: 1 }
      })
    }
  },
  head() {
    return {
      title: 'Sharehack',
      titleTemplate: ''
    }
  }
}
</script>
