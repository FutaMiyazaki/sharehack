<template>
  <header>
    <v-app-bar color="#383838" app flat fixed>
      <v-toolbar-title class="mr-2 header-title">
        <nuxt-link to="/" class="white--text font-weight-bold">
          Sharehack
        </nuxt-link>
      </v-toolbar-title>
      <v-spacer />
      <SearchItemForm />
      <template v-if="isLoggedIn">
        <v-menu offset-y rounded="lg">
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              text
              v-bind="attrs"
              class="hidden-sm-and-down font-weight-bold mr-2"
              color="white"
              v-on="on"
            >
              <v-icon small class="mr-2">
                mdi-pencil-box-multiple
              </v-icon>
              投稿する
            </v-btn>
          </template>
          <v-list>
            <v-list-item nuxt to="/item/new">アイテムを投稿する</v-list-item>
            <v-list-item nuxt to="/topic/new">トピックを投稿する</v-list-item>
          </v-list>
        </v-menu>
        <v-menu offset-y rounded="lg">
          <template v-slot:activator="{ on, attrs }">
            <v-btn icon v-bind="attrs" class="hidden-sm-and-down" v-on="on">
              <v-list-item dense>
                <v-list-item-avatar class="mx-auto">
                  <v-icon v-if="!currentUserAvatar" large color="white">
                    mdi-account-circle
                  </v-icon>
                  <v-img
                    v-else
                    alt="ユーザーのプロフィール画像"
                    :src="currentUserAvatar"
                  />
                </v-list-item-avatar>
              </v-list-item>
            </v-btn>
          </template>
          <v-list>
            <v-list-item nuxt :to="'/users/' + currentUser.id">
              マイページ
            </v-list-item>
            <v-divider class="my-2" />
            <v-list-item nuxt to="/item/timeline?page=1">
              タイムライン
            </v-list-item>
            <v-list-item nuxt to="/tag/search">
              タグを探す
            </v-list-item>
            <v-list-item nuxt to="/topic/search">
              トピックを探す
            </v-list-item>
            <v-divider class="my-2" />
            <v-list-item nuxt to="/users/setting">
              設定
            </v-list-item>
            <v-divider class="my-2" />
            <v-list-item @click="logoutUser">
              ログアウト
            </v-list-item>
          </v-list>
        </v-menu>
      </template>
      <template v-if="!isLoggedIn">
        <v-btn
          rounded
          depressed
          class="hidden-sm-and-down font-weight-bold mr-3"
          to="/users/login"
        >
          <span>ログイン</span>
        </v-btn>
        <v-btn
          rounded
          depressed
          color="primary"
          class="hidden-sm-and-down font-weight-bold white--text"
          to="/users/signup"
        >
          新規登録
        </v-btn>
      </template>

      <v-app-bar-nav-icon
        class="hidden-md-and-up"
        color="white"
        @click="drawer = true"
      />
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      right
      fixed
      temporary
      width="80%"
      class="hidden-md-and-up drawer-background-color"
    >
      <v-list nav class="pa-0 text-center">
        <v-toolbar flat class="drawer-background-color">
          <v-icon class="ml-auto black--text" @click="drawer = false">
            mdi-close
          </v-icon>
        </v-toolbar>
        <ValidationObserver ref="observer" v-slot="{ invalid }">
          <v-form class="mx-2 mb-2" @submit.prevent="search">
            <ValidationProvider rules="required|max:50" mode="aggressive">
              <v-text-field
                v-model.trim="keyword"
                flat
                solo
                dense
                rounded
                outlined
                hide-details
                label="アイテムを検索"
                background-color="secondary"
              >
                <template v-slot:append>
                  <v-btn
                    icon
                    small
                    depressed
                    :disabled="invalid"
                    @click="search"
                  >
                    <v-icon>mdi-magnify</v-icon>
                  </v-btn>
                </template>
              </v-text-field>
            </ValidationProvider>
          </v-form>
        </ValidationObserver>
        <v-list-item-group class="px-2">
          <template v-if="!isLoggedIn">
            <v-list-item
              nuxt
              color="white"
              to="/users/login"
              class="text-center mb-0 px-0"
            >
              <v-btn
                block
                outlined
                color="black"
                class="font-weight-bold text-caption"
              >
                ログイン
              </v-btn>
            </v-list-item>
            <v-list-item
              nuxt
              color="white"
              to="/users/signup"
              class="text-caption black--text text-center mb-0 px-0"
            >
              <v-btn
                block
                color="black"
                class="font-weight-bold text-caption white--text"
              >
                新規登録
              </v-btn>
            </v-list-item>
            <v-divider class="my-3" color="white" />
            <NavigationItem link="/" text="トップページ" />
            <NavigationItem link="/item/ranking?page=1" text="人気の投稿" />
            <NavigationItem link="/tag/search" text="タグを探す" />
            <NavigationItem link="/topic/list?page=1" text="トピックを探す" />
          </template>
          <template v-if="isLoggedIn">
            <v-list-item
              nuxt
              color="white"
              to="/item/new"
              class="text-center mb-0 px-0"
            >
              <v-btn
                block
                outlined
                color="black"
                class="font-weight-bold text-caption"
              >
                アイテムを投稿する
              </v-btn>
            </v-list-item>
            <v-list-item
              nuxt
              color="white"
              to="/topic/new"
              class="text-center mb-0 px-0"
            >
              <v-btn
                block
                color="black"
                class="font-weight-bold text-caption white--text"
              >
                トピックを投稿する
              </v-btn>
            </v-list-item>
            <NavigationItem
              :link="'/users/' + currentUser.id"
              text="マイページ"
            />
            <NavigationItem link="/item/timeline?page=1" text="タイムライン" />
            <NavigationItem link="/item/ranking?page=1" text="人気の投稿" />
            <NavigationItem link="/tag/search" text="タグを探す" />
            <NavigationItem link="/topic/list?page=1" text="トピックを探す" />
            <NavigationItem link="/users/setting" text="設定" />
            <v-list-item nuxt class="text-center mb-0 px-0">
              <v-btn
                text
                block
                small
                class="font-weight-bold black--text text-caption"
                @click="logoutUser"
              >
                ログアウト
              </v-btn>
            </v-list-item>
          </template>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </header>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import NavigationItem from '~/components/layout/NavigationItem.vue'
import SearchItemForm from '~/components/layout/SearchItemForm.vue'

export default {
  components: {
    NavigationItem,
    SearchItemForm
  },
  data() {
    return {
      drawer: false,
      keyword: ''
    }
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn',
      currentUser: 'authentication/currentUser',
      currentUserAvatar: 'authentication/currentUserAvatar'
    })
  },
  methods: {
    ...mapActions({
      logout: 'authentication/logout'
    }),
    logoutUser() {
      this.logout()
      this.drawer = false
    },
    search() {
      this.$router.push({
        path: '/item/search',
        query: { keyword: this.keyword, page: 1 }
      })
      this.keyword = ''
      this.$refs.observer.reset()
    }
  }
}
</script>

<style scoped>
a {
  text-decoration: none;
}

.menu-item {
  text-decoration: none;
  color: black;
  font-size: 5px;
}

.hover-color:hover {
  background-color: #e5e5e5;
}

.header-title:hover {
  opacity: 0.5;
}
</style>
