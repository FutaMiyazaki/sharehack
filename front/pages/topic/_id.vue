<template>
  <v-container class="pt-0">
    <PageHeader :text="pageHeadertext" />
    <Loading v-show="loadShow" />
    <v-row justify="center">
      <v-col cols="12" md="4">
        <UserInformation :user="user" />
        <div style="position: sticky; top: 70px">
          <v-card flat class="mb-2 rounded-lg" color="secondary">
            <v-card-text class="text-caption black--text">
              <p
                style="white-space:pre-wrap;"
                class="mb-0"
                v-text="topic.description"
              ></p>
            </v-card-text>
          </v-card>
          <p class="mb-5 text-caption text-right">
            <v-icon small>mdi-clock-outline</v-icon>
            {{ $moment(topic.updated_at).format('YYYY/MM/DD HH:mm') }}
          </p>
          <v-row justify="center">
            <v-col
              v-if="isLoggedIn && currentUser.id == user.id"
              cols="12"
              class="text-center pt-0"
            >
              <LinkButton
                :link="'/topic/edit/' + topic.id"
                text="トピックを編集する"
                icon="chevron-right"
              />
            </v-col>
            <v-col cols="12" class="text-center">
              <v-btn
                block
                rounded
                color="primary"
                :to="'/topic/new-item/' + this.$route.params.id"
                class="text-center font-weight-bold"
              >
                投稿する<v-icon>mdi-chevron-right</v-icon>
              </v-btn>
            </v-col>
          </v-row>
        </div>
      </v-col>
      <template v-if="!loadShow">
        <v-col cols="12" md="8" class="mt-5">
          <v-row>
            <v-col
              v-for="item in items"
              :key="item.id"
              cols="12"
              lg="4"
              md="6"
              sm="6"
            >
              <ItemCard :item="item" />
            </v-col>
          </v-row>
          <template v-if="!items.length && afterSearch">
            <v-col cols="12">
              <NoContentDisplay
                icon="mdi-emoticon-sad-outline"
                text="このトピックに関する投稿はありません"
              />
            </v-col>
          </template>
        </v-col>
      </template>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import Loading from '~/components/layout/Loading.vue'
import LinkButton from '~/components/layout/LinkButton.vue'
import ItemCard from '~/components/item/ItemCard.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'
import UserInformation from '~/components/user/UserInformation.vue'

export default {
  components: {
    PageHeader,
    Loading,
    LinkButton,
    ItemCard,
    NoContentDisplay,
    UserInformation
  },
  validate({ params }) {
    return !isNaN(+params.id)
  },
  data() {
    return {
      pageHeadertext: '',
      loadShow: true,
      afterSearch: false,
      topic: {},
      user: {
        picture: {}
      },
      items: []
    }
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn',
      currentUser: 'authentication/currentUser'
    })
  },
  created() {
    this.$axios
      .get(`api/v1/topics/${this.$route.params.id}`)
      .then((response) => {
        this.loadShow = false
        this.afterSearch = true
        this.topic = response.data
        this.user = response.data.user
        this.items = this.topic.items
        this.pageHeadertext = this.topic.title
      })
      .catch((error) => {
        this.loadShow = false
        this.afterSearch = true
        return error
      })
  },
  head() {
    return {
      title: this.topic.title
    }
  }
}
</script>
