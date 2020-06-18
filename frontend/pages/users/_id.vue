<template>
  <el-main class="user_show_wrapper">
    <userInfoCard :user="$store.state.user" />
  </el-main>
</template>

<script>
import userInfoCard from '~/components/user-info-card.vue'
import userEditForm from '~/components/modals/user-edit-form.vue'
export default {
  async fetch({ params, $axios, store }){
    let baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    let data = await $axios.$get(baseUrl + `/api/users/${params.id}`)
    console.log('fetch')
    console.log(data)
    store.commit('setUser', data)
  },
  components: {
    userInfoCard
  }
}
</script>

<style>
.user_show_wrapper {
  min-height: 100vh;
  padding: 70px 15px;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>