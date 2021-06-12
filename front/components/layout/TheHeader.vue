<template>
  <header>
    <v-app-bar color="#fbfbfb">
      <v-toolbar-title class="mr-2">
        <nuxt-link to="/" class="black--text font-weight-bold">
          Sharehack
        </nuxt-link>
      </v-toolbar-title>
      <!-- <v-tabs class="hidden-md-and-down">
        <v-tab>
          <nuxt-link to="/"> <v-icon>mdi-home</v-icon>Home </nuxt-link>
        </v-tab>
      </v-tabs> -->
      <v-spacer />
      <template v-if="isLoggedIn">
        <v-btn rounded class="mr-3 hidden-sm-and-down">
          <nuxt-link to="/item/create" class="black--text">
            アイテムを投稿
          </nuxt-link>
        </v-btn>
        <HeaderMenu />
      </template>
      <template v-if="!isLoggedIn">
        <v-btn outlined class="mr-3 hidden-sm-and-down">
          <nuxt-link to="/users/login" class="black--text">ログイン</nuxt-link>
        </v-btn>
        <v-btn text color="primary" class="hidden-sm-and-down">
          <nuxt-link to="/users/signup" class="black--text">新規登録</nuxt-link>
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
      width="70%"
      class="hidden-md-and-up"
    >
      <v-list nav dense>
        <v-list-item-group>
          <template v-if="!isLoggedIn">
            <NavigationItem
              link="/users/login"
              icon="mdi-login"
              text="ログイン"
            />
            <NavigationItem
              link="/users/signup"
              icon="mdi-pencil"
              text="新規登録"
            />
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
            <v-divider color="white" class="mb-3"></v-divider>
          </template>
          <NavigationItem
            v-if="!isLoggedIn"
            link="/"
            icon="mdi-home-outline"
            text="トップページ"
          />
          <template v-if="isLoggedIn">
            <NavigationItem
              link="/item/create"
              icon="mdi-pencil-outline"
              text="投稿する"
            />
            <NavigationItem
              :link="'/users/' + currentUser.id"
              icon="mdi-account-outline"
              text="マイページ"
            />
            <NavigationItem
              link="/users/setting"
              icon="mdi-cog-outline"
              text="設定"
            />
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
          </template>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </header>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import HeaderMenu from '~/components/layout/HeaderMenu.vue'
import NavigationItem from '~/components/layout/NavigationItem.vue'

export default {
  components: {
    HeaderMenu,
    NavigationItem
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
</style>
