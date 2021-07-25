<template>
  <v-container class="pt-0">
    <PageHeader text="ログイン" />
    <v-row justify="center" class="mt-5">
      <v-col cols="12" md="5">
        <v-card flat class="mx-auto">
          <v-card-text>
            <validation-observer v-slot="{ invalid }">
              <v-form ref="form" lazy-validation>
                <TextField
                  v-model="user.email"
                  rules="required|email|max:256"
                  label="メールアドレス"
                />
                <PasswordField v-model="user.password" label="パスワード" />
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
                class="white--text font-weight-bold text-caption"
                @click="guestLogin"
              >
                ゲストユーザーでログイン
              </v-btn>
            </v-card-actions>
            <v-card-actions class="mt-2 py-0 justify-center">
              アカウントをお持ちでない方はこちらから
            </v-card-actions>
            <v-card-actions class="pt-0 justify-center">
              <TextLink link="/users/signup" text="新規登録" />
            </v-card-actions>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import TextLink from '~/components/layout/TextLink.vue'
import TextField from '~/components/input/TextField.vue'
import PasswordField from '~/components/input/PasswordField.vue'

export default {
  components: {
    PageHeader,
    TextLink,
    TextField,
    PasswordField
  },
  middleware: 'authenticated',
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
  },
  head() {
    return {
      title: 'ログイン'
    }
  }
}
</script>
