<template>
  <header>
    <v-app-bar color="#fbfbfb">
      <v-toolbar-title class="mr-2">
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
            <v-btn
              color="primary"
              v-bind="attrs"
              class="hidden-sm-and-down"
              v-on="on"
            >
              <v-icon>mdi-account-circle</v-icon><v-icon>mdi-menu-down</v-icon>
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
          text
          class="hidden-sm-and-down font-weight-bold mr-3"
          to="/users/login"
        >
          <span>ログイン</span>
        </v-btn>
        <v-btn
          color="primary"
          class="hidden-sm-and-down font-weight-bold white--text"
          to="/users/signup"
        >
          新規登録
        </v-btn>
      </template>
      <v-app-bar-nav-icon
        class="hidden-md-and-up"
        @click="drawer = true"
      ></v-app-bar-nav-icon>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      right
      fixed
      temporary
      color="#757575"
      width="100%"
      class="hidden-md-and-up"
    >
      <v-list nav dense>
        <v-list-item-group>
          <v-list-item>
            <v-icon color="white" class="ml-auto" @click="drawer = false"
              >mdi-close</v-icon
            >
          </v-list-item>
          <v-divider color="white" />
          <template v-if="!isLoggedIn">
            <NavigationItem
              link="/users/login"
              icon-color="white"
              icon="mdi-login"
              list-item-title-class="white--text font-weight-bold"
              text="ログイン"
            />
            <v-divider color="white" />
            <NavigationItem
              link="/users/signup"
              icon-color="white"
              icon="mdi-account-plus-outline"
              list-item-title-class="white--text font-weight-bold"
              text="新規登録"
            />
            <v-divider color="white" />
          </template>
          <template v-if="isLoggedIn">
            <v-list-item two-line>
              <v-list-item-avatar>
                <img src="https://randomuser.me/api/portraits/women/81.jpg" />
              </v-list-item-avatar>
              <v-list-item-content>
                <v-list-item-title class="white--text font-weight-bold">{{
                  currentUser.name
                }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </template>
          <NavigationItem
            v-if="!isLoggedIn"
            link="/"
            icon-color="white"
            icon="mdi-home-outline"
            list-item-title-class="white--text font-weight-bold"
            text="トップページ"
          />
          <v-divider color="white" />
          <template v-if="isLoggedIn">
            <NavigationItem
              link="/item/create"
              icon-color="white"
              icon="mdi-pencil-outline"
              list-item-title-class="white--text font-weight-bold"
              text="投稿する"
            />
            <v-divider color="white" />
            <NavigationItem
              :link="'/users/' + currentUser.id"
              icon-color="white"
              icon="mdi-account-outline"
              list-item-title-class="white--text font-weight-bold"
              text="マイページ"
            />
            <v-divider color="white" />
            <NavigationItem
              link="/users/setting"
              icon-color="white"
              icon="mdi-cog-outline"
              list-item-title-class="white--text font-weight-bold"
              text="設定"
            />
            <v-divider color="white" />
            <v-list-item @click="logoutUser">
              <v-list-item-icon>
                <v-icon color="white">mdi-logout</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title class="white--text font-weight-bold">
                  ログアウト
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-divider color="white" />
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
      drawer: false
    }
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn',
      currentUser: 'authentication/currentUser'
    })
  },
  methods: {
    ...mapActions({
      logout: 'authentication/logout'
    }),
    logoutUser() {
      this.logout()
      this.drawer = false
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
</style>
