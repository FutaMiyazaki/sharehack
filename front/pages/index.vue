<template>
  <v-container>
    <v-row>
      <v-col v-for="item in items" :key="item.name" :cols="6">
        <v-card @click="toPost(item.id)">
          <v-card-title>{{ item.name }}</v-card-title>
          <v-card-text>aaaaaa </v-card-text>
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
// import item from '~/components/item/item.vue'

export default {
  // components: {
  //   item
  // },
  data() {
    return {
      items: []
    }
  },
  created() {
    this.$axios
      .get('api/v1/items')
      .then((response) => {
        this.items = response.data
        console.log(response)
        console.log(this.items)
        console.log('アイテム一覧の取得に成功')
      })
      .catch((error) => {
        console.log('アイテム一覧の取得に失敗')
        console.log(error)
      })
  },
  methods: {
    toPost(id) {
      this.$router.push(`/item/${id}`)
    }
  }
}
</script>
