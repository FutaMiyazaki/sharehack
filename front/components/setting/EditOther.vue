<template>
  <v-row>
    <v-col cols="12" class="pb-0">
      <v-banner>その他の設定</v-banner>
    </v-col>
    <v-col cols="12" class="pt-0">
      <v-card flat>
        <v-card-text>
          <v-card-actions class="justify-center">
            <v-dialog v-model="dialog" width="500">
              <template v-slot:activator="{ on, attrs }">
                <v-row justify="center">
                  <v-col cols="12" sm="6">
                    <v-btn
                      text
                      block
                      rounded
                      color="warning"
                      v-bind="attrs"
                      v-on="on"
                    >
                      アカウントを削除する
                    </v-btn>
                  </v-col>
                </v-row>
              </template>
              <v-card class="py-2">
                <v-card-actions class="px-2 py-0">
                  <v-icon class="ml-auto" @click="dialog = false">
                    mdi-close
                  </v-icon>
                </v-card-actions>
                <v-card-title class="pt-1 justify-center text-subtitle-1">
                  本当にアカウントを削除しますか？
                </v-card-title>
                <v-divider class="mb-5" />
                <v-card-text class="text-center text-subtitle-2">
                  アカウントを削除するとこれまでの投稿や登録情報が削除され、元に戻すことはできません。よろしいでしょうか？
                </v-card-text>
                <v-card-actions class="justify-center">
                  <template v-if="currentUser.email == guest">
                    <p
                      color="warning"
                      class="text-center red--text text-decoration-underline"
                      @click="dialog = false"
                    >
                      ゲストユーザーのため削除できません
                    </p>
                  </template>
                  <template v-else>
                    <v-btn
                      rounded
                      depressed
                      class="font-weight-bold"
                      width="45%"
                      @click="dialog = false"
                    >
                      キャンセル
                    </v-btn>
                    <v-btn
                      rounded
                      color="warning"
                      class="white--text font-weight-bold"
                      width="45%"
                      @click="deleteUser"
                    >
                      OK
                    </v-btn>
                  </template>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-card-actions>
        </v-card-text>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data() {
    return {
      dialog: false,
      guest: 'guest@sharehack.com'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
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
