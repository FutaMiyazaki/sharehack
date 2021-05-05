<template>
  <header>
    <v-app-bar app>
      <v-app-bar-nav-icon
        class="hidden-md-and-up"
        @click="drawer = true"
      ></v-app-bar-nav-icon>
      <v-toolbar-title>Sharehack</v-toolbar-title>
      <v-tabs class="hidden-md-and-down">
        <v-tab>
          <nuxt-link to="/"> <v-icon>mdi-home</v-icon>Home </nuxt-link>
        </v-tab>
        <v-tab><v-icon>mdi-information</v-icon>About</v-tab>
      </v-tabs>
      <v-spacer />
      <v-btn class="mr-3">
        <nuxt-link to="/users/login">ログイン</nuxt-link>
      </v-btn>
      <v-btn>
        <nuxt-link to="/users/signup">新規登録</nuxt-link>
      </v-btn>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" fixed temporary>
      <v-list nav dense>
        <v-list-item-group>
          <v-list-item>
            <v-list-item-title>Home</v-list-item-title>
          </v-list-item>
          <v-list-item>
            <v-list-item-title>About</v-list-item-title>
          </v-list-item>
          <v-list-item>
            <v-list-item-title>新規登録</v-list-item-title>
          </v-list-item>
          <v-list-item>
            <v-list-item-title>ログイン</v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </header>
</template>

<script>
export default {
  data() {
    return {
      drawer: false
    }
  }
}
</script>

<style scoped>
a {
  text-decoration: none;
}
</style>
