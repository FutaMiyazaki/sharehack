<template>
  <header>
    <v-app-bar app>
      <v-app-bar-nav-icon
        class="hidden-md-and-up"
        @click="drawer = true"
      ></v-app-bar-nav-icon>
      <v-toolbar-title class="mr-2">
        <nuxt-link to="/">Sharehack</nuxt-link>
      </v-toolbar-title>
      <!-- <v-tabs class="hidden-md-and-down">
        <v-tab>
          <nuxt-link to="/"> <v-icon>mdi-home</v-icon>Home </nuxt-link>
        </v-tab>
      </v-tabs> -->
      <v-spacer />
      <header-menu />
      <template v-if="!isLoggedIn" class="hidden-md-and-up">
        <v-btn class="mr-3">
          <nuxt-link to="/users/login">ログイン</nuxt-link>
        </v-btn>
        <v-btn>
          <nuxt-link to="/users/signup">新規登録</nuxt-link>
        </v-btn>
      </template>
    </v-app-bar>
    <v-navigation-drawer
      v-model="drawer"
      fixed
      temporary
      class="hidden-md-and-up"
    >
      <v-list nav dense>
        <v-list-item-group>
          <template v-if="!isLoggedIn">
            <v-list-item>
              <nuxt-link to="/users/login">
                <v-list-item-title>ログイン</v-list-item-title>
              </nuxt-link>
            </v-list-item>
            <v-list-item>
              <nuxt-link to="/users/signup">
                <v-list-item-title>新規登録</v-list-item-title>
              </nuxt-link>
            </v-list-item>
          </template>
          <v-list-item>
            <v-list-item-title>ライフハックを探す</v-list-item-title>
          </v-list-item>
          <v-list-item>
            <v-list-item-title>ライフハックアイテムを探す</v-list-item-title>
          </v-list-item>
          <v-list-item v-if="isLoggedIn" @click="logout">
            <v-list-item-title>ログアウト</v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </header>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import HeaderMenu from '~/components/layout/HeaderMenu.vue'

export default {
  components: {
    HeaderMenu
  },
  data() {
    return {
      drawer: false
    }
  },
  computed: {
    ...mapGetters({
      isLoggedIn: 'authentication/isLoggedIn'
    })
  },
  methods: {
    ...mapActions({
      logout: 'authentication/logout'
    })
  }
}
</script>

<style scoped>
a {
  text-decoration: none;
}
</style>
