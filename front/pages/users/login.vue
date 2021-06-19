<template>
  <v-container>
    <v-card flat width="400px" class="mx-auto">
      <v-card-title class="justify-center">
        <h4>ログイン</h4>
      </v-card-title>
      <v-card-text>
        <validation-observer v-slot="{ invalid }">
          <v-form ref="form" lazy-validation>
            <TextField
              v-model="user.email"
              rules="required|email|max:256"
              icon="mdi-email"
              label="メールアドレス"
            />
            <PasswordField v-model="user.password" label="パスワード" />
            <v-card-actions>
              <v-btn
                block
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
            color="accent"
            class="white--text font-weight-bold"
            @click="guestLogin"
          >
            ゲストユーザーでログイン
          </v-btn>
        </v-card-actions>
        <v-card-actions class="mt-2 py-0 justify-center">
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
