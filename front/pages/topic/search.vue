<template>
  <v-container class="pt-0">
    <PageHeader :text="pageHeaderText" />
    <v-row justify="center">
      <v-col cols="12" md="8">
        <ValidationObserver v-slot="{ invalid }">
          <v-form lazy-validation class="mb-5" @submit.prevent="searchTopic">
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
                    @click="searchTopic"
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
    <template v-if="!topics.length && afterSearch">
      <NoContentDisplay
        icon="mdi-emoticon-sad-outline"
        text="一致する検索結果はありませんでした。キーワードを変えて検索してみてください。"
      />
    </template>
    <template v-if="topics.length && afterSearch">
      <v-row justify="center">
        <v-col cols="12" md="7">
          <v-col cols="12" class="pa-0">
            <v-banner>トピック</v-banner>
          </v-col>
          <v-card flat>
            <v-list three-line class="py-0">
              <v-list-item
                v-for="topic in topics"
                :key="topic.id"
                :to="'/topic/' + topic.id"
                nuxt
              >
                <v-list-item-avatar>
                  <v-icon v-if="!topic.user.avatar_url" large color="primary">
                    mdi-account-circle
                  </v-icon>
                  <v-img
                    v-else
                    alt="ユーザーのプロフィール画像"
                    :src="topic.user.avatar_url"
                  />
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-subtitle class="text-caption black--text">
                    作成者：{{ topic.user.name }}
                  </v-list-item-subtitle>
                  <v-list-item-title
                    class="text-subtitle-2 text-decoration-underline blue--text text--lighten-2"
                  >
                    {{ topic.title }}
                  </v-list-item-title>
                  <v-list-item-subtitle class="text-caption">
                    {{ topic.items.length }}件の投稿
                  </v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-list>
          </v-card>
        </v-col>
      </v-row>
    </template>
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'
import Loading from '~/components/layout/Loading.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'

export default {
  components: {
    PageHeader,
    Loading,
    NoContentDisplay
  },
  data() {
    return {
      pageHeaderText: 'トピックの検索',
      topics: [],
      keyword: '',
      loadShow: false,
      afterSearch: false
    }
  },
  methods: {
    async searchTopic() {
      if (!this.keyword) {
        return false
      }
      this.loadShow = true
      await this.$axios
        .$get('/api/v1/topics/search', {
          params: {
            keyword: this.keyword
          }
        })
        .then((response) => {
          console.log(response)
          this.afterSearch = true
          this.loadShow = false
          this.topics = response
          this.pageHeaderText = `${this.keyword}の検索結果：${this.topics.length}件`
        })
        .catch((error) => {
          this.afterSearch = true
          this.loadShow = false
          return error
        })
    }
  },
  head() {
    return {
      title: 'トピックの検索'
    }
  }
}
</script>
