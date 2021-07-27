<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row justify="center">
      <v-col cols="12" md="8">
        <ValidationObserver v-slot="{ invalid }">
          <v-form lazy-validation class="mb-5" @submit.prevent="searchTag">
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
                autofocus
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
      </v-col>
    </v-row>
    <template v-if="!tags.length && afterSearch">
      <v-col cols="12">
        <NoContentDisplay
          icon="mdi-emoticon-sad-outline"
          text="一致する検索結果はありませんでした。キーワードを変えて検索してみてください。"
        />
      </v-col>
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
          <TagLinkCard :tag-id="tag.id" :tag-name="tag.name" />
        </v-col>
      </v-row>
    </template>
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'
import Loading from '~/components/layout/Loading.vue'
import TagLinkCard from '~/components/tag/TagLinkCard.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'

export default {
  components: {
    PageHeader,
    Loading,
    TagLinkCard,
    NoContentDisplay
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
