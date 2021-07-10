<template>
  <v-card flat>
    <v-card-text>
      <validation-observer v-slot="{ invalid }">
        <v-form ref="form" lazy-validation>
          <TextField
            v-model="email"
            rules="required|email|max:256"
            label="新しいメールアドレス"
          />
          <PasswordField v-model="password" label="パスワード" />
          <v-card-actions class="justify-center">
            <v-row v-if="currentUser.email != guest" justify="center">
              <v-col cols="12" sm="4">
                <v-btn
                  block
                  rounded
                  color="primary"
                  class="white--text font-weight-bold d-block mx-auto"
                  :disabled="invalid"
                  @click="editEmail"
                >
                  メールアドレスを変更
                </v-btn>
              </v-col>
            </v-row>
            <p v-if="currentUser.email == guest" class="font-weight-bold">
              ゲストユーザーのため変更できません
            </p>
          </v-card-actions>
        </v-form>
      </validation-observer>
    </v-card-text>
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import TextField from '~/components/input/TextField.vue'
import PasswordField from '~/components/input/PasswordField.vue'

export default {
  components: {
    TextField,
    PasswordField
  },
  data() {
    return {
      email: '',
      password: '',
      guest: 'guest@sharehack.com'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
  },
  created() {
    this.email = this.currentUser.email
  },
  methods: {
    ...mapActions({
      showMessage: 'flashMessage/showMessage'
    }),
    async editEmail() {
      await this.$axios
        .put(
          'api/v1/auth',
          {
            email: this.email,
            password: this.password
          },
          {
            headers: {
              'access-token': localStorage.getItem('access-token'),
              uid: localStorage.getItem('uid'),
              client: localStorage.getItem('client')
            }
          }
        )
        .then((response) => {
          this.$router.push(`/users/${this.currentUser.id}`)
          this.showMessage({
            text: 'メールアドレスを変更しました。',
            type: 'success',
            status: true
          })
        })
        .catch((error) => {
          this.showMessage({
            text: 'メールアドレスの変更に失敗しました。',
            type: 'error',
            status: true
          })
          return error
        })
    }
  }
}
</script>
