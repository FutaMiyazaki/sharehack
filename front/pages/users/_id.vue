<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row class="mt-5">
      <v-col cols="12" sm="4">
        <UserProfile
          :user-name="user.name"
          :items-count="items.length"
          :user-id="user.id"
          :current-user-id="currentUserId"
          selected-item="0"
        />
      </v-col>
      <v-col cols="12" sm="8">
        <v-row>
          <v-col v-for="item in items" :key="item.id" :cols="6">
            <ItemCard :item="item" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import UserProfile from '~/components/user/UserProfile.vue'
import ItemCard from '~/components/item/ItemCard.vue'

export default {
  components: {
    PageHeader,
    UserProfile,
    ItemCard
  },
  data() {
    return {
      selectedItem: 0,
      text: '',
      user: {},
      items: [],
      currentUserId: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        this.user = response.data
        this.items = this.user.items
        this.text = this.user.name + 'の投稿一覧'
        this.currentUserId = this.$store.getters[
          'authentication/currentUser'
        ].id
      })
      .catch((error) => {
        console.log('ユーザー情報の取得に失敗')
        console.log(error)
      })
  }
}
</script>
