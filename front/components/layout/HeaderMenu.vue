<template>
  <v-menu v-if="isLoggedIn" offset-y>
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="primary" v-bind="attrs" v-on="on">
        アカウントメニュー
      </v-btn>
    </template>
    <v-list>
      <nuxt-link to="/users/account" class="menu-item">
        <v-list-item class="hover-color">
          <v-list-item-title>
            <v-icon>mdi-cog</v-icon>アカウント情報
          </v-list-item-title>
        </v-list-item>
      </nuxt-link>
      <nuxt-link to="/users/edit" class="menu-item">
        <v-list-item class="hover-color">
          <v-list-item-title>アカウント編集</v-list-item-title>
        </v-list-item>
      </nuxt-link>
      <v-list-item class="menu-item hover-color" @click="logout">
        <v-list-item-title>
          <v-icon>mdi-logout</v-icon>ログアウト
        </v-list-item-title>
      </v-list-item>
    </v-list>
  </v-menu>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
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
.menu-item {
  text-decoration: none;
  color: black;
  font-size: 5px;
}

.hover-color:hover {
  background-color: #e5e5e5;
}
</style>
