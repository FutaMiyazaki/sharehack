<template>
  <v-container>
    <v-card width="400px" class="mx-auto">
      <v-card-title class="justify-center">
        <h4>新規登録</h4>
      </v-card-title>
      <v-card-text>
        <v-form ref="form" lazy-validation>
          <v-text-field
            v-model="user.name"
            prepend-icon="mdi-account"
            label="ユーザー名"
          />
          <v-text-field
            v-model="user.email"
            prepend-icon="mdi-email"
            type="email"
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
          <v-text-field
            v-model="user.password_confirmation"
            :type="showConfirmPassword ? 'text' : 'password'"
            prepend-icon="mdi-lock"
            :append-icon="showConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
            label="パスワード確認"
            @click:append="showConfirmPassword = !showConfirmPassword"
          />
          <v-card-actions>
            <v-btn
              block
              rounded
              color="light-green darken-1"
              class="white--text"
              @click="signUpUser"
            >
              新規登録
            </v-btn>
          </v-card-actions>
        </v-form>
        <v-divider class="my-3"></v-divider>
        <v-card-actions class="py-0 justify-center">
          アカウントをお持ちの方はこちらから
        </v-card-actions>
        <v-card-actions class="pt-0 justify-center">
          <nuxt-link to="/users/login">ログイン</nuxt-link>
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
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      },
      showPassword: false,
      showConfirmPassword: false
    }
  },
  methods: {
    ...mapActions({
      signUp: 'authentication/signUp'
    }),
    signUpUser() {
      this.signUp(this.user)
    }
  }
}
</script>
