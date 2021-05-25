<template>
  <v-container>
    <v-card width="400px" class="mx-auto">
      <v-card-title class="justify-center">
        <h4>ログイン</h4>
      </v-card-title>
      <v-card-text>
        <validation-observer v-slot="{ invalid }">
          <v-form ref="form" lazy-validation>
            <validation-provider
              v-slot="{ errors }"
              rules="required|email|max:256"
              mode="lazy"
            >
              <v-text-field
                v-model="user.email"
                prepend-icon="mdi-email"
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
                :type="showPassword ? 'text' : 'password'"
                prepend-icon="mdi-lock"
                :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                label="パスワード"
                :error-messages="errors"
                @click:append="showPassword = !showPassword"
              />
            </validation-provider>
            <v-card-actions>
              <v-btn
                block
                rounded
                color="primary"
                class="white--text font-weight-bold"
                :disabled="invalid"
                @click="loginUser"
              >
                ログイン
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
