<template>
  <v-container>
    <v-row>
      <v-col v-for="item in items" :key="item.id" cols="12" sm="4">
        <v-card @click="toPost(item.id)">
          <v-img
            max-height="auto"
            max-width="100%"
            :src="item.image_url"
          ></v-img>
          <v-card-title class="px-2 py-0">{{ item.name }}</v-card-title>
          <v-card-actions class="px-2 py-0">
            <v-row>
              <v-col cols="6" align="left">
                <p class="my-auto text--secondary">{{ item.user.name }}</p>
              </v-col>
              <v-col cols="6" align="right">
                <v-icon color="primary">mdi-heart-outline</v-icon>
                {{ item.item_likes.length }}
              </v-col>
            </v-row>
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
