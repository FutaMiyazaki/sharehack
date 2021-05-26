<template>
  <v-container>
    <v-row>
      <v-col v-for="item in items" :key="item.name" :cols="6">
        <v-card @click="toPost(item.id)">
          <v-card-title>{{ item.name }}</v-card-title>
          <v-card-text>アイテム画像を表示</v-card-text>
          <v-divider class="mx-4"></v-divider>
          <v-card-actions>
            <p class="my-auto">{{ item.user.name }}</p>
            <v-btn icon>
              <v-icon>mdi-heart-outline</v-icon>
            </v-btn>
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
