<template>
  <v-card flat>
    <v-card-title class="font-weight-bold">
      プロフィール
    </v-card-title>
    <v-card-text>
      <validation-observer v-slot="{ invalid }">
        <v-form ref="form" lazy-validation>
          <TextField
            v-model="user.name"
            rules="required|max:30"
            icon="mdi-account"
            label="ユーザー名"
          />
          <PasswordField v-model="user.password" label="パスワード" />
          <v-card-actions>
            <v-btn
              v-if="userEmail != guest"
              rounded
              color="light-green darken-1"
              class="white--text d-block mx-auto"
              :disabled="invalid"
              @click="editProfile"
            >
              プロフィールを変更する
            </v-btn>
            <v-btn v-else rounded disabled class="white--text d-block mx-auto">
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
        name: this.$store.getters['authentication/currentUser'].name,
        password: ''
      },
      showPassword: false,
      userEmail: this.$store.getters['authentication/currentUser'].uid,
      guest: 'guest@sharehack.com'
    }
  },
  methods: {
    async editProfile() {
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
              text: 'プロフィールを変更しました。',
              type: 'success',
              status: true
            },
            { root: true }
          )
          console.log(response)
          console.log('プロフィールの更新に成功')
        })
        .catch((error) => {
          console.log('プロフィールの更新に失敗')
          console.log(error)
          return error
        })
    }
  }
}
</script>
