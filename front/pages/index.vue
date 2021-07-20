<template>
  <v-container class="pt-0">
    <v-row class="mt-3">
      <v-col cols="12" md="4">
        <v-banner>探す</v-banner>
        <v-list nav dense rounded>
          <v-list-item-group v-model="selectedItem" color="primary">
            <v-list-item @click="currentComponent = 'LatestItems'">
              <v-list-item-icon>
                <v-icon>mdi-rss</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>最新の投稿</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item @click="currentComponent = 'RankingItems'">
              <v-list-item-icon>
                <v-icon>mdi-trending-up</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>人気の投稿</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item
              v-if="isLoggedIn"
              @click="currentComponent = 'TimeLine'"
            >
              <v-list-item-icon>
                <v-icon>mdi-clock-outline</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>タイムライン</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-list>
        <v-row class="mt-4 hidden-sm-and-down">
          <v-col cols="12">
            <v-banner>タグ</v-banner>
            <v-list dense>
              <v-list-item-group color="primary">
                <v-list-item
                  v-for="tag in tags"
                  :key="tag.id"
                  @click="toTagItems(tag.id)"
                >
                  <v-list-item-content>
                    <v-list-item-title v-text="tag.name"></v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </v-col>
        </v-row>
        <v-row justify="center" class="mb-5 hidden-sm-and-down">
          <v-col cols="12" class="text-center">
            <LinkButton
              link="/tag/search"
              text="タグを探す"
              icon="chevron-right"
            />
          </v-col>
        </v-row>
      </v-col>
      <v-col cols="12" lg="8" md="8">
        <component :is="currentComponent" />
      </v-col>
    </v-row>
    <v-row class="mt-4 hidden-md-and-up">
      <v-col cols="12">
        <v-banner>タグ</v-banner>
        <v-list dense>
          <v-list-item-group color="primary">
            <v-list-item
              v-for="tag in tags"
              :key="tag.id"
              @click="toTagItems(tag.id)"
            >
              <v-list-item-content>
                <v-list-item-title v-text="tag.name"></v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-col>
    </v-row>
    <v-row justify="center" class="mb-5 hidden-md-and-up">
      <v-col cols="12" class="text-center">
        <LinkButton link="/tag/search" text="タグを探す" icon="chevron-right" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LatestItems from '~/components/index/LatestItems.vue'
import RankingItems from '~/components/index/RankingItems.vue'
import TimeLine from '~/components/index/TimeLine.vue'
import TagLinkCard from '~/components/tag/TagLinkCard.vue'
import LinkButton from '~/components/layout/LinkButton.vue'

export default {
  components: {
    LatestItems,
    RankingItems,
    TimeLine,
    TagLinkCard,
    LinkButton
  },
  data() {
    return {
      selectedItem: 0,
      currentComponent: 'LatestItems',
      tags: []
    }
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn',
      currentUser: 'authentication/currentUser',
      currentUserAvatar: 'authentication/currentUserAvatar'
    })
  },
  created() {
    this.$axios
      .get('api/v1/tags/top')
      .then((response) => {
        this.tags = response.data
      })
      .catch((error) => {
        return error
      })
    if (this.isLoggedIn && !this.currentUserAvatar) {
      this.getAvatar(this.currentUser?.id)
    }
  },
  methods: {
    ...mapActions({
      getAvatar: 'authentication/getAvatar'
    }),
    toTagItems(tagId) {
      this.$router.push({
        path: `/tag/${tagId}`,
        query: { keyword: this.keyword, page: 1 }
      })
    }
  },
  head() {
    return {
      title: 'Sharehack',
      titleTemplate: ''
    }
  }
}
</script>
