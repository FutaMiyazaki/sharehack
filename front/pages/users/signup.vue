<template>
  <v-container>
    <v-card width="400px" class="mx-auto">
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
                prepend-icon="mdi-account"
                label="ユーザー名"
              />
              <p v-show="errors.length" class="red--text ml-8">
                {{ errors[0] }}
              </p>
            </validation-provider>
            <validation-provider
              v-slot="{ errors }"
              rules="required|email|max:256"
              mode="lazy"
            >
              <v-text-field
                v-model="user.email"
                prepend-icon="mdi-email"
                type="email"
                label="メールアドレス"
              />
              <p v-show="errors.length" class="red--text ml-8">
                {{ errors[0] }}
              </p>
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
                @click:append="showPassword = !showPassword"
              />
              <p v-show="errors.length" class="red--text ml-8">
                {{ errors[0] }}
              </p>
            </validation-provider>
            <validation-provider
              v-slot="{ errors }"
              rules="required|max:50"
              mode="lazy"
            >
              <v-text-field
                v-model="user.password_confirmation"
                :type="showConfirmPassword ? 'text' : 'password'"
                prepend-icon="mdi-lock"
                :append-icon="showConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
                label="パスワード確認"
                @click:append="showConfirmPassword = !showConfirmPassword"
              />
              <p v-show="errors.length" class="red--text ml-8">
                {{ errors[0] }}
              </p>
            </validation-provider>
            <v-card-actions>
              <v-btn
                block
                rounded
                color="light-green darken-1"
                class="white--text"
                :disabled="invalid"
                @click="signUpUser"
              >
                新規登録
              </v-btn>
            </v-card-actions>
          </v-form>
        </validation-observer>
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
