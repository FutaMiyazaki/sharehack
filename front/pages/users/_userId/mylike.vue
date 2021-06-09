<template>
  <v-container class="pt-0">
    <PageHeader :text="text" />
    <v-row class="mt-5">
      <v-col cols="12" sm="4">
        <v-card class="mx-auto" tile>
          <v-list>
            <v-list-item>
              <v-list-item-avatar> </v-list-item-avatar>
            </v-list-item>
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title class="text-center">
                  {{ user.name }}
                </v-list-item-title>
                <v-list-item-subtitle class="text-center">
                  {{ items.length }}件の投稿
                </v-list-item-subtitle>
                <v-divider class="my-5" />
                <div>
                  <v-btn v-show="currentUser !== user.id" block>
                    <v-icon class="mr-3" color="primary"
                      >mdi-account-plus</v-icon
                    >
                    <p class="my-auto">フォローする</p>
                  </v-btn>
                  <v-btn
                    v-show="currentUser === user.id"
                    outlined
                    block
                    color="primary"
                    @click="toSetting"
                  >
                    <v-icon class="mr-3">mdi-cog</v-icon>
                    <p class="my-auto">アカウントを編集する</p>
                  </v-btn>
                </div>
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <v-divider></v-divider>
          <v-list nav dense>
            <v-list-item-group v-model="selectedItem" color="primary">
              <v-list-item v-for="(menuItem, i) in menuItems" :key="i">
                <v-list-item-icon>
                  <v-icon v-text="menuItem.icon"></v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title v-text="menuItem.text"></v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-card>
      </v-col>

      <v-col cols="12" sm="8">
        <v-row>
          <v-col v-for="item in items" :key="item.id" :cols="6">
            <v-card @click="toPost(item.id)">
              <v-card-title>{{ item.name }}</v-card-title>
              <v-img
                max-height="auto"
                max-width="100%"
                :src="item.image_url"
              ></v-img>
            </v-card>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'

export default {
  components: {
    PageHeader
  },
  data() {
    return {
      selectedItem: 0,
      menuItems: [
        { text: 'すべての投稿', icon: 'mdi-folder' },
        { text: 'いいねした投稿', icon: 'mdi-account-multiple' },
        { text: 'ライフハック', icon: 'mdi-star' }
      ],
      text: '',
      user: {},
      items: [],
      currentUser: this.$store.getters['authentication/currentUser'].id
    }
  },
  created() {
    this.$axios
      .get(`api/v1/users/${this.$route.params.id}`)
      .then((response) => {
        console.log('ユーザー情報の取得に成功')
        this.user = response.data
        this.items = this.user.items
        this.text = this.user.name
        console.log(response)
      })
      .catch((error) => {
        console.log('ユーザー情報の取得に失敗')
        console.log(error)
      })
  },
  methods: {
    toPost(id) {
      this.$router.push(`/item/${id}`)
    },
    toSetting() {
      this.$router.push('/users/settings')
    }
  }
}
</script>
