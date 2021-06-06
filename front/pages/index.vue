<template>
  <v-container>
    <v-row>
      <v-col v-for="item in items" :key="item.id" :cols="4">
        <v-card @click="toPost(item.id)">
          <v-card-title>{{ item.name }}</v-card-title>
          <v-img
            max-height="auto"
            max-width="100%"
            :src="item.image_url"
          ></v-img>
          <v-divider class="mx-4"></v-divider>
          <v-card-actions>
            <p class="my-auto">{{ item.user.name }}</p>
            <v-icon color="primary">mdi-heart-outline</v-icon>
            {{ item.item_likes.length }}
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({ items: 'item/items' })
  },
  created() {
    this.getItems()
    console.log('確認用')
  },
  methods: {
    ...mapActions({ getItems: 'item/getItems' }),
    toPost(id) {
      this.$router.push(`/item/${id}`)
    }
  }
}
</script>
