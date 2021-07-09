<template>
  <v-container class="pt-0">
    <PageHeader :text="text" icon="mdi-magnify" />
    <ValidationObserver v-slot="{ invalid }">
      <v-form lazy-validation @submit.prevent="searchTag">
        <ValidationProvider
          v-slot="{ errors }"
          rules="required|max:30"
          mode="lazy"
        >
          <v-text-field
            v-model.trim="keyword"
            flat
            solo
            rounded
            outlined
            hide-details
            background-color="secondary"
            label="キーワード検索"
            :error-messages="errors"
          >
            <template v-slot:append-outer>
              <v-btn
                v-if="!loadShow"
                icon
                large
                :disabled="invalid"
                @click="searchTag"
              >
                <v-icon>mdi-magnify</v-icon>
              </v-btn>
              <Loading v-show="loadShow" />
            </template>
          </v-text-field>
        </ValidationProvider>
      </v-form>
    </ValidationObserver>

    <template v-if="!tags.length && afterSearch">
      <v-row justify="center" align-content="center">
        <v-icon large class="d-block mb-3">mdi-emoticon-sad-outline</v-icon>
      </v-row>
      <p class="text-center subtitle-2 pb-2">
        一致する検索結果はありませんでした。<br />
        キーワードを変えて検索してみてください。
      </p>
    </template>
    <template v-if="tags.length && afterSearch">
      <v-row>
        <v-col
          v-for="tag in tags"
          :key="`tag-${tag.id}`"
          cols="12"
          lg="3"
          md="4"
          sm="6"
        >
          <v-card flat @click="toTagItems(tag.id)">{{ tag.name }}</v-card>
        </v-col>
      </v-row>
    </template>
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'
import Loading from '~/components/layout/Loading.vue'

export default {
  components: {
    PageHeader,
    Loading
  },
  data() {
    return {
      text: 'タグの検索',
      tags: [],
      keyword: '',
      loadShow: false,
      afterSearch: false
    }
  },
  // computed: {
  //   text() {
  //     return this.keyword + 'の検索結果：' + this.tagsCount + '件'
  //   }
  // },
  methods: {
    async searchTag() {
      if (!this.keyword) {
        return false
      }
      this.loadShow = true
      await this.$axios
        .$get('/api/v1/tags/search', {
          params: {
            keyword: this.keyword
          }
        })
        .then((response) => {
          this.afterSearch = true
          this.loadShow = false
          this.tags = response
          this.text = `${this.keyword}の検索結果：${this.tags.length}件`
        })
        .catch((error) => {
          this.afterSearch = true
          this.loadShow = false
          return error
        })
    },
    toTagItems(tagId) {
      this.$router.push({
        path: `/tag/${tagId}`,
        query: { keyword: this.keyword, page: 1 }
      })
    }
  },
  head() {
    return {
      title: 'タグの検索'
    }
  }
}
</script>
