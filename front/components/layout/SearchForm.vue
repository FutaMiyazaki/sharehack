<template>
  <ValidationObserver ref="observer" v-slot="{ invalid }">
    <v-form>
      <ValidationProvider rules="required|max:50" mode="aggressive">
        <v-text-field
          v-model.trim="keyword"
          flat
          solo
          dense
          outlined
          hide-details
          label="キーワード検索"
          class="hidden-sm-and-down mx-auto"
        >
          <template v-slot:append>
            <v-btn icon small depressed :disabled="invalid" @click="search">
              <v-icon>mdi-magnify</v-icon>
            </v-btn>
          </template>
        </v-text-field>
      </ValidationProvider>
    </v-form>
  </ValidationObserver>
</template>

<script>
export default {
  data() {
    return {
      keyword: ''
    }
  },
  methods: {
    search() {
      console.log('検索結果ページに飛びます')
      console.log(this.keyword)
      this.$router.push({ path: 'search', query: { keyword: this.keyword } })
      this.keyword = ''
      this.$refs.observer.reset()
    }
  }
}
</script>
