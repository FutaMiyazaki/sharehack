<template>
  <v-app>
    <v-main style="background-color: #f8f9fa">
      <v-container>
        <v-row justify="center">
          <v-col cols="12" class="text-center">
            <h1>
              {{ error.statusCode }}
            </h1>
          </v-col>
          <v-col cols="12" class="py-0 text-center">
            <v-icon large class="d-block mb-3">mdi-emoticon-sad-outline</v-icon>
          </v-col>
          <v-col cols="12" class="py-0 text-center">
            <h1
              v-if="error.statusCode === 404"
              class="text--secondary text-subtitle-1"
            >
              このページはすでに削除されているか、URLが間違っている可能性があります。
            </h1>
            <h1 v-else class="text--secondary text-subtitle-1">
              エラーが発生しました。
            </h1>
          </v-col>
          <v-col cols="12" class="text-center">
            <v-btn rounded color="primary" to="/" class="font-weight-bold">
              トップページへ戻る
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
export default {
  layout: 'empty',
  props: {
    error: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      pageNotFound: '見つかりませんでした',
      otherError: 'エラーが発生しました'
    }
  },
  head() {
    const title =
      this.error.statusCode === 404 ? this.pageNotFound : this.otherError
    return {
      title
    }
  }
}
</script>
