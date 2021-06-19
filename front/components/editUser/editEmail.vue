<template>
  <v-card flat>
    <v-card-title class="font-weight-bold">
      メールアドレス
    </v-card-title>
    <v-card-text>
      <validation-observer v-slot="{ invalid }">
        <v-form ref="form" lazy-validation>
          <TextField
            v-model="user.email"
            rules="required|email|max:256"
            icon="mdi-email-edit"
            label="新しいメールアドレス"
          />
          <PasswordField v-model="user.password" label="パスワード" />
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
