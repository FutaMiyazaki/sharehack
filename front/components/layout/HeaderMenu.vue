<template>
  <v-menu offset-y>
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        rounded
        color="primary"
        v-bind="attrs"
        class="hidden-sm-and-down"
        v-on="on"
      >
        <v-icon>mdi-account-circle</v-icon><v-icon>mdi-menu-down</v-icon>
      </v-btn>
    </template>
    <v-list>
      <nuxt-link to="/users/settings" class="menu-item">
        <v-list-item class="hover-color">
          <v-list-item-title> <v-icon>mdi-cog</v-icon>設定 </v-list-item-title>
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
