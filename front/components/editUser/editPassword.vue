<template>
  <v-card flat>
    <v-card-title class="justify-center font-weight-bold">
      パスワード
    </v-card-title>
    <v-card-text>
      <v-form ref="form" lazy-validation>
        <v-text-field
          v-model="user.password"
          :type="showPassword ? 'text' : 'password'"
          prepend-icon="mdi-lock"
          :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
          label="新しいパスワード"
          @click:append="showPassword = !showPassword"
        />
        <v-text-field
          v-model="user.password_confirmation"
          :type="showConfirmPassword ? 'text' : 'password'"
          prepend-icon="mdi-lock"
          :append-icon="showConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
          label="新しいパスワード(確認用)"
          @click:append="showConfirmPassword = !showConfirmPassword"
        />
        <v-card-actions>
          <v-btn
            v-if="userEmail != guest"
            block
            rounded
            color="light-green darken-1"
            class="white--text"
            @click="editPassword"
          >
            パスワードを変更する
          </v-btn>
          <v-btn
            v-else
            block
            rounded
            disabled
            color="light-green darken-1"
            class="white--text"
          >
            ゲストユーザーのため変更できません
          </v-btn>
        </v-card-actions>
      </v-form>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  data() {
    return {
      user: {
        password: '',
        password_confirmation: ''
      },
      showPassword: false,
      showConfirmPassword: false,
      userEmail: this.$store.getters['authentication/currentUser'].uid,
      guest: 'guest@sharehack.com'
    }
  },
  methods: {
    async editPassword() {
      await this.$axios
        .put('api/v1/auth/password', this.user, {
          headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client')
          }
        })
        .then((response) => {
          this.$store.commit('authentication/setCurrentUser', response.data)
          this.$store.dispatch(
            'flashMessage/showMessage',
            {
              text: 'パスワードを変更しました。',
              type: 'success',
              status: true
            },
            { root: true }
          )
          console.log(response)
          console.log('パスワードの更新に成功')
        })
        .catch((error) => {
          console.log('パスワードの更新に失敗')
          console.log(error)
          return error
        })
    }
  }
}
</script>
