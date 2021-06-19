<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row class="mt-5">
      <v-col cols="12" sm="4">
        <UserProfile
          :user-name="user.name"
          :items-count="itemLikes.length"
          :user-id="user.id"
          :current-user="currentUserId"
          selected-item="1"
        />
      </v-col>
      <v-col cols="12" sm="8">
        <v-row>
          <v-col v-for="itemLike in itemLikes" :key="itemLike.id" :cols="6">
            <ItemCard :item="itemLike.item" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
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
      selectedItem: 1,
      text: '',
      user: {},
      itemLikes: [],
      currentUserId: ''
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}/like`)
      .then((response) => {
        this.user = response.data
        this.itemLikes = this.user.item_likes
        this.text = this.user.name + 'のいいね一覧'
        this.currentUserId = this.$store.getters[
          'authentication/currentUser'
        ].id
      })
      .catch((error) => {
        console.log('情報の取得に失敗')
        console.log(error)
      })
  }
}
</script>
