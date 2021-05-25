<template>
  <v-container>
    <v-row>
      <v-col cols="12" sm="8">
        <h1>商品画像</h1>
        <v-row>
          <v-col cols="6" align="left">
            <p class="my-auto">{{ item.created_at }}</p>
          </v-col>
          <template>
            <v-col cols="6" align="right">
              <nuxt-link
                :to="{ name: 'item-edit-id', params: { id: item.id } }"
              >
                編集する
              </nuxt-link>
            </v-col>
          </template>
        </v-row>
      </v-col>
      <v-col cols="12" sm="4">
        <v-row>
          <v-col cols="6" align="left">
            <v-btn text color="primary">
              <v-icon>mdi-account-circle</v-icon>
              <p class="my-auto">{{ item.user.name }}</p>
            </v-btn>
          </v-col>
          <v-col cols="6" align="right">
            <v-btn icon>
              <v-icon>mdi-account-plus-outline</v-icon>
            </v-btn>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="6">
            <v-btn rounded block>
              <v-icon class="mr-3">mdi-heart-outline</v-icon>
              <p class="my-auto">いいね</p>
            </v-btn>
          </v-col>
          <v-col cols="6">
            <v-btn rounded block>
              <v-icon class="mr-3">mdi-folder-plus-outline</v-icon>
              <p class="my-auto">保存する</p>
            </v-btn>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row>
      <div>
        <p>{{ item.description }}</p>
        <a :href="item.link" target="_blank" rel="noopener noreferrer"
          >商品URL</a
        >
        <p>※新しいタブで開きます</p>
      </div>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      item: {
        user: {}
      },
      userEmail: ''
    }
  },
  created() {
    // if (this.$store.getters['authentication/currentUser'].uid !== null) {
    //   this.userEmail = this.$store.getters['authentication/currentUser'].uid
    // }
    this.$axios
      .get(`api/v1/items/${this.$route.params.id}`)
      .then((response) => {
        this.item = response.data
        console.log(response)
        console.log(this.item)
        console.log('アイテム情報の取得に成功')
      })
      .catch((error) => {
        console.log('アイテム情報の取得に失敗')
        console.log(error)
      })
  }
}
</script>
