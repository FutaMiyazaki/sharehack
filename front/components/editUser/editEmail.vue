<template>
  <v-card flat>
    <v-card-title class="justify-center font-weight-bold">
      メールアドレス
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
              prepend-icon="mdi-email-edit"
              label="新しいメールアドレス"
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
          <v-card-actions>
            <v-btn
              v-if="userEmail != guest"
              block
              rounded
              color="light-green darken-1"
              class="white--text"
              :disabled="invalid"
              @click="editEmail"
            >
              メールアドレスを変更する
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
      </validation-observer>
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
          this.$store.commit('authentication/setCurrentUser', response.data)
          this.$store.dispatch(
            'flashMessage/showMessage',
            {
              text: 'メールアドレスを変更しました。',
              type: 'success',
              status: true
            },
            { root: true }
          )
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
