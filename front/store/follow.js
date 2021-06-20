// export const state = () => ({
//   isFollowed: false
// })

// export const getters = {
//   isFollowed: (state) => state.isFollowed
// }

// export const mutations = {
//   setIsFollowed(state, followings, user) {
//     user.isFollowed = false
//     if (rootState.modules.user.data) {
//       user.followers.forEach(f => {
//         if (f.id === rootState.modules.user.data.id) {
//           user.isFollowed = true
//         }
//       })
//     }
//     commit('setData', user)
//   }
// }

// export const actions = {
//   async createFollow({ commit }, data) {
//     await this.$axios
//       .$post('/api/v1/relationships', {
//         user_id: data.userId,
//         follow_id: data.followId,
//         uid: data.uid
//       })
//       .then((response) => {
//         console.log('フォローに成功')
//         console.log(response)
//       })
//       .catch((error) => {
//         console.log('フォローに失敗')
//         console.log(error)
//       })
//   },
//   async deleteFollow({ commit }, data) {
//     await this.$axios
//       .$delete(`api/v1/relationships/${data.user_id}`, {
//         user_id: data.user_id,
//         follow_id: data.follow_id,
//         uid: data.uid
//       })
//       .then((response) => {
//         console.log('フォロー解除に成功')
//         console.log(response)
//       })
//       .catch((error) => {
//         console.log('フォロー解除に失敗')
//         console.log(error)
//       })
//   }
// }
