<template>
  <header>
    <v-app-bar color="#fbfbfb" app fixed>
      <v-toolbar-title class="mr-2 header-title">
        <nuxt-link to="/" class="black--text font-weight-bold">
          Sharehack
        </nuxt-link>
      </v-toolbar-title>
      <v-spacer />
      <SearchForm />
      <v-spacer />
      <template v-if="isLoggedIn">
        <ToItemCreateButton />
        <v-menu offset-y>
          <template v-slot:activator="{ on, attrs }">
            <v-btn icon v-bind="attrs" class="hidden-sm-and-down" v-on="on">
              <v-list-item dense>
                <v-list-item-avatar class="mx-auto">
                  <v-icon v-if="!currentUserAvatar" large color="primary">
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
            <NavigationItem
              link="/item/create"
              icon="mdi-pencil"
              text="投稿する"
            />
            <NavigationItem
              :link="'/users/' + currentUser.id"
              icon="mdi-account"
              text="マイページ"
            />
            <NavigationItem link="/users/setting" icon="mdi-cog" text="設定" />
            <v-list-item @click="logoutUser">
              <v-list-item-icon>
                <v-icon>mdi-logout</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>
                  ログアウト
                </v-list-item-title>
              </v-list-item-content>
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
      <v-app-bar-nav-icon class="hidden-md-and-up" @click="drawer = true" />
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      right
      fixed
      temporary
      width="80%"
      class="hidden-md-and-up"
    >
      <v-list nav dense>
        <v-toolbar flat>
          <v-spacer />
          <v-btn icon right @click="drawer = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
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
                label="キーワード検索"
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

        <v-list-item-group>
          <template v-if="!isLoggedIn">
            <NavigationItem
              link="/users/login"
              icon="mdi-login"
              list-item-title-class="font-weight-bold"
              text="ログイン"
            />
            <NavigationItem
              link="/users/signup"
              icon="mdi-account-plus-outline"
              list-item-title-class="font-weight-bold"
              text="新規登録"
            />
          </template>
          <NavigationItem
            v-if="!isLoggedIn"
            link="/"
            icon="mdi-home-outline"
            list-item-title-class="font-weight-bold"
            text="トップページ"
          />
          <template v-if="isLoggedIn">
            <NavigationItem
              link="/item/create"
              icon="mdi-pencil-outline"
              list-item-title-class="font-weight-bold"
              text="投稿する"
            />
            <NavigationItem
              :link="'/users/' + currentUser.id"
              icon="mdi-account-outline"
              list-item-title-class="font-weight-bold"
              text="マイページ"
            />
            <NavigationItem
              link="/users/setting"
              icon="mdi-cog-outline"
              list-item-title-class="font-weight-bold"
              text="設定"
            />
            <v-list-item @click="logoutUser">
              <v-list-item-icon>
                <v-icon>mdi-logout</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title class="font-weight-bold">
                  ログアウト
                </v-list-item-title>
              </v-list-item-content>
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
import SearchForm from '~/components/layout/SearchForm.vue'
import ToItemCreateButton from '~/components/layout/ToItemCreateButton.vue'

export default {
  components: {
    NavigationItem,
    SearchForm,
    ToItemCreateButton
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
