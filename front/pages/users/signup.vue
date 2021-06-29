<template>
  <v-container>
    <v-card flat width="400px" class="mx-auto">
      <v-card-title class="justify-center">
        <h4>新規登録</h4>
      </v-card-title>
      <v-card-text>
        <validation-observer v-slot="{ invalid }">
          <v-form ref="form" lazy-validation>
            <TextField
              v-model="user.name"
              rules="required|max:20"
              icon="mdi-account"
              label="ユーザー名"
            />
            <TextField
              v-model="user.email"
              rules="required|email|max:256"
              icon="mdi-email"
              label="メールアドレス"
            />
            <PasswordField v-model="user.password" label="パスワード" />
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
        <v-card-actions class="mt-2 py-0 justify-center">
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
import TextField from '~/components/input/TextField.vue'
import PasswordField from '~/components/input/PasswordField.vue'

export default {
  components: {
    TextField,
    PasswordField
  },
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
      showConfirmPassword: false
    }
  },
  methods: {
    ...mapActions({
      signUp: 'authentication/signUp',
      login: 'authentication/login'
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
