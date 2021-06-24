<template>
  <ValidationObserver ref="observer" v-slot="{ invalid }">
    <v-form class="mx-2 mb-2" @submit.prevent="search">
      <ValidationProvider rules="required|max:50" mode="aggressive">
        <v-text-field
          v-model.trim="keyword"
          flat
          solo
          dense
          outlined
          hide-details
          label="キーワード検索"
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
      this.$router.push({ path: '/search', query: { keyword: this.keyword } })
      this.keyword = ''
      this.$refs.observer.reset()
    }
  }
}
</script>
