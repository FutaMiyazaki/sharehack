<template>
  <v-container class="pt-0">
    <PageHeader text="トピック一覧" />
    <Loading v-show="loadShow" />
    <template v-if="!loadShow">
      <v-row justify="center">
        <v-col cols="12" md="8">
          <ValidationObserver v-slot="{ invalid }">
            <v-form lazy-validation class="my-4" @submit.prevent="searchTopic">
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
                  label="トピックを検索"
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
        <v-col cols="12" md="8">
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
      <v-pagination
        v-if="totalPages != 1"
        v-model="showPages"
        :length="totalPages"
        circle
        class="my-5"
        @input="pageChange"
      />
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
      keyword: '',
      loadShow: true,
      topicTitle: '',
      topics: [],
      showPages: 1,
      totalPages: 0,
      totalCount: ''
    }
  },
  computed: {},
  created() {
    this.$axios
      .get('api/v1/topics')
      .then((response) => {
        this.totalCount = response.data.length
        this.totalPages = Math.ceil(this.totalCount / 12)
      })
      .catch((error) => {
        return error
      })

    this.$axios
      .get('api/v1/topics', {
        params: {
          page: this.$route.query.page
        }
      })
      .then((response) => {
        this.loadShow = false
        this.topics = response.data
      })
      .catch((error) => {
        this.loadShow = false
        return error
      })
  },
  methods: {
    async pageChange(number) {
      this.$router.push({ path: '/topic/list', query: { page: number } })
      window.scrollTo({
        top: 0,
        behavior: 'instant'
      })
      this.loadShow = true
      await this.$axios
        .get('/api/v1/topics', {
          params: {
            page: number
          }
        })
        .then((response) => {
          this.loadShow = false
          this.topics = response.data
        })
        .catch((error) => {
          this.loadShow = false
          return error
        })
    },
    searchTopic() {
      this.$router.push({
        path: '/topic/search',
        query: { keyword: this.keyword }
      })
    }
  },
  head() {
    return {
      title: 'トピック一覧'
    }
  }
}
</script>
