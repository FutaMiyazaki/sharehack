<template>
  <v-card flat>
    <v-card-title class="font-weight-bold">
      プロフィール画像
    </v-card-title>
    <v-card-text>
      <validation-observer v-slot="{ invalid }">
        <v-form ref="form" lazy-validation>
          <validation-provider
            v-slot="{ errors, validate }"
            rules="required|size:5000"
          >
            <v-file-input
              counter
              outlined
              rows="1"
              background-color="secondary"
              :value="image"
              accept="image/*"
              truncate-length="25"
              prepend-icon="mdi-image"
              label="画像をアップロードする"
              :error-messages="errors"
              show-size
              @input="validate($event)"
              @change="setImage"
            />
          </validation-provider>
          <v-card-actions>
            <v-btn
              v-if="currentUser.email != guest"
              color="primary"
              class="white--text font-weight-bold d-block mx-auto"
              :disabled="invalid"
              @click="updateAvatar"
            >
              プロフィール画像を変更する
            </v-btn>
            <v-btn
              v-else
              disabled
              class="white--text font-weight-bold d-block mx-auto"
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
import { mapGetters, mapActions } from 'vuex'

export default {
  data() {
    return {
      image: null,
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
    setImage(e) {
      this.image = e
    },
    async updateAvatar() {
      const data = new FormData()
      const config = {
        headers: {
          'content-type': 'multipart/form-data'
        }
      }
      data.append('user[avatar]', this.image)
      data.append('user[uid]', localStorage.getItem('uid'))
      await this.$axios
        .patch(
          `api/v1/users/${this.currentUser.id}/update_avatar`,
          data,
          config
        )
        .then((response) => {
          console.log('画像の変更に成功')
          console.log(response)
          this.$router.push(`/users/${response.data.id}`)
          this.showMessage({
            text: 'プロフィール画像を変更しました。',
            type: 'success',
            status: true
          })
        })
        .catch((error) => {
          this.showMessage({
            text: 'プロフィール画像の変更に失敗しました。',
            type: 'error',
            status: true
          })
          return error
        })
    }
  }
}
</script>
