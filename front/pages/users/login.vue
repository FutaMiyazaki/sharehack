<template>
  <v-container>
    <v-card width="400px" class="mx-auto mt-5">
      <v-card-title class="justify-center">
        <h1 class="display-1">
          ログイン
        </h1>
      </v-card-title>
      <v-card-text>
        <v-form ref="form" lazy-validation>
          <v-text-field
            v-model="user.email"
            prepend-icon="mdi-email"
            label="メールアドレス"
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
              block
              color="light-green darken-1"
              class="white--text"
              @click="loginUser"
            >
              ログイン
            </v-btn>
          </v-card-actions>
        </v-form>
        <v-divider class="my-3"></v-divider>
        <v-card-actions>
          <v-btn
            block
            color="primary darken-1"
            class="white--text"
            @click="guestLogin"
          >
            ゲストユーザーでログイン
          </v-btn>
        </v-card-actions>
        <v-card-actions class="justify-center">
          アカウントをお持ちでない方はこちらから
        </v-card-actions>
        <v-card-actions class="pt-0 justify-center">
          <nuxt-link to="/users/signup">新規登録</nuxt-link>
        </v-card-actions>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data() {
    return {
      user: {
        email: '',
        password: ''
      },
      guest: {
        email: 'guest@sharehack.com',
        password: 'pwkkf3ST9uWW5XFe'
      },
      showPassword: false
    }
  },
  methods: {
    ...mapActions({
      login: 'authentication/login'
    }),
    loginUser() {
      this.login(this.user)
    },
    guestLogin() {
      this.login(this.guest)
    }
  }
}
</script>
