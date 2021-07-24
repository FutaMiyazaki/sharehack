<template>
  <v-container class="pt-0 pb-10">
    <PageHeader text="トピック編集" />
    <validation-observer v-slot="{ invalid }">
      <v-form ref="form" lazy-validation class="mt-5">
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel label-title="タイトルを入力" label-text="30文字以内" />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <TextField
              v-model="topic.title"
              rules="required|max:30"
              label="タイトル"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel label-title="説明を入力" label-text="300文字以内" />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <TextArea
              v-model="topic.description"
              rules="required|max:300"
              label="説明"
            />
          </v-col>
        </v-row>
        <v-row justify="center">
          <v-col cols="12" sm="4">
            <v-btn
              v-if="!loadShow"
              block
              rounded
              color="primary"
              class="white--text font-weight-bold d-block mx-auto"
              :disabled="invalid"
              @click="updateTopic"
            >
              変更を保存する
            </v-btn>
            <Loading v-show="loadShow" />
          </v-col>
        </v-row>
      </v-form>
    </validation-observer>
    <v-divider class="my-8" />
    <v-dialog v-model="dialog" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-row justify="center">
          <v-col cols="12" sm="4" class="text-center">
            <v-btn text rounded color="warning" v-bind="attrs" v-on="on">
              トピックを削除する
            </v-btn>
          </v-col>
        </v-row>
      </template>
      <v-card class="py-2">
        <v-card-actions class="px-2 py-0">
          <v-icon class="ml-auto" @click="dialog = false">
            mdi-close
          </v-icon>
        </v-card-actions>
        <v-card-title class="pt-1 justify-center text-subtitle-1">
          本当にこのトピックを削除しますか？
        </v-card-title>
        <v-divider class="mb-5" />
        <v-card-text class="text-center text-subtitle-2">
          ※この操作は取り消せません
        </v-card-text>
        <v-card-actions class="justify-center pb-5">
          <template v-if="currentUser && currentUser.email != guestUserEmail">
            <v-btn
              rounded
              depressed
              class="font-weight-bold"
              width="100px"
              @click="dialog = false"
            >
              キャンセル
            </v-btn>
            <v-btn
              v-if="!loadShow"
              rounded
              color="red"
              class="white--text font-weight-bold"
              width="100px"
              @click="deleteTopic"
            >
              削除する
            </v-btn>
            <Loading v-show="loadShow" />
          </template>
          <template v-else>
            <p
              color="warning"
              class="text-center red--text text-decoration-underline"
              @click="dialog = false"
            >
              ゲストユーザーのため削除できません
            </p>
          </template>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-row justify="center">
      <v-col cols="12" sm="4" class="text-center">
        <LinkButton
          :link="'/topic/' + topic.id"
          text="前のページに戻る"
          icon="chevron-right"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import FormLabel from '~/components/layout/FormLabel.vue'
import TextField from '~/components/input/TextField.vue'
import TextArea from '~/components/input/TextArea.vue'
import Loading from '~/components/layout/Loading.vue'
import LinkButton from '~/components/layout/LinkButton.vue'

export default {
  components: {
    PageHeader,
    FormLabel,
    TextField,
    TextArea,
    Loading,
    LinkButton
  },
  middleware: 'unAuthenticated',
  data() {
    return {
      dialog: false,
      loadShow: false,
      guestUserEmail: 'guest@sharehack.com',
      topic: {
        id: '',
        title: '',
        description: ''
      }
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
  },
  created() {
    this.$axios
      .get(`api/v1/topics/${this.$route.params.id}/fetch`)
      .then((response) => {
        this.topic = response.data
      })
      .catch((error) => {
        return error
      })
  },
  methods: {
    ...mapActions({
      showMessage: 'flashMessage/showMessage'
    }),
    async updateTopic() {
      this.loadShow = true
      await this.$axios
        .patch(`api/v1/topics/${this.topic.id}`, {
          title: this.topic.title,
          description: this.topic.description,
          user_id: this.currentUser.id,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          this.loadShow = false
          this.$router.push(`/topic/${response.data.id}`)
          this.showMessage({
            text: 'トピックの編集に成功しました',
            status: true
          })
        })
        .catch((error) => {
          this.loadShow = false
          this.showMessage({
            text: 'トピックの編集に失敗しました',
            status: true
          })
          return error
        })
    },
    async deleteTopic() {
      this.loadShow = true
      await this.$axios
        .delete(`api/v1/topics/${this.$route.params.id}`, {
          params: {
            user_id: this.currentUser.id,
            uid: localStorage.getItem('uid')
          }
        })
        .then((response) => {
          this.loadShow = false
          this.$router.push('/topic/list?page=1')
          this.showMessage({
            text: 'トピックを削除しました',
            status: true
          })
        })
        .catch((error) => {
          this.loadShow = false
          this.showMessage({
            text: 'トピックの削除に失敗しました',
            status: true
          })
          return error
        })
    }
  },
  head() {
    return {
      title: 'トピックを編集する'
    }
  }
}
</script>
