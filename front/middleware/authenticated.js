// 未ログインユーザーはログインページへリダイレクト
export default function({ store, route, redirect }) {
  if (
    !store.getters['authentication/isLoggedIn'] &&
    route.fullPath !== '/' &&
    route.fullPath !== '/users/login' &&
    route.fullPath !== '/users/signup' &&
    route.fullPath !== `/item/${route.params.id}`
  ) {
    return redirect('/users/login')
  }
}
