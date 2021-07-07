<template>
  <v-card flat>
    <v-card-text>
      <v-card-actions class="justify-center">
        <v-dialog v-model="dialog" width="500">
          <template v-slot:activator="{ on, attrs }">
            <v-row justify="center">
              <v-col cols="12" sm="4">
                <v-btn
                  v-if="userEmail != guest"
                  text
                  block
                  rounded
                  color="warning"
                  v-bind="attrs"
                  v-on="on"
                >
                  アカウントを削除する
                </v-btn>
                <v-btn v-else text block rounded color="warning">
                  ゲストユーザーはアカウントを削除できません
                </v-btn>
              </v-col>
            </v-row>
          </template>

          <v-card>
            <v-btn icon absolute right @click="dialog = false">
              ✕
            </v-btn>
            <v-card-title class="mt-2 justify-center font-weight-bold">
              本当にアカウントを削除しますか？
            </v-card-title>
            <v-divider class="mb-5" />
            <v-card-text class="justify-center text-center">
              アカウントを削除するとこれまでの投稿や登録情報が削除され、元に戻すことはできません。よろしいでしょうか？
            </v-card-text>
            <v-card-actions class="justify-center">
              <v-btn
                rounded
                depressed
                class="font-weight-bold"
                width="35%"
                @click="dialog = false"
              >
                キャンセル
              </v-btn>
              <v-btn
                rounded
                color="warning"
                class="white--text font-weight-bold"
                width="35%"
                @click="deleteUser"
              >
                OK
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-card-actions>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      userEmail: this.$store.getters['authentication/currentUser'].uid,
      guest: 'guest@sharehack.com'
    }
  },
  methods: {
    async deleteUser() {
      await this.$axios
        .delete('api/v1/auth', {
          headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client')
          }
        })
        .then((response) => {
          this.$store.commit('authentication/setCurrentUser', {})
          this.$store.commit('authentication/setIsLoggedIn', false)
          this.$router.push('/')
        })
        .catch((error) => {
          return error
        })
    }
  }
}
</script>
