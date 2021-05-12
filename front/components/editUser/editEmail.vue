<template>
  <v-card flat>
    <v-card-title class="justify-center font-weight-bold">
      メールアドレス
    </v-card-title>
    <v-card-text>
      <v-form ref="form" lazy-validation>
        <v-text-field
          v-model="user.email"
          prepend-icon="mdi-email-edit"
          label="新しいメールアドレス"
        />
        <v-text-field
          v-model="user.password"
          :type="showPassword ? 'text' : 'password'"
          prepend-icon="mdi-lock"
          :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
          label="パスワード"
          @click:append="showPassword = !showPassword"
        />
        <v-card-actions>
          <v-btn
            v-if="userEmail != guest"
            block
            rounded
            color="light-green darken-1"
            class="white--text"
            @click="editEmail"
          >
            変更する
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
        email: '',
        password: ''
      },
      showPassword: false,
      userEmail: this.$store.getters['authentication/currentUser'].uid,
      guest: 'guest@sharehack.com'
    }
  },
  methods: {
    async editEmail() {
      await this.$axios
        .put('api/v1/auth', this.user, {
          headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client')
          }
        })
        .then((response) => {
          console.log(response)
          this.$router.push('/')
          console.log('メールアドレスの更新に成功')
        })
        .catch((error) => {
          console.log('メールアドレスの更新に失敗')
          console.log(error)
          return error
        })
    }
  }
}
</script>
