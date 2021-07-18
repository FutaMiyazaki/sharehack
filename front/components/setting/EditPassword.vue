<template>
  <v-row>
    <v-col cols="12" class="pb-0">
      <v-banner>パスワード</v-banner>
    </v-col>
    <v-col cols="12" class="pt-0">
      <v-card flat>
        <v-card-text class="pt-8">
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
                  :append-icon="showConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
                  label="新しいパスワード(確認用)"
                  :error-messages="errors"
                  @click:append="showConfirmPassword = !showConfirmPassword"
                />
              </validation-provider>
              <v-card-actions class="justify-center">
                <v-row v-if="currentUser.email != guest" justify="center">
                  <v-col cols="12" sm="4">
                    <v-btn
                      block
                      rounded
                      color="primary"
                      class="white--text font-weight-bold d-block mx-auto"
                      :disabled="invalid"
                      @click="editPassword"
                    >
                      パスワードを変更
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
    </v-col>
  </v-row>
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
