<template>
  <v-card flat>
    <v-card-text>
      <validation-observer v-slot="{ invalid }">
        <v-form ref="form" lazy-validation>
          <TextField
            v-model="name"
            rules="required|max:30"
            icon="mdi-account"
            label="ユーザー名"
          />
          <PasswordField v-model="password" label="パスワード" />
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
                  @click="editProfile"
                >
                  プロフィールを変更する
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
import TextField from '~/components/input/TextField.vue'
import PasswordField from '~/components/input/PasswordField.vue'

export default {
  components: {
    TextField,
    PasswordField
  },
  data() {
    return {
      name: '',
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
    this.name = this.currentUser.name
  },
  methods: {
    ...mapActions({
      showMessage: 'flashMessage/showMessage'
    }),
    async editProfile() {
      await this.$axios
        .put(
          'api/v1/auth',
          {
            name: this.name,
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
            text: 'ユーザー名を変更しました。',
            type: 'success',
            status: true
          })
        })
        .catch((error) => {
          this.showMessage({
            text: 'ユーザー名の変更に失敗しました。',
            type: 'error',
            status: true
          })
          return error
        })
    }
  }
}
</script>
