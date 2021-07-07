<template>
  <v-card flat>
    <v-card-text class="mt-5">
      <validation-observer v-slot="{ invalid }">
        <v-form ref="form" lazy-validation>
          <PasswordField v-model="password" label="新しいパスワード" />
          <validation-provider
            v-slot="{ errors }"
            rules="required|max:50"
            mode="lazy"
          >
            <v-text-field
              v-model="password_confirmation"
              outlined
              rows="1"
              background-color="secondary"
              :type="showConfirmPassword ? 'text' : 'password'"
              prepend-icon="mdi-lock"
              :append-icon="showConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
              label="新しいパスワード(確認用)"
              :error-messages="errors"
              @click:append="showConfirmPassword = !showConfirmPassword"
            />
          </validation-provider>
          <v-card-actions>
            <v-row justify="center">
              <v-col cols="12" sm="6">
                <v-btn
                  v-if="currentUser.email != guest"
                  block
                  rounded
                  color="primary"
                  class="white--text font-weight-bold d-block mx-auto"
                  :disabled="invalid"
                  @click="editPassword"
                >
                  パスワードを変更する
                </v-btn>
                <v-btn
                  v-else
                  block
                  rounded
                  disabled
                  class="white--text font-weight-bold d-block mx-auto"
                >
                  ゲストユーザーのため変更できません
                </v-btn>
              </v-col>
            </v-row>
          </v-card-actions>
        </v-form>
      </validation-observer>
    </v-card-text>
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PasswordField from '~/components/input/PasswordField.vue'

export default {
  components: {
    PasswordField
  },
  data() {
    return {
      password: '',
      password_confirmation: '',
      showConfirmPassword: false,
      guest: 'guest@sharehack.com'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
  },
  methods: {
    ...mapActions({
      showMessage: 'flashMessage/showMessage'
    }),
    async editPassword() {
      await this.$axios
        .put('api/v1/auth/password', this.user, {
          headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client')
          }
        })
        .then((response) => {
          this.$router.push(`/users/${this.currentUser.id}`)
          this.showMessage({
            text: 'パスワードを変更しました。',
            type: 'success',
            status: true
          })
        })
        .catch((error) => {
          this.showMessage({
            text: 'パスワードの変更に失敗しました。',
            type: 'error',
            status: true
          })
          return error
        })
    }
  }
}
</script>
