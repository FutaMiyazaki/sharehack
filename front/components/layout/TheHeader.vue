<template>
  <header>
    <v-app-bar app>
      <v-toolbar-title class="mr-2">
        <nuxt-link to="/" class="black--text">Sharehack</nuxt-link>
      </v-toolbar-title>
      <!-- <v-tabs class="hidden-md-and-down">
        <v-tab>
          <nuxt-link to="/"> <v-icon>mdi-home</v-icon>Home </nuxt-link>
        </v-tab>
      </v-tabs> -->
      <v-spacer />
      <header-menu />
      <template v-if="!isLoggedIn">
        <v-btn rounded class="mr-3 hidden-sm-and-down">
          <nuxt-link to="/users/login" class="black--text">ログイン</nuxt-link>
        </v-btn>
        <v-btn rounded class="hidden-sm-and-down">
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
      class="hidden-md-and-up"
    >
      <v-list nav dense>
        <v-list-item-group>
          <template v-if="!isLoggedIn">
            <v-list-item>
              <nuxt-link to="/users/login" class="black--text">
                <v-list-item-title
                  ><v-icon>mdi-login</v-icon>ログイン</v-list-item-title
                >
              </nuxt-link>
            </v-list-item>
            <v-list-item>
              <nuxt-link to="/users/signup" class="black--text">
                <v-list-item-title
                  ><v-icon>mdi-pencil</v-icon>新規登録</v-list-item-title
                >
              </nuxt-link>
            </v-list-item>
          </template>
          <v-list-item>
            <v-list-item-title
              ><v-icon>mdi-jabber</v-icon>ライフハックを探す</v-list-item-title
            >
          </v-list-item>
          <v-list-item>
            <v-list-item-title
              ><v-icon>mdi-tools</v-icon
              >ライフハックアイテムを探す</v-list-item-title
            >
          </v-list-item>
          <template v-if="isLoggedIn">
            <v-list-item>
              <nuxt-link to="/users/settings" class="black--text">
                <v-list-item-title
                  ><v-icon>mdi-cog</v-icon>設定</v-list-item-title
                >
              </nuxt-link>
            </v-list-item>
            <v-list-item v-if="isLoggedIn" class="black--text" @click="logout">
              <v-list-item-title
                ><v-icon>mdi-logout</v-icon>ログアウト</v-list-item-title
              >
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
