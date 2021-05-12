<template>
  <v-card flat>
    <v-card-title class="justify-center font-weight-bold">
      その他の設定
    </v-card-title>
    <v-card-text>
      <v-card-actions class="justify-center">
        <v-dialog v-model="dialog" width="500">
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              v-if="userEmail != guest"
              text
              color="red lighten-2"
              v-bind="attrs"
              v-on="on"
            >
              アカウントを削除する
            </v-btn>
            <v-btn v-else text color="red lighten-2">
              ゲストユーザーはアカウントを削除できません
            </v-btn>
          </template>

          <v-card class="pa-5">
            <v-card-title class="justify-center">
              本当にアカウントを削除しますか？
            </v-card-title>
            <v-card-text class="justify-center">
              アカウントを削除するとこれまでの投稿や登録情報が削除され、元に戻すことはできません。よろしいでしょうか？
            </v-card-text>
            <v-card-actions class="justify-center">
              <v-btn
                color="red"
                rounded
                outlined
                class="text--white"
                @click="dialog = false"
                width="100px"
              >
                キャンセル
              </v-btn>
              <v-btn
                rounded
                color="red"
                class="text--white"
                @click="deleteUser"
                width="100px"
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
          console.log(response)
          this.$store.commit('authentication/setCurrentUser', {})
          this.$store.commit('authentication/setIsLoggedIn', false)
          this.$router.push('/')
          console.log('アカウントの削除に成功')
        })
        .catch((error) => {
          console.log('アカウントの削除に失敗')
          console.log(error)
          return error
        })
    }
  }
}
</script>
