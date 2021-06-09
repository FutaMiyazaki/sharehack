<template>
  <v-card flat>
    <v-card-title class="font-weight-bold">
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
              outlined
              rows="1"
              background-color="secondary"
              prepend-icon="mdi-email-edit"
              label="新しいメールアドレス"
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
          <v-card-actions>
            <v-btn
              v-if="userEmail != guest"
              width="30vw"
              rounded
              color="primary"
              class="white--text d-block mx-auto"
              :disabled="invalid"
              @click="editEmail"
            >
              メールアドレスを変更する
            </v-btn>
            <v-btn v-else rounded disabled class="d-block mx-auto">
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
        })
        .catch((error) => {
          return error
        })
    }
  }
}
</script>
