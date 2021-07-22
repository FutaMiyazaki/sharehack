<template>
  <v-container class="pt-0">
    <PageHeader :text="pageHeadertext" />
    <Loading v-show="loadShow" />
    <v-row justify="center">
      <v-col cols="12" md="4">
        <div style="position: sticky; top: 70px">
          <v-card flat class="mb-5">
            <v-card-text class="text-caption">
              <p
                style="white-space:pre-wrap;"
                class="mb-0"
                v-text="topic.description"
              ></p>
            </v-card-text>
          </v-card>
          <v-row justify="center">
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
        <v-col cols="12" md="8">
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
            <NoContentDisplay
              icon="mdi-emoticon-sad-outline"
              text="まだこのトピックに関する投稿がありません"
            />
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
import ItemCard from '~/components/item/ItemCard.vue'
import NoContentDisplay from '~/components/item/NoContentDisplay.vue'

export default {
  components: {
    PageHeader,
    Loading,
    ItemCard,
    NoContentDisplay
  },
  data() {
    return {
      pageHeadertext: '',
      loadShow: true,
      afterSearch: false,
      topic: {},
      items: []
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
  },
  created() {
    this.$axios
      .get(`api/v1/topics/${this.$route.params.id}`)
      .then((response) => {
        console.log('取得成功!!!')
        console.log(response)
        this.loadShow = false
        this.afterSearch = true
        this.topic = response.data
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
