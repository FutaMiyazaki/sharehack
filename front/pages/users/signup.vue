<template>
  <v-container>
    <v-card flat width="400px" class="mx-auto">
      <v-card-title class="justify-center">
        <h4>新規登録</h4>
      </v-card-title>
      <v-card-text>
        <validation-observer v-slot="{ invalid }">
          <v-form ref="form" lazy-validation>
            <validation-provider
              v-slot="{ errors }"
              rules="required|max:30"
              mode="lazy"
            >
              <v-text-field
                v-model="user.name"
                auto-grow
                outlined
                rows="1"
                background-color="secondary"
                prepend-icon="mdi-account"
                label="ユーザー名"
                :error-messages="errors"
              />
            </validation-provider>
            <validation-provider
              v-slot="{ errors }"
              rules="required|email|max:256"
              mode="lazy"
            >
              <v-text-field
                v-model="user.email"
                auto-grow
                outlined
                rows="1"
                background-color="secondary"
                prepend-icon="mdi-email"
                type="email"
                label="メールアドレス"
                :error-messages="errors"
              />
            </validation-provider>
            <validation-provider
              v-slot="{ errors }"
              rules="required|max:50"
              mode="lazy"
            >
              <v-text-field
                v-model="user.password"
                auto-grow
                outlined
                rows="1"
                background-color="secondary"
                :type="showPassword ? 'text' : 'password'"
                prepend-icon="mdi-lock"
                :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                label="パスワード"
                :error-messages="errors"
                @click:append="showPassword = !showPassword"
              />
            </validation-provider>
            <validation-provider
              v-slot="{ errors }"
              rules="required|max:50"
              mode="lazy"
            >
              <v-text-field
                v-model="user.password_confirmation"
                auto-grow
                outlined
                rows="1"
                background-color="secondary"
                :type="showConfirmPassword ? 'text' : 'password'"
                prepend-icon="mdi-lock"
                :append-icon="showConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
                label="パスワード確認"
                :error-messages="errors"
                @click:append="showConfirmPassword = !showConfirmPassword"
              />
            </validation-provider>
            <v-card-actions>
              <v-btn
                block
                rounded
                color="primary"
                class="white--text font-weight-bold"
                :disabled="invalid"
                @click="signUpUser"
              >
                新規登録
              </v-btn>
            </v-card-actions>
          </v-form>
        </validation-observer>
        <v-divider class="my-3"></v-divider>
        <v-card-actions>
          <v-btn
            block
            rounded
            color="accent"
            class="white--text font-weight-bold"
            @click="guestLogin"
          >
            ゲストユーザーでログイン
          </v-btn>
        </v-card-actions>
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
      guest: {
        email: 'guest@sharehack.com',
        password: 'pwkkf3ST9uWW5XFe'
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
    },
    guestLogin() {
      this.login(this.guest)
    }
  }
}
</script>
