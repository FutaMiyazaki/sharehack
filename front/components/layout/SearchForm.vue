<template>
  <ValidationObserver ref="observer" v-slot="{ invalid }">
    <v-form @submit.prevent="search" class="mr-3">
      <ValidationProvider rules="required|max:50" mode="aggressive">
        <v-text-field
          v-model.trim="keyword"
          flat
          solo
          dense
          rounded
          outlined
          hide-details
          full-width
          background-color="secondary"
          label="キーワード検索"
          class="hidden-sm-and-down"
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
      this.$router.push({
        path: '/item/search',
        query: { keyword: this.keyword, page: 1 }
      })
      this.searchDialog = false
      this.keyword = ''
      this.$refs.observer.reset()
    }
  }
}
</script>
