<template>
  <v-container class="pt-0">
    <PageHeader :text="'タグ「' + text + '」の投稿一覧'" icon="mdi-tag" />
    <v-row>
      <v-col v-for="item in items" :key="item.id" cols="12" sm="4">
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
      text: '',
      items: []
    }
  },
  computed: {},
  created() {
    this.$axios
      .get(`api/v1/tags/${this.$route.params.id}`)
      .then((response) => {
        this.text = response.data.name
        this.items = response.data.items
        this.currentUserId = this.$store.getters[
          'authentication/currentUser'
        ].id
        console.log(response)
      })
      .catch((error) => {
        return error
      })
  }
}
</script>
